#pragma semicolon 1
#pragma newdecls required

static float Hose_Velocity = 1000.0;
static float Hose_BaseHeal = 4.0;
static float Hose_UberGain = 0.0025;
static float Hose_UberTime = 6.0;
static float Hose_ShotgunChargeMult = 3.0;
static float SelfHealMult = 0.33;
static int Hose_LossPerHit = 2;
static int Hose_Min = 1;

static bool Hose_AlreadyHealed[MAXENTITIES][MAXENTITIES];
static int Hose_Healing[MAXENTITIES] = { 0, ... };
static int Hose_HealLoss[MAXENTITIES] = { 0, ... };
static int Hose_HealMin[MAXENTITIES] = { 0, ... };
static int Hose_Owner[MAXENTITIES] = { -1, ... };
static bool Hose_GiveUber[MAXENTITIES] = { false, ... };
static bool Hose_ProjectileCharged[MAXENTITIES] = { false, ... };
static float Hose_Uber[MAXPLAYERS + 1] = { 0.0, ... };
static float Hose_NextHealSound[MAXPLAYERS + 1] = { 0.0, ... };
static bool Hose_Charged[MAXPLAYERS + 1] = { false, ... };
static bool Hose_ShotgunCharge[MAXPLAYERS + 1] = { false, ... };

#define SOUND_HOSE_HEALED		"weapons/rescue_ranger_charge_01.wav"
#define SOUND_HOSE_UBER_END		"player/invuln_off_vaccinator.wav"
#define SOUND_HOSE_UBER_ACTIVATE	"player/invuln_on_vaccinator.wav"
#define SOUND_HOSE_UBER_READY		"weapons/vaccinator_charge_tier_04.wav"
#define SOUND_SHOOT_SHOTCHARGE		"items/powerup_pickup_reflect_reflect_damage.wav"

#define HOSE_PARTICLE			"stunballtrail_red"
#define HOSE_PARTICLE_OLD		"healshot_trail_red" //Looks good but is ridiculously flashy, so scrapped.
#define HOSE_PARTICLE_CHARGED	"stunballtrail_blue_crit"
#define HOSE_PARTICLE_CHARGED_OLD	"healshot_trail_blue" //Looks good but is ridiculously flashy, so scrapped.
#define HEAL_PARTICLE			"healthgained_red"
#define HEAL_PARTICLE_CHARGED	"healthgained_blu"
#define HEALTH_MODEL_SMALL "models/items/medkit_small.mdl"

#define PLACE_MEDKIT		"weapons/fx/rics/arrow_impact_crossbow_heal.wav"

void Weapon_Hose_Precache()
{
	PrecacheSound(SOUND_HOSE_HEALED);
	PrecacheSound(SOUND_HOSE_UBER_END);
	PrecacheSound(SOUND_HOSE_UBER_ACTIVATE);
	PrecacheSound(SOUND_HOSE_UBER_READY);
	PrecacheSound(SOUND_SHOOT_SHOTCHARGE);
	PrecacheSound(PLACE_MEDKIT);
	PrecacheModel(COLLISION_DETECTION_MODEL_BIG);
	PrecacheModel(HEALTH_MODEL_SMALL);
}

public void Weapon_Health_Hose(int client, int weapon, bool crit, int slot)
{
	Weapon_Hose_Shoot(client, weapon, crit, slot, Hose_Velocity, Hose_BaseHeal, Hose_LossPerHit, Hose_Min, 1, 1.0, HOSE_PARTICLE, false);
}

public void Weapon_Health_Hose_Shotgun(int client, int weapon, bool crit, int slot)
{
	Weapon_Hose_Shoot(client, weapon, crit, slot, Hose_Velocity, Hose_BaseHeal, Hose_LossPerHit, Hose_Min, 6, 4.0, HOSE_PARTICLE, false);
}

