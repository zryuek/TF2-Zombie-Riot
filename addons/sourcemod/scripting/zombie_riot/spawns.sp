#pragma semicolon 1
#pragma newdecls required

#define BASE_SPAWNER_COOLDOWN 0.30

enum struct SpawnerData
{
	int EntRef;
	bool BaseBoss;
	bool AllySpawner;
	char Name[64];
	bool ignore_disabled;

	float Cooldown;
	float Points;
	bool Enabled;
}

static ArrayList SpawnerList;
static ConVar MapSpawnersActive;
static float HighestPoints;
static float LastNamedSpawn;
static int BadSpotPoints[MAXTF2PLAYERS];

void Spawns_PluginStart()
{
	MapSpawnersActive = CreateConVar("zr_spawnersactive", "4", "How many spawners are active by default,", _, true, 0.0, true, 32.0);
}

void Spawns_MapEnd()
{
	delete SpawnerList;
	LastNamedSpawn = 0.0;
}

bool Spawns_CanSpawnNext(bool rogue)
{
	float gameTime = GetGameTime();

	if(rogue)
	{
		if(LastNamedSpawn > gameTime)
			return false;
		
		LastNamedSpawn = gameTime + (BASE_SPAWNER_COOLDOWN / MultiGlobalEnemy);
		return true;
	}

	SpawnerData spawn;

	//bool error = true;
	int length = SpawnerList.Length;
	for(int i; i < length; i++)
	{
		SpawnerList.GetArray(i, spawn);
		
		if(!spawn.Enabled || spawn.AllySpawner)	// Disabled, ignore
		{
			continue;
		}
		
		if(!IsValidEntity(spawn.EntRef))	// Invalid entity, remove
		{
			SpawnerList.Erase(i);
			i--;
			length--;
			continue;
		}
		
		if(!spawn.BaseBoss)
		{
			if(GetEntProp(spawn.EntRef, Prop_Data, "m_bDisabled"))	// Map disabled, ignore
				continue;
		}

		if(spawn.Points <= 0.0)	// Map disabled, ignore
			continue;
		
		if(spawn.Cooldown < gameTime)
			return true;
	}

	return false;
}

bool Spawns_GetNextPos(float pos[3], float ang[3], const char[] name = NULL_STRING, float cooldownOverride = -1.0)
{
	SpawnerData spawn;
	float gameTime = GetGameTime();

	int bestIndex = -1;
	float bestPoints = 0.0;

	int nonBossSpawners;
	int length = SpawnerList.Length;
	for(int i; i < length; i++)
	{
		SpawnerList.GetArray(i, spawn);
		
		if(name[0])
		{
			if(!StrEqual(name, spawn.Name))	// Invalid name, ignore
				continue;
		}
		else if(!spawn.Enabled || spawn.AllySpawner)	// Disabled, ignore
		{
			continue;
		}
		
		if(!IsValidEntity(spawn.EntRef))	// Invalid entity, remove
		{
			SpawnerList.Erase(i);
			i--;
			length--;
			continue;
		}

		if(!spawn.BaseBoss)
		{
			if(GetEntProp(spawn.EntRef, Prop_Data, "m_bDisabled") && !spawn.AllySpawner)	// Map disabled, ignore, except if its an ally one.
				continue;

			nonBossSpawners++;
		}
		
		if((spawn.Cooldown < gameTime && spawn.Points >= bestPoints) || (name[0] && bestIndex == -1))
		{
			bestIndex = i;
			bestPoints = spawn.Points;
		}
	}

	if(bestIndex == -1 && name[0])	// Fallback to case checks for spawn names
	{
		for(int i; i < length; i++)
		{
			SpawnerList.GetArray(i, spawn);
			if(StrContains(name, spawn.Name) == -1)	// Invalid name, ignore
				continue;
			
			if(!IsValidEntity(spawn.EntRef))	// Invalid entity, remove
			{
				SpawnerList.Erase(i);
				i--;
				length--;
				continue;
			}

			if(!spawn.BaseBoss)
			{
				if(GetEntProp(spawn.EntRef, Prop_Data, "m_bDisabled") && !spawn.AllySpawner)	// Map disabled, ignore, except if its an ally one.
					continue;

				nonBossSpawners++;
			}
			
			if(bestIndex == -1 || (spawn.Cooldown < gameTime && spawn.Points >= bestPoints))
			{
				bestIndex = i;
				bestPoints = spawn.Points;
			}
		}
	}

	if(bestIndex == -1)
		return false;
	
	SpawnerList.GetArray(bestIndex, spawn);
	GetEntPropVector(spawn.EntRef, Prop_Data, "m_vecOrigin", pos);
	GetEntPropVector(spawn.EntRef, Prop_Data, "m_angRotation", ang);
	if(cooldownOverride < 0.0)	// Normal cooldown time
	{
		if(nonBossSpawners == 1)
		{
			spawn.Cooldown = gameTime + (BASE_SPAWNER_COOLDOWN / MultiGlobalEnemy);
		}
		else if(name[0])
		{
			float playerSpeedUp = 1.0 + (MultiGlobalEnemy * 0.5);
			float baseTime = 2.0 + (nonBossSpawners * 0.15);

			spawn.Cooldown = gameTime + (baseTime / playerSpeedUp);
		}
		else
		{
			float nearSpeedUp = 4.0 * (spawn.Points / HighestPoints);
			if(nearSpeedUp < 1.0)
				nearSpeedUp = 1.0;

			float playerSpeedUp = 1.0 + (MultiGlobalEnemy * 0.5);
			
			float baseTime = 2.0 + (nonBossSpawners * 0.15);

			// player = 1.0 + (1.5) = 2.5
			// baseTime = 2.0 + (6 * 0.15) = 2.9
			// 2.9 / 2.5 = 1.16 slowest
			// 1.16 / 4 = 0.29 fastest

			spawn.Cooldown = gameTime + (baseTime / nearSpeedUp / playerSpeedUp);
		}
	}
	else	// Override cooldown time
	{
		spawn.Cooldown = gameTime + cooldownOverride;
	}

	Rogue_Paradox_SpawnCooldown(spawn.Cooldown);
	
	SpawnerList.SetArray(bestIndex, spawn);
	return true;
}

