static bool HeavyWind;
static bool ExtremeHeat;
static bool RedMoon;
static Handle FrostTimer;
static ArrayList WinterTheme;

bool Rogue_Paradox_ExtremeHeat()
{
	return ExtremeHeat;
}

bool Rogue_Paradox_RedMoon()
{
	return RedMoon;
}

void Rogue_Paradox_MapStart()
{
	delete WinterTheme;
}

void Rogue_Paradox_AddWinterNPC(int id)
{
	if(!WinterTheme)
		WinterTheme = new ArrayList();
	
	WinterTheme.Push(id);
}

void Rogue_Paradox_SpawnCooldown(float &time)
{
	if(ExtremeHeat)
	{
		float gameTime = GetGameTime();
		float cooldown = time - gameTime;
		cooldown *= 3.0;
		time = gameTime + cooldown;
	}
}

void Rogue_Paradox_ReviveSpeed(int &amount)
{
	if(ExtremeHeat)
		amount /= 2;
}

bool Rogue_Paradox_JesusBlessing(int client, int &healing_Amount)
{
	if(FrostTimer && dieingstate[client] == 0)
	{
		int health = GetClientHealth(client);
		if(health > 1)
		{
			int maxhealth = SDKCall_GetMaxHealth(client);

			// Degen if no blessing or above 50% health
			if(Jesus_Blessing[client] != 1 || (health > maxhealth / 2))
			{
				int damage = maxhealth / -100;
				health += damage;
				if(health < 1)
				{
					damage = 1 - health;
					health = 1;
				}

				healing_Amount += damage;
				SetEntityHealth(client, health);
			}
		}

		return true;	// Override Jesus Blessing
	}

	return false;
}

void Rogue_Paradox_ProjectileSpeed(int owner, float &speed)
{
	if(HeavyWind && !b_NpcHasDied[owner])	// NPCs
	{
		NPCData data;
		NPC_GetById(i_NpcInternalId[owner], data);
		speed *= data.Category == Type_Expidonsa ? 1.25 : 0.67;
	}
}

public void Rogue_HeavyWind_Weapon(int entity)
{
	Attributes_SetMulti(entity, 103, 0.67);
}

public void Rogue_HeavyRain_Ally(int entity, StringMap map)
{
	if(map)	// Player
	{
		float value;

		// +20% move speed
		map.GetValue("107", value);
		map.SetValue("107", value * 0.8);
	}
	else if(!b_NpcHasDied[entity])	// NPCs
	{
		BarrackBody npc = view_as<BarrackBody>(entity);
		if(npc.OwnerUserId)	// Barracks Unit
		{
			fl_Extra_Speed[entity] *= 0.8;
		}
	}
}

public void Rogue_HeavyRain_Enemy(int entity)
{
	if(view_as<CClotBody>(entity).m_iBleedType == BLEEDTYPE_SEABORN)
	{
		fl_Extra_Speed[entity] *= 1.1;
	}
	else
	{
		fl_Extra_Speed[entity] *= 0.8;
	}
}

public void Rogue_Curse_HeavyRain(bool enable)
{
	if(enable)
	{
		Rogue_GiveNamedArtifact("Heavy Rain", true);
	}
	else
	{
		Rogue_RemoveNamedArtifact("Heavy Rain");
	}
}

public void Rogue_Curse_ExtremeHeat(bool enable)
{
	ExtremeHeat = enable;
}

public void Rogue_Curse_HeavyWind(bool enable)
{
	HeavyWind = enable;

	if(enable)
	{
		Rogue_GiveNamedArtifact("Heavy Wind", true);
	}
	else
	{
		Rogue_RemoveNamedArtifact("Heavy Wind");
	}
}

public void Rogue_Curse_DenseFrost(bool enable)
{
	delete FrostTimer;

	if(enable)
		FrostTimer = CreateTimer(0.25, Timer_ParadoxFrost, _, TIMER_REPEAT);
}

public void Rogue_Curse_RedMoon(bool enable)
{
	RedMoon = enable;
}

static Action Timer_ParadoxFrost(Handle timer)
{
	for(int i; i < i_MaxcountNpcTotal; i++)
	{
		int entity = EntRefToEntIndex(i_ObjectsNpcsTotal[i]);
		if(entity != INVALID_ENT_REFERENCE && IsEntityAlive(entity))
		{
			if(WinterTheme && WinterTheme.FindValue(i_NpcInternalId[entity]) != -1)
				continue;
			
			int health = GetEntProp(entity, Prop_Data, "m_iHealth");
			if(health > 1)
			{
				int damage = GetEntProp(entity, Prop_Data, "m_iMaxHealth") / 400;
				if(damage > 125)
					damage = 125;
				
				health -= damage;
				if(health < 1)
					health = 1;
				
				SetEntProp(entity, Prop_Data, "m_iHealth", health);
			}
		}
	}

	return Plugin_Continue;
}