public void Weapon_Health_Hose_GiveUber(int client, int weapon, bool crit, int slot)
{
	Weapon_Hose_Shoot(client, weapon, crit, slot, Hose_Velocity, Hose_BaseHeal, Hose_LossPerHit, Hose_Min, 1, 1.0, HOSE_PARTICLE, true);
}

public void Weapon_Health_Hose_Shotgun_GiveUber(int client, int weapon, bool crit, int slot)
{
	Weapon_Hose_Shoot(client, weapon, crit, slot, Hose_Velocity, Hose_BaseHeal, Hose_LossPerHit, Hose_Min, 6, 4.0, HOSE_PARTICLE, true);
}

public void Weapon_Health_Hose_Uber_Sprayer(int client, int weapon, bool crit, int slot)
{
	if (Hose_Uber[client] < 1.0 && !Hose_Charged[client])
	{
		ClientCommand(client, "playgamesound items/medshotno1.wav");
		Hose_UpdateText(client);
	}
	else if (!Hose_Charged[client])
	{
		Hose_Uber[client] = 0.0;
		Hose_Charged[client] = true;
		
		float dur = Hose_UberTime + Attributes_FindOnPlayerZR(client, 314, true, 0.0, true);
		EmitSoundToClient(client, SOUND_HOSE_UBER_ACTIVATE, _, _, 120);
		
		CreateTimer(dur, Hose_RemoveUber, GetClientUserId(client), TIMER_FLAG_NO_MAPCHANGE);
		
		TF2_AddCondition(client, TFCond_MegaHeal, dur);
		ApplyTempAttrib(weapon, 6, 0.5, dur);
		ApplyTempAttrib(weapon, 97, 0.5, dur);
		ApplyTempAttrib(weapon, 4, 2.0, dur);
		
		Hose_UpdateText(client);
	}
}

public void Weapon_Health_Hose_Uber_Shotgun(int client, int weapon, bool crit, int slot)
{
	if (Hose_Uber[client] < 1.0 && !Hose_Charged[client])
	{
		ClientCommand(client, "playgamesound items/medshotno1.wav");
	}
	else if (!Hose_Charged[client])
	{
		Hose_Uber[client] = 0.0;
		Hose_Charged[client] = true;
		Hose_ShotgunCharge[client] = true;
		
		float dur = Hose_UberTime + Attributes_FindOnPlayerZR(client, 314, true, 0.0, true);
		EmitSoundToClient(client, SOUND_HOSE_UBER_ACTIVATE, _, _, 120);
		
		CreateTimer(dur, Hose_RemoveUber, GetClientUserId(client), TIMER_FLAG_NO_MAPCHANGE);
		
		TF2_AddCondition(client, TFCond_MegaHeal, dur);
		
		Hose_UpdateText(client);
	}
}

public Action Hose_RemoveUber(Handle remove, int id)
{
	int client = GetClientOfUserId(id);
	
	if (IsValidClient(client))
	{
		Hose_Charged[client] = false;
		Hose_ShotgunCharge[client] = false;
		EmitSoundToClient(client, SOUND_HOSE_UBER_END, _, _, 120);
		
		Hose_UpdateText(client);
	}
	return Plugin_Stop;
}