void Spawns_AddToArray(int ref, bool base_boss = false, bool allyspawner = false)
{
	if(!SpawnerList)
		SpawnerList = new ArrayList(sizeof(SpawnerData));
	
	if(SpawnerList.FindValue(ref, SpawnerData::EntRef) == -1)
	{
		SpawnerData spawn;

		spawn.EntRef = ref;
		spawn.BaseBoss = base_boss;
		spawn.AllySpawner = allyspawner;
		GetEntPropString(ref, Prop_Data, "m_iName", spawn.Name, sizeof(spawn.Name));

		SpawnerList.PushArray(spawn);
	}
}

void Spawns_RemoveFromArray(int entity)
{
	int index = SpawnerList.FindValue(entity, SpawnerData::EntRef);
	if(index != -1)
		SpawnerList.Erase(index);
}

void Spawners_Timer()
{
	if(!SpawnerList)
		return;
	
	float f3_PositionTemp_2[3];
	float f3_PositionTemp[3];
		
	SpawnerData spawn;
	int length = SpawnerList.Length;
	for(int index; index < length; index++)
	{
		SpawnerList.GetArray(index, spawn);
		if(!IsValidEntity(spawn.EntRef))	// Invalid entity, remove
		{
			SpawnerList.Erase(index);
			index--;
			length--;
			continue;
		}
		spawn.Points = 0.0;
		SpawnerList.SetArray(index, spawn);	
	}
	int PlayersGathered = 0;
	for(int client=1; client<=MaxClients; client++)
	{
		if(IsClientInGame(client))
		{
			if(GetClientTeam(client)==2 && TeutonType[client] == TEUTON_NONE && dieingstate[client] == 0 && IsPlayerAlive(client))
			{
				PlayersGathered ++;
				GetEntPropVector(client, Prop_Data, "m_vecAbsOrigin", f3_PositionTemp);

				for(int index; index < length; index++)
				{
					SpawnerList.GetArray(index, spawn);
					if(spawn.AllySpawner)
						continue;
					
					int entity_Ref = spawn.EntRef;
					
					if(!spawn.BaseBoss && GetEntProp(entity_Ref, Prop_Data, "m_bDisabled"))
					{
						continue;
					}
						
					GetEntPropVector(entity_Ref, Prop_Data, "m_vecAbsOrigin", f3_PositionTemp_2);
					float distance = GetVectorDistance( f3_PositionTemp, f3_PositionTemp_2, true); 
					//leave it all squared for optimsation sake!
					//max distance is 10,000 anymore and wtf u doin
					if( distance < 100000000.0)
					{
						//For Zr_lila_panic.
						if(StrEqual(spawn.Name, "underground"))
						{
							if(!b_PlayerIsInAnotherPart[client])
							{
								continue;
							}
						}
						if(b_PlayerIsInAnotherPart[client])
						{
							if(!StrEqual(spawn.Name, "underground"))
							{
								continue;
							}
						}
							
						float inverting_score_calc;
						inverting_score_calc = ( distance / 100000000.0);
						inverting_score_calc -= 1.0;
						inverting_score_calc *= -1.0;
                        
						spawn.Points += inverting_score_calc;
						SpawnerList.SetArray(index, spawn);							
					}
				}
			}
		}
	}

	// Get max spawner count
	int maxSpawners = MapSpawnersActive.IntValue;
	if(maxSpawners < 1)
		maxSpawners = 1;

	// Get list of points
	ArrayList pointsList = new ArrayList();

	for(int index; index < length; index++)
	{
		SpawnerList.GetArray(index, spawn);
		if(spawn.Points > 0.0)
		{
			spawn.Points /= PlayersGathered;
		}
		else
		{
			spawn.Points = 0.0;
		}
		SpawnerList.SetArray(index, spawn);
	}

	for(int index; index < length; index++)
	{
		SpawnerList.GetArray(index, spawn);
		if(spawn.BaseBoss)
			maxSpawners++;
		
		pointsList.Push(spawn.Points);
	}
	
	if(maxSpawners > length)
		maxSpawners = length;
	
	if(length)
	{
		// Sort points
		pointsList.Sort(Sort_Descending, Sort_Float);
		
		// Get points of the X ranked score
		HighestPoints = pointsList.Get(0);
		float minPoints = pointsList.Get(maxSpawners - 1);
		
		// Enable if meet requirement
		for(int index; index < length; index++)
		{
			SpawnerList.GetArray(index, spawn);

			if(spawn.Points <= 0.0)
			{
				spawn.Enabled = false;
			}
			else
			{
				spawn.Enabled = spawn.Points >= minPoints;
			}
			SpawnerList.SetArray(index, spawn);
		}
	}

	delete pointsList;
}