public void Weapon_Hose_Shoot(int client, int weapon, bool crit, int slot, float speed, float baseHeal, int loss, int minHeal, int NumParticles, float spread, char ParticleName[255], bool giveUber)
{
	float healmult = 1.0;
	healmult = Attributes_GetOnPlayer(client, 8, true, true);

	if (Hose_ShotgunCharge[client])
	{
		healmult *= Hose_ShotgunChargeMult;
	}
		
	speed *= Attributes_Get(weapon, 103, 1.0);
		
	speed *= Attributes_Get(weapon, 104, 1.0);

	speed *= Attributes_Get(weapon, 475, 1.0);
	
		
	int FinalHeal = RoundFloat(baseHeal * healmult);
		
	float Angles[3];

	for (int i = 0; i < NumParticles; i++)
	{
		GetClientEyeAngles(client, Angles);
			
		for (int j = 0; j < 3; j++)
		{
			Angles[j] += GetRandomFloat(-spread, spread);
		}
			
		//This spawns the projectile, this is a return int, if you want, you can do extra stuff with it, otherwise, it can be used as a void.
		int projectile = Wand_Projectile_Spawn(client, speed, 1.66, 0.0, 19, weapon, Hose_Charged[client] ? HOSE_PARTICLE_CHARGED : ParticleName, Angles);

		Hose_Owner[projectile] = -1;
		for (int i2 = 0; i2 < MAXENTITIES; i2++)
		{
			Hose_AlreadyHealed[i2][projectile] = false;
			Hose_AlreadyHealed[projectile][i2] = false;
		}

		Hose_Healing[projectile] = FinalHeal;
		Hose_HealLoss[projectile] = loss;
		Hose_HealMin[projectile] = minHeal;
		Hose_Owner[projectile] = GetClientUserId(client);
		Hose_GiveUber[projectile] = giveUber && !Hose_Charged[client];
		Hose_ProjectileCharged[projectile] = Hose_Charged[client];

		//Remove unused hook.
		//SDKUnhook(projectile, SDKHook_StartTouch, Wand_Base_StartTouch);

		for (int entity = 0; entity < MAXENTITIES; entity++)
		{
			Hose_AlreadyHealed[projectile][entity] = false;
		}
			
		SetEntityCollisionGroup(projectile, 27); //Do not collide.
		SetEntProp(projectile, Prop_Send, "m_usSolidFlags", 12); 
		SetEntityMoveType(projectile, MOVETYPE_FLYGRAVITY);
		SetEntityGravity(projectile, 0.5);
	}
	
	if (Hose_ShotgunCharge[client])
	{
		EmitSoundToClient(client, SOUND_SHOOT_SHOTCHARGE, _, _, _, _, _, GetRandomInt(80, 110));
	}
}

//If you use SearchDamage (above), convert this timer to a void method and rename it to Cryo_DealDamage:
public void Hose_Touch(int entity, int other)
{
	if (entity == -1) //Don't accidentally heal the user every time they fire this thing, it would be WAY too good
		return;
		
	if (other == -1) //Don't accidentally heal the user every time they fire this thing, it would be WAY too good
		return;

	if (other == 0)	
	{
		int particle = EntRefToEntIndex(i_WandParticle[entity]);
		if(IsValidEntity(particle))
		{
			RemoveEntity(particle);
		}
		RemoveEntity(entity);
	}
	int owner = GetClientOfUserId(Hose_Owner[entity]);
	
	if (!IsValidClient(owner))
		return;
		
	if (other == owner) //Don't accidentally heal the user every time they fire this thing, it would be WAY too good
		return;

		
	if (Hose_AlreadyHealed[entity][other])
		return;
		
	if (IsValidAlly(other, owner))	
	{	
		float ProjLoc[3];
		GetEntPropVector(entity, Prop_Data, "m_vecAbsOrigin", ProjLoc);
		ProjLoc[2] += 100.0;
		TE_Particle(Hose_ProjectileCharged[entity] ? HEAL_PARTICLE_CHARGED : HEAL_PARTICLE, ProjLoc, NULL_VECTOR, NULL_VECTOR, _, _, _, _, _, _, _, _, _, _, 0.0);

		Hose_Heal(owner, other, Hose_Healing[entity]);
		
		Hose_Healing[entity] -= Hose_HealLoss[entity];
		if (Hose_Healing[entity] < Hose_HealMin[entity])
		{
			Hose_Healing[entity] = Hose_HealMin[entity];
		}
		
		Hose_AlreadyHealed[entity][other] = true;
		
		if (Hose_GiveUber[entity])
		{
			if (GetGameTime() >= Hose_NextHealSound[owner])
			{
				Hose_UpdateText(owner);
			}
			
			if (!Hose_Charged[owner] && Hose_Uber[owner] < 1.0)
			{
				Hose_Uber[owner] += Hose_UberGain;
				if (Hose_Uber[owner] >= 1.0)
				{
					Hose_Uber[owner] = 1.0;
					EmitSoundToClient(owner, SOUND_HOSE_UBER_READY, _, _, 120);
				}
			}
		}
		
		if (GetGameTime() >= Hose_NextHealSound[owner])
		{
			EmitSoundToClient(owner, SOUND_HOSE_HEALED);
			Hose_NextHealSound[owner] = GetGameTime() + 0.05;
		}
	}
}

public void Hose_Heal(int owner, int entity, int amt)
{
	int flHealth = GetEntProp(entity, Prop_Data, "m_iHealth");
		
	int flMaxHealth;
	if(entity > MaxClients)
	{
		flMaxHealth = GetEntProp(entity, Prop_Data, "m_iMaxHealth");
	}
	else
	{
		flMaxHealth = SDKCall_GetMaxHealth(entity);
	}
	
	if (flHealth >= flMaxHealth)	//Don't apply the new health because then you'd remove their overheal if they have any
		return;
	
	if (f_TimeUntillNormalHeal[entity] > GetGameTime())
	{
		amt /= 3;
		if (amt < 1)
		{
			amt = 1;
		}
	}
	
	int newHP = flHealth + amt;
	int ActualHealingDone = amt;
	
	if (newHP > flMaxHealth)
	{
		int diff = newHP - flMaxHealth;
		ActualHealingDone -= diff;
		
		newHP = flMaxHealth;
	}
	if(entity < MaxClients)
	{
		ApplyHealEvent(entity, amt);
	}
	
	SetEntProp(entity, Prop_Data, "m_iHealth", newHP);	
	
	int HealingPerBolt = ActualHealingDone;
	int new_ammo = GetAmmo(owner, 21);

	if(f_TimeUntillNormalHeal[entity] > GetGameTime())
	{
		if(HealingPerBolt > new_ammo)
		{
			HealingPerBolt = new_ammo;
		}
	}
		
	new_ammo -= HealingPerBolt;
	SetAmmo(owner, 21, new_ammo);
	CurrentAmmo[owner][21] = GetAmmo(owner, 21);
	
	flHealth = GetEntProp(owner, Prop_Data, "m_iHealth");
	flMaxHealth = SDKCall_GetMaxHealth(owner);
	
	int userHeal = RoundFloat(float(ActualHealingDone) * SelfHealMult);
	
	if(flHealth >= flMaxHealth)
	{
		return;
	}
	newHP = flHealth + userHeal;
	if (newHP > flMaxHealth)
	{
		newHP = flMaxHealth;
	}
	
	SetEntProp(owner, Prop_Data, "m_iHealth", newHP);
}

public void Hose_UpdateText(int owner)
{
	if (!IsValidClient(owner))
		return;
		
	if (Hose_Charged[owner])
	{
		PrintHintText(owner, "[CHARGE IS ACTIVE]");
	}
	else if (Hose_Uber[owner] >= 1.0)
	{
		PrintHintText(owner, "[CHARGE IS READY! ALT-FIRE TO USE!]");
	}
	else
	{
		PrintHintText(owner, "[CHARGE: %.2f]", Hose_Uber[owner]);
	}
}