int GetRandomActiveSpawner(const char[] name = "")
{
	SpawnerData spawn;
	
	int length = SpawnerList.Length;
	for(int i; i < length; i++)
	{
		SpawnerList.GetArray(i, spawn);
		
		if(name[0])
		{
			if(!StrEqual(name, spawn.Name))	// Invalid name, ignore
				continue;
		}
		else if(!spawn.Enabled || spawn.AllySpawner)	// Disabled, ignore
		{
			continue;
		}
		
		if(!IsValidEntity(spawn.EntRef))	// Invalid entity, remove
		{
			SpawnerList.Erase(i);
			i--;
			length--;
			continue;
		}

		if(!spawn.BaseBoss && GetEntProp(spawn.EntRef, Prop_Data, "m_bDisabled") && !spawn.AllySpawner)	// Map disabled, ignore
			continue;
		
		return spawn.EntRef;
	}
	return -1;
}

void Spawns_CheckBadClient(int client)
{
	if(!IsPlayerAlive(client) || TeutonType[client] != TEUTON_NONE)
	{
		BadSpotPoints[client] = 0;
		return;
	}

	if(!(GetEntityFlags(client) & (FL_ONGROUND|FL_INWATER)))
	{
		// In air or water
		BadSpotPoints[client]++;
		return;
	}

	if(Waves_InSetup())
		return;

	int RefGround =  GetEntPropEnt(client, Prop_Send, "m_hGroundEntity");
	int GroundEntity = EntRefToEntIndex(RefGround);
	if(GroundEntity > 0 && GroundEntity < MAXENTITIES)
	{
		//client is ontop of something, dont do more, they have some way to be put down.
		return;
	}

	int bad;

	float pos1[3], pos2[3];
	WorldSpaceCenter(client, pos1);
	CNavArea area = TheNavMesh.GetNearestNavArea(pos1, false, 100.0, false, true);
	if(area == NULL_AREA)
	{
		// Not near a nav mesh, bad
		bad = 5;
		BadSpotPoints[client] += 5;
	}
	else
	{
		int npcs;
		for(int i; i < i_MaxcountNpcTotal; i++)
		{
			int entity = EntRefToEntIndex(i_ObjectsNpcsTotal[i]);
			if(IsValidEntity(entity) && !b_NpcHasDied[entity] && GetTeam(entity) != TFTeam_Red)
			{
				WorldSpaceCenter(client, pos2);
				CNavArea startArea = TheNavMesh.GetNavArea(pos2);
				if(startArea == NULL_AREA)
					continue;	// NPC on a bad nav??

				if(!TheNavMesh.BuildPath(startArea, area, pos1))
				{
					bad++;
					BadSpotPoints[client]++;
				}
				
				if(npcs++ > 4)
					break;
			}
		}
	}

	if(bad > 4)
	{
		if(BadSpotPoints[client] > 29)
		{
			float damage = 5.0;
			NpcStuckZoneWarning(client, damage, 0);	
			if(damage >= 0.25)
			{
				SDKHooks_TakeDamage(client, 0, 0, damage, DMG_DROWN|DMG_PREVENT_PHYSICS_FORCE, -1, _, _, _, ZR_STAIR_ANTI_ABUSE_DAMAGE);
			}
		}
	}
	else if(BadSpotPoints[client] > 0)
	{
		BadSpotPoints[client]--;
	}

	/*
	public native bool BuildPath( CNavArea startArea, 
		CNavArea goalArea, 
		const float goalPos[3], 
		NavPathCostFunctor costFunc = INVALID_FUNCTION,
		CNavArea &closestArea = NULL_AREA, 
		float maxPathLength = 0.0,
		int teamID = TEAM_ANY,
		bool ignoreNavBlockers = false);
	*/
}