//Syringe gun Pap Stuff
public void Weapon_Syringe_Gun_Fire_M2(int client, int weapon, bool crit, int slot)
{
	if (Ability_Check_Cooldown(client, slot) > 0.0 && Ability_Check_Cooldown(client, slot) < 500.0)
	{
		float Ability_CD = Ability_Check_Cooldown(client, slot);
		
		if(Ability_CD <= 0.0)
			Ability_CD = 0.0;
			
		ClientCommand(client, "playgamesound items/medshotno1.wav");
		SetDefaultHudPosition(client);
		SetGlobalTransTarget(client);
		ShowSyncHudText(client,  SyncHud_Notifaction, "%t", "Ability has cooldown", Ability_CD);
		return;
	}
	if(!(GetClientButtons(client) & IN_DUCK))
	{
		ClientCommand(client, "playgamesound items/medshotno1.wav");
		SetDefaultHudPosition(client);
		SetGlobalTransTarget(client);
		ShowSyncHudText(client,  SyncHud_Notifaction, "%t", "Crouch for ability");	
		return;
	}
	Handle swingTrace;
	int MaxTargethit = -1;
	float vecSwingForward[3];
	float vec[3];
	float Range = 150.0;
	DoSwingTrace_Custom(swingTrace, client, vecSwingForward, Range, false, 45.0, true,MaxTargethit); //infinite range, and ignore walls!
	TR_GetEndPosition(vec, swingTrace);
	delete swingTrace;
	if(SpawnHealthkit_SyringeGun(client, vec))
	{
		if(Ability_Check_Cooldown(client, slot) < 500.0)
		{
			Ability_Apply_Cooldown(client, slot, 999.0); //Semi long cooldown, this is a strong buff.
		}
		else
		{
			Ability_Apply_Cooldown(client, slot, 60.0); //Semi long cooldown, this is a strong buff.
		}
		EmitSoundToAll(PLACE_MEDKIT, client, SNDCHAN_STATIC, 90, _, 0.6);
		int color[4];
		color[0] = 0;
		color[1] = 255;
		color[2] = 0;
		color[3] = 255;
		vec[2] += 5.0;
		TE_SetupBeamRingPoint(vec, 10.0, 150.0 * 2.0, g_BeamIndex_heal, -1, 0, 5, 0.5, 5.0, 1.0, color, 0, 0);
		TE_SendToAll();
	}
	else
	{
		SetDefaultHudPosition(client);
		SetGlobalTransTarget(client);
		ShowSyncHudText(client,  SyncHud_Notifaction, "%t", "Too Far Away");
	}
}

public void Weapon_Syringe_Gun_Fire_M1(int client, int weapon, bool crit, int slot)
{
	float eyePos[3];
	float eyeAng[3];
	
	GetClientEyePosition(client, eyePos);
	GetClientEyeAngles(client, eyeAng);

	b_LagCompNPC_No_Layers = true;
	StartPlayerOnlyLagComp(client, true);
	Handle trace = TR_TraceRayFilterEx(eyePos, eyeAng, MASK_SOLID, RayType_Infinite, Syringe_Shot_BulletAndMeleeTraceAlly,client);
				
	int target = TR_GetEntityIndex(trace);	
	EndPlayerOnlyLagComp(client);
	if(IsValidAlly(client, target))
	{
		int ammo_amount_left = GetAmmo(client, 21);
		if(ammo_amount_left > 0)
		{
			float HealAmmount = 20.0;

			if(GetEntPropFloat(weapon, Prop_Send, "m_flChargedDamage") >= 149.0)
			{
				HealAmmount *= 3.0;
			}

			HealAmmount *= Attributes_GetOnPlayer(client, 8, true, true);

			float GameTime = GetGameTime();
			if(f_TimeUntillNormalHeal[target] > GameTime)
			{
				HealAmmount /= 4.0; //make sure they dont get the full benifit if hurt recently.
			}
			
			if(ammo_amount_left > RoundToCeil(HealAmmount))
			{
				ammo_amount_left = RoundToCeil(HealAmmount);
			}

			float flHealth = float(GetEntProp(target, Prop_Data, "m_iHealth"));
			float flMaxHealth;
			
			if(target <= MaxClients)
			{
				flMaxHealth = float(SDKCall_GetMaxHealth(target));
			}
			else
			{
				flMaxHealth = float(GetEntProp(target, Prop_Data, "m_iMaxHealth"));
			}

			flMaxHealth *= 1.15;
			
			int Health_To_Max;
			
			Health_To_Max = RoundToNearest(flMaxHealth) - RoundToNearest(flHealth);

			if(Health_To_Max < RoundToCeil(HealAmmount))
			{
				ammo_amount_left = Health_To_Max;
			}

			HealEntityGlobal(client, target, float(ammo_amount_left), 1.15, 1.0, _);
			
			ClientCommand(client, "playgamesound items/smallmedkit1.wav");

			if(target <= MaxClients)
				ClientCommand(target, "playgamesound items/smallmedkit1.wav");

			SetGlobalTransTarget(client);
			int new_ammo = GetAmmo(client, 21) - ammo_amount_left;
			if(target <= MaxClients)
				PrintHintText(client, "%t", "You healed for", target, ammo_amount_left);

			SetAmmo(client, 21, new_ammo);
			for(int i; i<Ammo_MAX; i++)
			{
				CurrentAmmo[client][i] = GetAmmo(client, i);
			}
		}
		
		Increaced_Overall_damage_Low[client] = GetGameTime() + 5.0;
		Increaced_Overall_damage_Low[target] = GetGameTime() + 15.0;
		Resistance_Overall_Low[client] = GetGameTime() + 5.0;
		Resistance_Overall_Low[target] = GetGameTime() + 15.0;
		static float belowBossEyes[3];
		belowBossEyes[0] = 0.0;
		belowBossEyes[1] = 0.0;
		belowBossEyes[2] = 0.0;

		GetBeamDrawStartPoint_Stock(client, belowBossEyes,{0.0,-10.0,-10.0});
		float TargetVecPos[3]; WorldSpaceCenter(target, TargetVecPos);
		Passanger_Lightning_Effect(belowBossEyes, TargetVecPos, 1, 5.0, {200,50,50});
	}
	else
	{
		if (TR_DidHit(trace))
		{
			float spawnLoc[3];
			static float belowBossEyes[3];
			belowBossEyes[0] = 0.0;
			belowBossEyes[1] = 0.0;
			belowBossEyes[2] = 0.0;

			TR_GetEndPosition(spawnLoc, trace);
			GetBeamDrawStartPoint_Stock(client, belowBossEyes,{0.0,-10.0,-10.0});
			Passanger_Lightning_Effect(belowBossEyes, spawnLoc, 1, 5.0, {200,50,50});
		} 
	}
	delete trace;
}

public bool Syringe_Shot_BulletAndMeleeTraceAlly(int entity, int contentsMask, any iExclude)
{
	bool result = BulletAndMeleeTraceAlly(entity, contentsMask, iExclude);
	if(entity == 0)
	{
		return true;
	}
	if(!result)
	{
		return false;
	}

	float maxhealth = 1.0;
	float health = float(GetEntProp(entity, Prop_Data, "m_iHealth"));

	if(entity <= MaxClients)
	{
		maxhealth = float(SDKCall_GetMaxHealth(entity));
		if(RoundToNearest(health) >= (RoundToNearest(maxhealth * 1.15)))
		{
			return false;
		}
	}
	else
	{
		maxhealth = float(GetEntProp(entity, Prop_Data, "m_iMaxHealth"));
		if(RoundToNearest(health) >= (RoundToNearest(maxhealth * 1.15)))
		{
			return false;
		}
	}
	return true;
}

float f_HealMaxPickup[MAXENTITIES];
float f_HealMaxPickup_Enable[MAXENTITIES];
bool SpawnHealthkit_SyringeGun(int client, float VectorGoal[3])
{
	CNavArea area = TheNavMesh.GetNavArea(VectorGoal, 150.0);
	if(area == NULL_AREA)
		return false;
		
	static float hullcheckmaxs_Player[3];
	static float hullcheckmins_Player[3];
	hullcheckmaxs_Player = view_as<float>( { 12.0, 12.0, 12.0 } );
	hullcheckmins_Player = view_as<float>( { -12.0, -12.0, -12.0 } );	
	float AbsOrigin_after[3];
	AbsOrigin_after = VectorGoal;
	AbsOrigin_after[2] -= 1000.0;
	VectorGoal[2] += 12.0;
	TR_TraceHullFilter(VectorGoal, AbsOrigin_after, hullcheckmins_Player, hullcheckmaxs_Player, MASK_PLAYERSOLID_BRUSHONLY, TraceRayHitWorldOnly, client);
	if(TR_DidHit())
	{
		TR_GetEndPosition(VectorGoal);
	}

	float HealAmmount = 30.0;

	HealAmmount *= Attributes_GetOnPlayer(client, 8, true, true);

	int prop = CreateEntityByName("prop_dynamic_override");
	if(IsValidEntity(prop))
	{
		b_ToggleTransparency[prop] = false;
		DispatchKeyValue(prop, "model", HEALTH_MODEL_SMALL);
		DispatchKeyValue(prop, "modelscale", "1.0");
		DispatchKeyValue(prop, "StartDisabled", "false");
		DispatchKeyValue(prop, "Solid", "2");
	//	SetEntProp(prop, Prop_Data, "m_nSolidType", 0);
		TeleportEntity(prop, VectorGoal, NULL_VECTOR, NULL_VECTOR);
		DispatchSpawn(prop);
		SetVariantString("idle");
		AcceptEntityInput(prop, "SetAnimation");
		DispatchKeyValueFloat(prop, "playbackrate", 1.0);
		SetEntPropEnt(prop, Prop_Data, "m_hOwnerEntity", client);
		SetEntProp(prop, Prop_Send, "m_usSolidFlags", 12); 
		SetEntityCollisionGroup(prop, 27);
		SDKHook(prop, SDKHook_StartTouch, TouchHealthKit);
		f_HealMaxPickup[prop] = HealAmmount;
		f_HealMaxPickup_Enable[prop] = GetGameTime() + 2.0;
		i_WandIdNumber[prop] = 999;
	//	CreateTimer(0.1, Timer_Detect_Player_Nearby_healthkit, EntIndexToEntRef(prop), TIMER_FLAG_NO_MAPCHANGE|TIMER_REPEAT);
	}	
	return true;
}
public void TouchHealthKit(int entity, int other)
{
	if (other > 0 && other <= MaxClients)	
	{
		if(TeutonType[other] != TEUTON_NONE || dieingstate[other] != 0)
		{
			return;
		}
		float maxhealth = 1.0;
		float health = float(GetEntProp(other, Prop_Data, "m_iHealth"));
		maxhealth = float(SDKCall_GetMaxHealth(other));
		if(RoundToNearest(health) >= (RoundToNearest(maxhealth)))
		{
			return;
		}	
		int Owner = GetEntPropEnt(entity, Prop_Data, "m_hOwnerEntity");
		float GameTime = GetGameTime();
		float HealingAmount = f_HealMaxPickup[entity];
		if(f_TimeUntillNormalHeal[other] > GameTime)
		{
			HealingAmount /= 2.0;
		}
		int healing_done = HealEntityGlobal(Owner, other, HealingAmount, 1.0, _, _);
		if(healing_done <= 0)
		{
			return;
		}
		if(IsValidClient(Owner))
		{
			PrintHintText(Owner, "%t", "You healed for", other, healing_done);
		}
		ApplyHealEvent(other, healing_done);
		ClientCommand(other, "playgamesound items/smallmedkit1.wav");
		Increaced_Overall_damage_Low[other] = GetGameTime() + 15.0;
		Resistance_Overall_Low[other] = GetGameTime() + 15.0;
		RemoveEntity(entity);	
	}
}
