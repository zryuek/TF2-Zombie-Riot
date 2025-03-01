#pragma semicolon 1
#pragma newdecls required

#define BOB_FIRST_LIGHTNING_RANGE 100.0

#define BOB_CHARGE_TIME 1.5
#define BOB_CHARGE_SPAN 0.5

#define BOB_MELEE_SIZE 35
#define BOB_MELEE_SIZE_F 35.0

static const char g_IntroStartSounds[][] =
{
	"npc/combine_soldier/vo/overwatchtargetcontained.wav",
	"npc/combine_soldier/vo/overwatchtarget1sterilized.wav"
};

static const char g_IntroEndSounds[][] =
{
	"npc/combine_soldier/vo/overwatchreportspossiblehostiles.wav"
};

static const char g_SummonSounds[][] =
{
	"npc/combine_soldier/vo/overwatchrequestreinforcement.wav"
};

static const char g_SkyShieldSounds[][] =
{
	"npc/combine_soldier/vo/overwatchrequestskyshield.wav"
};

static const char g_SpeedUpSounds[][] =
{
	"npc/combine_soldier/vo/ovewatchorders3ccstimboost.wav"
};

static const char g_SummonDiedSounds[][] =
{
	"npc/combine_soldier/vo/overwatchteamisdown.wav"
};

static const char PullRandomEnemyAttack[][] =
{
	"weapons/physcannon/energy_sing_explosion2.wav"
};

static const char g_MeleeHitSounds[][] =
{
	"weapons/pickaxe_swing3.wav",
	"weapons/pickaxe_swing2.wav",
	"weapons/pickaxe_swing1.wav",
};

static const char g_MeleeAttackSounds[][] =
{
	"weapons/saxxy_turntogold_05.wav"
};

static const char g_RangedAttackSounds[][] =
{
	"weapons/physcannon/physcannon_claws_close.wav"
};
static const char g_RangedGunSounds[][] =
{
	"weapons/pistol/pistol_fire2.wav",
};
static const char g_RangedSpecialAttackSounds[][] =
{
	"mvm/sentrybuster/mvm_sentrybuster_spin.wav"
};

static const char g_BoomSounds[][] =
{
	"mvm/mvm_tank_explode.wav"
};

static const char g_BuffSounds[][] =
{
	"player/invuln_off_vaccinator.wav"
};

static const char g_FireRocketHoming[][] =
{
	"weapons/cow_mangler_explosion_charge_04.wav",
	"weapons/cow_mangler_explosion_charge_05.wav",
	"weapons/cow_mangler_explosion_charge_06.wav",
};


static const char g_BobSuperMeleeCharge[][] =
{
	"weapons/vaccinator_charge_tier_01.wav",
	"weapons/vaccinator_charge_tier_02.wav",
	"weapons/vaccinator_charge_tier_03.wav",
	"weapons/vaccinator_charge_tier_04.wav",
};

static const char g_BobSuperMeleeCharge_Hit[][] =
{
	"player/taunt_yeti_standee_break.wav",
};

//static int BobHitDetected[MAXENTITIES];

void RaidbossBobTheFirst_OnMapStart()
{
	NPCData data;
	strcopy(data.Name, sizeof(data.Name), "?????????????");
	strcopy(data.Plugin, sizeof(data.Plugin), "npc_bob_the_first_last_savior");
	data.IconCustom = true;
	data.Flags = -1;
	data.Category = Type_Hidden;
	data.Func = ClotSummon;
	data.Precache = ClotPrecache;
	NPC_Add(data);
}

static void ClotPrecache()
{
	PrecacheSoundArray(g_IntroStartSounds);
	PrecacheSoundArray(g_IntroEndSounds);
	PrecacheSoundArray(g_SummonSounds);
	PrecacheSoundArray(g_SkyShieldSounds);
	PrecacheSoundArray(g_SpeedUpSounds);
	PrecacheSoundArray(g_SummonDiedSounds);
	PrecacheSoundArray(g_MeleeHitSounds);
	PrecacheSoundArray(g_MeleeAttackSounds);
	PrecacheSoundArray(g_RangedAttackSounds);
	PrecacheSoundArray(g_RangedGunSounds);
	PrecacheSoundArray(g_RangedSpecialAttackSounds);
	PrecacheSoundArray(g_BoomSounds);
	PrecacheSoundArray(g_BuffSounds);
	PrecacheSoundArray(PullRandomEnemyAttack);
	PrecacheSoundArray(g_FireRocketHoming);
	PrecacheSoundArray(g_BobSuperMeleeCharge);
	PrecacheSoundArray(g_BobSuperMeleeCharge_Hit);
	
	PrecacheSoundCustom("#zombiesurvival/bob_raid/bob.mp3");
}

static any ClotSummon(int client, float vecPos[3], float vecAng[3], int ally, const char[] data)
{
	return RaidbossBobTheFirst(vecPos, vecAng, ally, data);
}

methodmap RaidbossBobTheFirst < CClotBody
{
	public void PlayIntroStartSound()
	{
		EmitSoundToAll(g_IntroStartSounds[GetRandomInt(0, sizeof(g_IntroStartSounds) - 1)]);
	}
	public void PlayIntroEndSound()
	{
		EmitSoundToAll(g_IntroStartSounds[GetRandomInt(0, sizeof(g_IntroStartSounds) - 1)]);
	}
	public void PlaySummonSound()
	{
		EmitSoundToAll(g_SummonSounds[GetRandomInt(0, sizeof(g_SummonSounds) - 1)]);
	}
	public void PlaySkyShieldSound()
	{
		EmitSoundToAll(g_SkyShieldSounds[GetRandomInt(0, sizeof(g_SkyShieldSounds) - 1)], this.index, SNDCHAN_STATIC, RAIDBOSS_ZOMBIE_SOUNDLEVEL, _, BOSS_ZOMBIE_VOLUME);
	}
	public void PlaySpeedUpSound()
	{
		EmitSoundToAll(g_SpeedUpSounds[GetRandomInt(0, sizeof(g_SpeedUpSounds) - 1)]);
	}
	public void PlaySummonDeadSound()
	{
		EmitSoundToAll(g_SummonDiedSounds[GetRandomInt(0, sizeof(g_SummonDiedSounds) - 1)]);
	}
	public void PlayMeleeSound()
	{
		EmitSoundToAll(g_MeleeAttackSounds[GetRandomInt(0, sizeof(g_MeleeAttackSounds) - 1)], this.index, SNDCHAN_STATIC, RAIDBOSS_ZOMBIE_SOUNDLEVEL, _, BOSS_ZOMBIE_VOLUME, GetRandomInt(90,110));
	}
	public void PlayRangedSound()
	{
		EmitSoundToAll(g_RangedAttackSounds[GetRandomInt(0, sizeof(g_RangedAttackSounds) - 1)], this.index, SNDCHAN_STATIC, RAIDBOSS_ZOMBIE_SOUNDLEVEL, _, BOSS_ZOMBIE_VOLUME);
	}
	public void PlayGunSound()
	{
		EmitSoundToAll(g_RangedGunSounds[GetRandomInt(0, sizeof(g_RangedGunSounds) - 1)], this.index, SNDCHAN_STATIC, RAIDBOSS_ZOMBIE_SOUNDLEVEL, _, BOSS_ZOMBIE_VOLUME);
	}
	public void PlayRangedSpecialSound()
	{
		EmitSoundToAll(g_RangedSpecialAttackSounds[GetRandomInt(0, sizeof(g_RangedSpecialAttackSounds) - 1)], this.index, SNDCHAN_STATIC, RAIDBOSS_ZOMBIE_SOUNDLEVEL, _, BOSS_ZOMBIE_VOLUME);
	}
	public void PlayBoomSound()
	{
		EmitSoundToAll(g_BoomSounds[GetRandomInt(0, sizeof(g_BoomSounds) - 1)], this.index, SNDCHAN_STATIC, RAIDBOSS_ZOMBIE_SOUNDLEVEL, _, BOSS_ZOMBIE_VOLUME);
	}
	public void PlayMeleeHitSound()
	{
		EmitSoundToAll(g_MeleeHitSounds[GetRandomInt(0, sizeof(g_MeleeHitSounds) - 1)], this.index, SNDCHAN_STATIC, RAIDBOSS_ZOMBIE_SOUNDLEVEL, _, BOSS_ZOMBIE_VOLUME);
	}
	public void PlayBuffSound()
	{
		EmitSoundToAll(g_BuffSounds[GetRandomInt(0, sizeof(g_BuffSounds) - 1)], this.index, SNDCHAN_STATIC, RAIDBOSS_ZOMBIE_SOUNDLEVEL, _, BOSS_ZOMBIE_VOLUME);
	}
	public void PlayRandomEnemyPullSound()
	{
		EmitSoundToAll(PullRandomEnemyAttack[GetRandomInt(0, sizeof(PullRandomEnemyAttack) - 1)], this.index, SNDCHAN_STATIC, RAIDBOSS_ZOMBIE_SOUNDLEVEL, _, BOSS_ZOMBIE_VOLUME);
	}
	public void PlayRocketHoming()
	{
		EmitSoundToAll(g_FireRocketHoming[GetRandomInt(0, sizeof(g_FireRocketHoming) - 1)], this.index, SNDCHAN_STATIC, RAIDBOSS_ZOMBIE_SOUNDLEVEL, _, BOSS_ZOMBIE_VOLUME);
	}
	public void PlayBobMeleePreHit()
	{
		EmitSoundToAll(g_BobSuperMeleeCharge[GetRandomInt(0, sizeof(g_BobSuperMeleeCharge) - 1)], this.index, SNDCHAN_STATIC, RAIDBOSS_ZOMBIE_SOUNDLEVEL, _, 0.7, GetRandomInt(80,90));
	}
	public void PlayBobMeleePostHit()
	{
		int pitch = GetRandomInt(70,80);
		EmitSoundToAll(g_BobSuperMeleeCharge_Hit[GetRandomInt(0, sizeof(g_BobSuperMeleeCharge_Hit) - 1)], this.index, SNDCHAN_STATIC, RAIDBOSS_ZOMBIE_SOUNDLEVEL, _, 0.7, pitch);
		EmitSoundToAll(g_BobSuperMeleeCharge_Hit[GetRandomInt(0, sizeof(g_BobSuperMeleeCharge_Hit) - 1)], this.index, SNDCHAN_STATIC, RAIDBOSS_ZOMBIE_SOUNDLEVEL, _, 0.7, pitch);
	}
	property int m_iAttackType
	{
		public get()		{	return this.m_iOverlordComboAttack;	}
		public set(int value) 	{	this.m_iOverlordComboAttack = value;	}
	}
	property int m_iPullCount
	{
		public get()		{	return this.m_iMedkitAnnoyance;	}
		public set(int value) 	{	this.m_iMedkitAnnoyance = value;	}
	}
	property bool m_bSecondPhase
	{
		public get()		{	return this.m_bNextRangedBarrage_OnGoing;	}
		public set(bool value)	{	this.m_bNextRangedBarrage_OnGoing = value;	}
	}	
	property bool b_SwordIgnition
	{
		public get()							{ return b_follow[this.index]; }
		public set(bool TempValueForProperty) 	{ b_follow[this.index] = TempValueForProperty; }
	}
	property bool m_bFakeClone
	{
		public get()		{	return i_RaidGrantExtra[this.index] < 0;	}
	}

	public RaidbossBobTheFirst(float vecPos[3], float vecAng[3], int ally, const char[] data)
	{
		float pos[3];
		pos = vecPos;
		bool SmittenNpc = false;
		
		for(int i; i < i_MaxcountNpcTotal; i++)
		{
			int entity = EntRefToEntIndex(i_ObjectsNpcsTotal[i]);
			if(IsValidEntity(entity))
			{
				char npc_classname[60];
				NPC_GetPluginById(i_NpcInternalId[entity], npc_classname, sizeof(npc_classname));

				if(entity != INVALID_ENT_REFERENCE && (StrEqual(npc_classname, "npc_sea_donnerkrieg") || StrEqual(npc_classname, "npc_sea_schwertkrieg")) && IsEntityAlive(entity))
				{
					GetEntPropVector(entity, Prop_Data, "m_vecAbsOrigin", pos);
					SmiteNpcToDeath(entity);
					SmittenNpc = true;
				}
			}
		}

		RaidbossBobTheFirst npc = view_as<RaidbossBobTheFirst>(CClotBody(pos, vecAng, COMBINE_CUSTOM_MODEL, "1.15", "20000000", ally, _, _, true, false));
		
		i_NpcWeight[npc.index] = 4;
		
		KillFeed_SetKillIcon(npc.index, "tf_projectile_rocket");
		FormatEx(c_HeadPlaceAttachmentGibName[npc.index], sizeof(c_HeadPlaceAttachmentGibName[]), "head");
		
		npc.SetActivity("ACT_MUDROCK_RAGE");
		b_NpcIsInvulnerable[npc.index] = true;

		npc.PlayIntroStartSound();

		func_NPCDeath[npc.index] = RaidbossBobTheFirst_NPCDeath;
		func_NPCOnTakeDamage[npc.index] = RaidbossBobTheFirst_OnTakeDamage;
		func_NPCThink[npc.index] = RaidbossBobTheFirst_ClotThink;
		
		if(StrContains(data, "final_item") != -1)
		{
			func_NPCFuncWin[npc.index] = view_as<Function>(Raidmode_BobFirst_Win);
			i_RaidGrantExtra[npc.index] = 1;
			npc.m_flNextDelayTime = GetGameTime(npc.index) + 10.0;
			npc.m_flAttackHappens_bullshit = GetGameTime(npc.index) + 10.0;
			npc.g_TimesSummoned = 0;
			WaveStart_SubWaveStart(GetGameTime() + 500.0);
			//this shouldnt ever start, no anti delay here.

			if(StrContains(data, "nobackup") != -1)
			{
				npc.m_flNextDelayTime = 0.0;
				npc.m_bSecondPhase = true;
				npc.g_TimesSummoned = -2;
			}
			else
			{
				npc.m_bSecondPhase = false;
			}
		}
		else if(StrContains(data, "nobackup") != -1)
		{
			npc.m_bSecondPhase = true;
			npc.g_TimesSummoned = -2;
		}
		else if(StrContains(data, "fake") != -1)
		{
			npc.m_bSecondPhase = false;
			MakeObjectIntangeable(npc.index);
			i_RaidGrantExtra[npc.index] = -1;
			b_DoNotUnStuck[npc.index] = true;
			b_ThisNpcIsImmuneToNuke[npc.index] = true;
			b_NoKnockbackFromSources[npc.index] = true;
			b_ThisEntityIgnored[npc.index] = true;
			b_thisNpcIsARaid[npc.index] = true;
		}
		else
		{
			npc.m_bSecondPhase = false;
			npc.m_flNextDelayTime = GetGameTime(npc.index) + 5.0;
			npc.m_flAttackHappens_bullshit = GetGameTime(npc.index) + 5.0;
			npc.SetPlaybackRate(2.0);
			npc.g_TimesSummoned = 0;
		}

		/*
			Cosmetics
		*/
		
		SetVariantInt(1);	// Combine Model
		AcceptEntityInput(npc.index, "SetBodyGroup");

		npc.m_iTeamGlow = TF2_CreateGlow(npc.index);
		npc.m_bTeamGlowDefault = false;
		SetVariantColor(view_as<int>({255, 255, 255, 200}));
		AcceptEntityInput(npc.m_iTeamGlow, "SetGlowColor");

		/*
			Variables
		*/

		npc.m_bDissapearOnDeath = true;
		npc.m_iBleedType = BLEEDTYPE_NORMAL;
		npc.m_iStepNoiseType = STEPSOUND_NORMAL;
		npc.m_iNpcStepVariation = STEPTYPE_COMBINE;

		if(!npc.m_bFakeClone)
		{
			npc.m_bThisNpcIsABoss = true;
			b_thisNpcIsARaid[npc.index] = true;
			npc.m_flMeleeArmor = 1.25;
			RemoveAllDamageAddition();
		}

		npc.Anger = false;
		npc.m_flSpeed = 340.0;
		npc.m_iTarget = 0;
		npc.m_flGetClosestTargetTime = 0.0;

		npc.m_iAttackType = 0;
		npc.m_flAttackHappens = 0.0;

		npc.m_flNextMeleeAttack = 0.0;
		npc.m_flNextRangedAttack = 0.0;
		npc.m_flNextRangedSpecialAttack = 0.0;
		npc.m_iPullCount = 0;
		
		if(!npc.m_bFakeClone)
		{
			strcopy(WhatDifficultySetting, sizeof(WhatDifficultySetting), "You.");
			WavesUpdateDifficultyName();
			MusicEnum music;
			strcopy(music.Path, sizeof(music.Path), "#zombiesurvival/bob_raid/bob.mp3");
			music.Time = 697;
			music.Volume = 1.99;
			music.Custom = true;
			strcopy(music.Name, sizeof(music.Name), "Darkest Dungeon - The Final Combat (Added Narrator)");
			strcopy(music.Artist, sizeof(music.Artist), "Music (Stuart Chatwood) Editor of Narrator (Liruox)");
			Music_SetRaidMusic(music);
			npc.StopPathing();

			RaidBossActive = EntIndexToEntRef(npc.index);
			RaidAllowsBuildings = false;
			RaidModeTime = GetGameTime() + 292.0;
			RaidModeScaling = 9999999.99;
		}

		npc.m_iWearable1 = npc.EquipItem("weapon_bone", "models/weapons/c_models/c_claymore/c_claymore.mdl");
		SetVariantString("1.0");
		SetEntProp(npc.m_iWearable1, Prop_Send, "m_nSkin", 2);
		AcceptEntityInput(npc.m_iWearable1, "SetModelScale");
		AcceptEntityInput(npc.m_iWearable1, "Disable");
		npc.b_SwordIgnition = false;
		strcopy(c_NpcName[npc.index], sizeof(c_NpcName[]), "?????????????");
		if(SmittenNpc)
		{
			switch(GetRandomInt(0,2))
			{
				case 0:
				{
					CPrintToChatAll("{white}%s{default}: I'll Handle this one.", c_NpcName[npc.index]);
				}
				case 1:
				{
					CPrintToChatAll("{white}%s{default}: Schwert and Donner, you did enough, stand back.", c_NpcName[npc.index]);
				}
				case 3:
				{
					CPrintToChatAll("{white}%s{default}: I know enough about infections and its weaknesses to fend you off.", c_NpcName[npc.index]);
				}
			}
		}
		
		return npc;
	}
}

public void RaidbossBobTheFirst_ClotThink(int iNPC)
{
	RaidbossBobTheFirst npc = view_as<RaidbossBobTheFirst>(iNPC);
	
	float gameTime = GetGameTime(npc.index);

	if(npc.Anger || npc.m_bFakeClone || i_RaidGrantExtra[npc.index] > 1)
	{
		b_NpcIsInvulnerable[npc.index] = true;
	}
	else
	{
		b_NpcIsInvulnerable[npc.index] = false;
	}

	if(npc.m_flAttackHappens_bullshit > GetGameTime(npc.index))
	{
		b_NpcIsInvulnerable[npc.index] = true;
	}
	if(i_RaidGrantExtra[npc.index] == RAIDITEM_INDEX_WIN_COND)
		return;
		
	int healthPoints = 20;

	if(npc.m_bFakeClone)
	{
		for(int i; i < i_MaxcountNpcTotal; i++)
		{
			int other = EntRefToEntIndex(i_ObjectsNpcsTotal[i]);
			if(other != INVALID_ENT_REFERENCE && other != npc.index)
			{
				if(i_NpcInternalId[npc.index] == i_NpcInternalId[other])
				{
					if(!view_as<RaidbossBobTheFirst>(other).m_bFakeClone && IsEntityAlive(other) && GetTeam(other) == GetTeam(npc.index))
					{
						if(view_as<RaidbossBobTheFirst>(other).Anger)
						{
							healthPoints = 19;	// During combine summons
							npc.m_flNextMeleeAttack = gameTime + 10.0;
						}
						else
						{
							healthPoints = GetEntProp(other, Prop_Data, "m_iHealth") * 20 / GetEntProp(other, Prop_Data, "m_iMaxHealth");
						}
						
						break;
					}
				}
			}
		}
	}
	else
	{
		healthPoints = GetEntProp(npc.index, Prop_Data, "m_iHealth") * 20 / GetEntProp(npc.index, Prop_Data, "m_iMaxHealth");
	}
	if(npc.m_bFakeClone)
	{
		for(int i; i < i_MaxcountNpcTotal; i++)
		{
			int other = EntRefToEntIndex(i_ObjectsNpcsTotal[i]);
			if(other != INVALID_ENT_REFERENCE && other != npc.index)
			{
				if(i_NpcInternalId[npc.index] == i_NpcInternalId[other])
				{
					if(!view_as<RaidbossBobTheFirst>(other).m_bFakeClone && IsEntityAlive(other) && GetTeam(other) == GetTeam(npc.index))
					{
						SetEntProp(npc.index, Prop_Data, "m_iHealth", GetEntProp(other, Prop_Data, "m_iHealth"));
						SetEntProp(npc.index, Prop_Data, "m_iMaxHealth", GetEntProp(other, Prop_Data, "m_iMaxHealth"));
						
						break;
					}
				}
			}
		}
	}
	if(!npc.m_bFakeClone && LastMann)
	{
		if(!npc.m_fbGunout)
		{
			npc.m_fbGunout = true;
			switch(GetRandomInt(0,2))
			{
				case 0:
				{
					CPrintToChatAll("{white}%s{default}: One infected left.", c_NpcName[npc.index]);
				}
				case 1:
				{
					CPrintToChatAll("{white}%s{default}: This nightmare ends soon.", c_NpcName[npc.index]);
				}
				case 3:
				{
					CPrintToChatAll("{white}%s{default}: Last. Infected. Left.", c_NpcName[npc.index]);
				}
			}
		}
	}
	//Raidmode timer runs out, they lost.
	if(!npc.m_bFakeClone && npc.m_flNextThinkTime != FAR_FUTURE && RaidModeTime < GetGameTime())
	{
		if(healthPoints < 20)
		{
			if(IsValidEntity(RaidBossActive))
			{
				ForcePlayerLoss();
			}

			for(int client = 1; client <= MaxClients; client++)
			{
				if(IsClientInGame(client) && IsPlayerAlive(client))
					ForcePlayerSuicide(client);
			}

			switch(GetURandomInt() % 3)
			{
				case 0:
					CPrintToChatAll("{white}%s{default}: You weren't supposed to have this infection.", c_NpcName[npc.index]);
				
				case 1:
					CPrintToChatAll("{white}%s{default}: No choice but to kill you, it consumes you.", c_NpcName[npc.index]);
				
				case 2:
					CPrintToChatAll("{white}%s{default}: Nobody wins.", c_NpcName[npc.index]);
			}
			
			// Play funny animation intro
			NPC_StopPathing(npc.index);
			npc.m_flNextThinkTime = FAR_FUTURE;
			npc.SetActivity("ACT_IDLE_ZOMBIE");
		}
		else
		{

			CPrintToChatAll("{white}%s{default}: I guess you werent infected, i'm sorry.", c_NpcName[npc.index]);
			
			// Play funny animation intro
			NPC_StopPathing(npc.index);
			npc.m_flNextThinkTime = FAR_FUTURE;
			GivePlayerItems(1);
			ForcePlayerWin();
		}

	}

	if(npc.m_flNextDelayTime > gameTime)
		return;

	npc.m_flNextDelayTime = gameTime + DEFAULT_UPDATE_DELAY_FLOAT;
	npc.Update();
	
	if(npc.m_flNextThinkTime > gameTime)
		return;
	
	//npc.m_flNextThinkTime = gameTime + 0.05;

	if(i_RaidGrantExtra[npc.index] > 1)
	{
		NPC_StopPathing(npc.index);
		npc.m_flNextThinkTime = FAR_FUTURE;
		npc.SetActivity("ACT_IDLE_SHIELDZOBIE");
		RaidModeTime += 1000.0;

		if(XenoExtraLogic())
		{
			switch(i_RaidGrantExtra[npc.index])
			{
				case 2:
				{
					ReviveAll(true);
					CPrintToChatAll("{white}Bob the First{default}: So...");
					npc.m_flNextThinkTime = gameTime + 5.0;
				}
				case 3:
				{
					CPrintToChatAll("{white}Bob the First{default}: What do you think will happpen..?");
					npc.m_flNextThinkTime = gameTime + 4.0;
				}
				case 4:
				{
					CPrintToChatAll("{white}Bob the First{default}: What if you killed Seaborn before Xeno..?");
					npc.m_flNextThinkTime = gameTime + 4.0;
				}
				case 5:
				{
					CPrintToChatAll("{white}Bob the First{default}: Well nothing is holding this one back now...");
					npc.m_flNextThinkTime = gameTime + 4.0;
				}
				case 6:
				{
					CPrintToChatAll("{white}Bob the First{default}: ...");
					npc.m_flNextThinkTime = gameTime + 3.0;
				}
				case 7:
				{
					GiveProgressDelay(1.0);
					SmiteNpcToDeath(npc.index);

					Enemy enemy;

					enemy.Index = NPC_GetByPlugin("npc_xeno_raidboss_nemesis");
					enemy.Health = 40000000;
					enemy.Is_Boss = 2;
					enemy.ExtraSpeed = 1.5;
					enemy.ExtraDamage = 3.0;
					enemy.ExtraMeleeRes = 0.5;
					enemy.ExtraRangedRes = 0.5;
					enemy.ExtraSize = 1.0;
					enemy.Team = GetTeam(npc.index);

					Waves_AddNextEnemy(enemy);

					Zombies_Currently_Still_Ongoing++;

					CreateTimer(0.9, Bob_DeathCutsceneCheck, _, TIMER_FLAG_NO_MAPCHANGE|TIMER_REPEAT);
				}
			}
		}
		else
		{
			switch(i_RaidGrantExtra[npc.index])
			{
				case 2:
				{
					ReviveAll(true);
					CPrintToChatAll("{white}Bob the First{default}: No...");
					npc.m_flNextThinkTime = gameTime + 5.0;
				}
				case 3:
				{
					CPrintToChatAll("{white}Bob the First{default}: This infection...");
					npc.m_flNextThinkTime = gameTime + 3.0;
				}
				case 4:
				{
					CPrintToChatAll("{white}Bob the First{default}: How did this thing make you this powerful..?");
					npc.m_flNextThinkTime = gameTime + 4.0;
				}
				case 5:
				{
					CPrintToChatAll("{white}Bob the First{default}: Took out every single Seaborn and took the infection in yourselves...");
					npc.m_flNextThinkTime = gameTime + 4.0;
				}
				case 6:
				{
					CPrintToChatAll("{white}Bob the First{default}: You people fighting these cities and infections...");
					npc.m_flNextThinkTime = gameTime + 4.0;
				}
				case 7:
				{
					CPrintToChatAll("{white}Bob the First{default}: However...");
					npc.m_flNextThinkTime = gameTime + 3.0;
				}
				case 8:
				{
					CPrintToChatAll("{white}Bob the First{default}: I will remove what does not belong to you...");
					npc.m_flNextThinkTime = gameTime + 3.0;
				}
				case 50:
				{
					SmiteNpcToDeath(npc.index);
					GivePlayerItems();
				}
				default:
				{
					bool found;

					for(int client = 1; client <= MaxClients; client++)
					{
						if(IsClientInGame(client) && IsPlayerAlive(client) && TeutonType[client] == TEUTON_NONE)
						{
							float pos[3]; GetEntPropVector(client, Prop_Data, "m_vecAbsOrigin", pos);
							float ang[3];
							ang[1] = GetRandomFloat(-179.0, 179.0);

							TeleportEntity(npc.index, pos);

							npc.m_iState = -1;
							npc.SetActivity("ACT_PUSH_PLAYER");
							npc.SetPlaybackRate(3.0);

							npc.DispatchParticleEffect(npc.index, "mvm_soldier_shockwave", NULL_VECTOR, NULL_VECTOR, NULL_VECTOR, npc.FindAttachment("anim_attachment_LH"), PATTACH_POINT_FOLLOW, true);
							npc.PlayRandomEnemyPullSound();

							ForcePlayerSuicide(client);
							ApplyLastmanOrDyingOverlay(client);
							found = true;
							break;
						}
					}

					// Don't lose when everyone dies
					GiveProgressDelay(15.0);
					Waves_ForceSetup(15.0);

					if(found)
					{
						npc.m_flNextThinkTime = gameTime + 0.25;
						i_RaidGrantExtra[npc.index]--;
					}
					else
					{
						npc.AddGesture("ACT_IDLE_ZOMBIE");
						npc.m_flNextThinkTime = gameTime + 1.25;
						
						for(int client = 1; client <= MaxClients; client++)
						{
							if(IsClientInGame(client) && !IsFakeClient(client))
							{
								ApplyLastmanOrDyingOverlay(client);
								SendConVarValue(client, sv_cheats, "1");
							}
						}
						ResetReplications();

						cvarTimeScale.SetFloat(0.1);
						CreateTimer(0.5, SetTimeBack);
						i_RaidGrantExtra[npc.index] = 49;
					}
				}
			}
		}

		i_RaidGrantExtra[npc.index]++;
		return;
	}

	if(npc.Anger)	// Waiting for enemies to die off
	{
		float enemies = float(Zombies_Currently_Still_Ongoing);

		for(int i; i < i_MaxcountNpcTotal; i++)
		{
			int victim = EntRefToEntIndex(i_ObjectsNpcsTotal[i]);
			if(victim != INVALID_ENT_REFERENCE && victim != npc.index && IsEntityAlive(victim) && GetTeam(victim) != TFTeam_Red)
			{
				int maxhealth = GetEntProp(victim, Prop_Data, "m_iMaxHealth");
				if(maxhealth)
					enemies += float(GetEntProp(victim, Prop_Data, "m_iHealth")) / float(maxhealth);
			}
		}

		if(!Waves_IsEmpty())
		{
			SetEntProp(npc.index, Prop_Data, "m_iHealth", RoundToCeil(float(GetEntProp(npc.index, Prop_Data, "m_iMaxHealth")) * (enemies + 1.0) / 485.0));
			return;
		}

		GiveOneRevive();
		RaidModeTime += 140.0;

		npc.m_flRangedArmor = 0.9;
		npc.m_flMeleeArmor = 1.125;
		npc.g_TimesSummoned = 0;

		npc.PlaySummonDeadSound();
		
		npc.Anger = false;
		npc.m_bSecondPhase = true;
		strcopy(c_NpcName[npc.index], sizeof(c_NpcName[]), "Bob the First");
		SetEntProp(npc.index, Prop_Data, "m_iHealth", GetEntProp(npc.index, Prop_Data, "m_iMaxHealth") * 17 / 20);

		if(XenoExtraLogic())
		{
			switch(GetURandomInt() % 3)
			{
				case 0:
					CPrintToChatAll("{white}Bob the First{default}: You're in the wrong place in the wrong time!");
				
				case 1:
					CPrintToChatAll("{white}Bob the First{default}: This is not how it goes!");
				
				case 2:
					CPrintToChatAll("{white}Bob the First{default}: Stop trying to change fate!");
			}
		}
		else
		{
			switch(GetURandomInt() % 4)
			{
				case 0:
					CPrintToChatAll("{white}Bob the First{default}: Enough of this!");
				
				case 1:
					CPrintToChatAll("{white}Bob the First{default}: Do you see yourself? Your slaughter?");
				
				case 2:
					CPrintToChatAll("{white}Bob the First{default}: You are no god.");
				
				case 3:
					CPrintToChatAll("{white}Bob the First{default}: Xeno. Seaborn. Then there's you.");
			}
		}

		npc.m_flNextMeleeAttack = gameTime + 2.0;
	}

	if(npc.m_flGetClosestTargetTime < gameTime || !IsEntityAlive(npc.m_iTarget))
	{
		npc.m_iTarget = GetClosestTarget(npc.index);
		npc.m_flGetClosestTargetTime = gameTime + 1.0;

		if(!npc.m_bFakeClone && b_NpcIsInvulnerable[npc.index])
		{
			b_NpcIsInvulnerable[npc.index] = false;
			npc.PlayIntroEndSound();
		}
	}

	if(!npc.m_bFakeClone)
	{
		int summon;

		switch(npc.g_TimesSummoned)
		{
			case -2, -1, 0:
			{
				if(healthPoints < 16)
					summon = 1;
			}
			case 1:
			{
				if(healthPoints < 11)
					summon = 1;
			}
			case 2:
			{
				if(healthPoints < 6)
					summon = 1;
			}
		}

		if(summon)
		{
			// Summon
			npc.g_TimesSummoned++;

			float pos[3]; GetEntPropVector(npc.index, Prop_Data, "m_vecAbsOrigin", pos);
			float ang[3]; GetEntPropVector(npc.index, Prop_Data, "m_angRotation", ang);
			summon = NPC_CreateById(i_NpcInternalId[npc.index], -1, pos, ang, GetTeam(npc.index), "fake");
			if(summon > MaxClients)
			{
				fl_Extra_Damage[summon] = fl_Extra_Damage[npc.index] * 0.5;
				fl_Extra_Speed[summon] = fl_Extra_Speed[npc.index] * 0.75;

				SetEntityRenderMode(summon, RENDER_TRANSALPHA);
				SetEntityRenderColor(summon, 200, 200, 200, 200);
			}
		}
	}

	if(!npc.m_bFakeClone && !npc.m_bSecondPhase)
	{
		if(healthPoints < 9)
		{
			if(npc.b_SwordIgnition)
			{
				AcceptEntityInput(npc.m_iWearable1, "Disable");
				ExtinguishTarget(npc.m_iWearable1);
				npc.b_SwordIgnition = false;
			}
			
			GiveOneRevive();
			RaidModeTime += 260.0;

			npc.Anger = true;
			npc.SetActivity("ACT_IDLE_ZOMBIE");
			strcopy(c_NpcName[npc.index], sizeof(c_NpcName[]), "??? the First");

			npc.PlaySummonSound();
			
			SetupMidWave(npc.index);
			return;
		}
		else if(healthPoints < 15)
		{
			strcopy(c_NpcName[npc.index], sizeof(c_NpcName[]), "??????? First");
		}
	}

	if(npc.m_iTarget > 0 && healthPoints < 20)
	{
		float vecMe[3]; WorldSpaceCenter(npc.index, vecMe);
		float vecTarget[3]; WorldSpaceCenter(npc.m_iTarget, vecTarget );

		switch(npc.m_iAttackType)
		{
			case 2:	// COMBO1 - Frame 44
			{
				if(npc.m_flAttackHappens < gameTime)
				{
					BobInitiatePunch(npc.index, vecTarget, vecMe, 0.999, 4000.0, true);
					
					npc.m_iAttackType = 3;
					npc.m_flAttackHappens = gameTime + 0.899;
				}
			}
			case 3:	// COMBO1 - Frame 54
			{
				if(npc.m_flAttackHappens < gameTime)
				{
					BobInitiatePunch(npc.index, vecTarget, vecMe, 0.5, 2000.0, false);
					
					npc.m_iAttackType = 0;
					npc.m_flAttackHappens = gameTime + 1.555;
				}
			}
			case 4:	// COMBO2 - Frame 32
			{
				if(npc.m_flAttackHappens < gameTime)
				{
					BobInitiatePunch(npc.index, vecTarget, vecMe, 0.833, 2000.0, false);
					
					npc.m_iAttackType = 5;
					npc.m_flAttackHappens = gameTime + 0.833;
				}
			}
			case 5:	// COMBO2 - Frame 52
			{
				if(npc.m_flAttackHappens < gameTime)
				{
					BobInitiatePunch(npc.index, vecTarget, vecMe, 0.833, 2000.0, false);
					
					npc.m_iAttackType = 6;
					npc.m_flAttackHappens = gameTime + 0.833;
				}
			}
			case 6:	// COMBO2 - Frame 73
			{
				if(npc.m_flAttackHappens < gameTime)
				{
					BobInitiatePunch(npc.index, vecTarget, vecMe, 0.875, 2000.0, true);
					
					npc.m_iAttackType = 0;
					npc.m_flAttackHappens = gameTime + 1.083;
				}
			}
			case 8:	// DEPLOY_MANHACK - Frame 32
			{
				if(npc.m_flAttackHappens < gameTime)
				{
					npc.m_iAttackType = 0;
					npc.m_flAttackHappens = gameTime + 0.333;

					int projectile = npc.FireParticleRocket(vecTarget, 3000.0, GetRandomFloat(175.0, 225.0), 150.0, "utaunt_glitter_teamcolor_blue", true);
					npc.DispatchParticleEffect(npc.index, "rd_robot_explosion_shockwave", NULL_VECTOR, NULL_VECTOR, NULL_VECTOR, npc.FindAttachment("anim_attachment_LH"), PATTACH_POINT_FOLLOW, true);
					
					SDKUnhook(projectile, SDKHook_StartTouch, Rocket_Particle_StartTouch);
					
					SDKHook(projectile, SDKHook_StartTouch, Bob_Rocket_Particle_StartTouch);
					npc.PlayRocketHoming();
					float ang_Look[3];
					GetEntPropVector(projectile, Prop_Send, "m_angRotation", ang_Look);
					Initiate_HomingProjectile(projectile,
						npc.index,
						70.0,			// float lockonAngleMax,
						10.0,				//float homingaSec,
						false,				// bool LockOnlyOnce,
						true,				// bool changeAngles,
						ang_Look);// float AnglesInitiate[3]);
					static float EnemyPos[3];
					static float pos[3]; 
					GetEntPropVector(npc.index, Prop_Send, "m_vecOrigin", pos);

					if(!npc.m_bFakeClone)
					{
						for(int EnemyLoop; EnemyLoop <= MaxClients; EnemyLoop ++)
						{	
							if(IsValidEnemy(npc.index, EnemyLoop))
							{
								GetEntPropVector(EnemyLoop, Prop_Send, "m_vecOrigin", EnemyPos);
								//only apply the laser if they are near us.
								if(IsValidClient(EnemyLoop) && Can_I_See_Enemy_Only(npc.index, EnemyLoop) && IsEntityAlive(EnemyLoop))
								{
									//Pull them.
									static float angles[3];
									GetVectorAnglesTwoPoints(pos, EnemyPos, angles);

									if (GetEntityFlags(EnemyLoop) & FL_ONGROUND)
										angles[0] = 0.0; // toss out pitch if on ground

									static float velocity[3];
									GetAngleVectors(angles, velocity, NULL_VECTOR, NULL_VECTOR);
									ScaleVector(velocity, 150.0);
													
													
									// min Z if on ground
									if (GetEntityFlags(EnemyLoop) & FL_ONGROUND)
										velocity[2] = fmax(325.0, velocity[2]);
												
									// apply velocity
									TeleportEntity(EnemyLoop, NULL_VECTOR, NULL_VECTOR, velocity);   
								}
							}
						}
					}
				}
			}
			case 9:
			{
				PredictSubjectPosition(npc, npc.m_iTarget,_,_, vecTarget);
				NPC_SetGoalVector(npc.index, vecTarget);

				npc.FaceTowards(vecTarget, 20000.0);
				
				if(npc.m_flAttackHappens < gameTime)
				{
					npc.m_iAttackType = 0;

					KillFeed_SetKillIcon(npc.index, "sword");

					int HowManyEnemeisAoeMelee = 64;
					Handle swingTrace;
					npc.DoSwingTrace(swingTrace, npc.m_iTarget,_,_,_,1,_,HowManyEnemeisAoeMelee);
					delete swingTrace;
					bool PlaySound = false;
					for (int counter = 1; counter <= HowManyEnemeisAoeMelee; counter++)
					{
						if (i_EntitiesHitAoeSwing_NpcSwing[counter] > 0)
						{
							if(IsValidEntity(i_EntitiesHitAoeSwing_NpcSwing[counter]))
							{
								PlaySound = true;
								int target = i_EntitiesHitAoeSwing_NpcSwing[counter];
								float vecHit[3];
								WorldSpaceCenter(target, vecHit);

								SDKHooks_TakeDamage(target, npc.index, npc.index, 250.0, DMG_CLUB, -1, _, vecHit);	
								
								bool Knocked = false;

								
								if(IsValidClient(target))
								{
									if (IsInvuln(target))
									{
										Knocked = true;
										Custom_Knockback(npc.index, target, 1000.0, true);
										TF2_AddCondition(target, TFCond_LostFooting, 0.5);
										TF2_AddCondition(target, TFCond_AirCurrent, 0.5);
									}									
									else
									{
										float VulnerabilityToGive = 0.10;
										if(npc.m_bFakeClone)
											VulnerabilityToGive = 0.05;
										IncreaceEntityDamageTakenBy(target, VulnerabilityToGive, 10.0, true);
									}	
	
								}
								else
								{
									float VulnerabilityToGive = 0.10;
									if(npc.m_bFakeClone)
										VulnerabilityToGive = 0.05;

									IncreaceEntityDamageTakenBy(target, VulnerabilityToGive, 10.0, true);
								}	
								if(!Knocked)
									Custom_Knockback(npc.index, target, 150.0, true);
							}
						} 
					}

					if(PlaySound)
						npc.PlayMeleeSound();

					KillFeed_SetKillIcon(npc.index, "tf_projectile_rocket");
				}
			}
			case 10:	// DEPLOY_MANHACK - Frame 32
			{
				if(npc.m_flAttackHappens < gameTime)
				{
					npc.m_iAttackType = 0;
					npc.m_flAttackHappens = gameTime + 0.333;

					int ref = EntIndexToEntRef(npc.index);

					Handle data = CreateDataPack();
					WritePackFloat(data, vecMe[0]);
					WritePackFloat(data, vecMe[1]);
					WritePackFloat(data, vecMe[2]);
					WritePackCell(data, 95.0); // Distance
					WritePackFloat(data, 0.0); // nphi
					WritePackFloat(data, 250.0); // Range
					WritePackFloat(data, 1000.0); // Damge
					WritePackCell(data, ref);
					ResetPack(data);
					TrueFusionwarrior_IonAttack(data);

					for(int client = 1; client <= MaxClients; client++)
					{
						if(IsClientInGame(client) && IsPlayerAlive(client) && TeutonType[client] == TEUTON_NONE)
						{
							GetEntPropVector(client, Prop_Data, "m_vecAbsOrigin", vecTarget);
							
							data = CreateDataPack();
							WritePackFloat(data, vecTarget[0]);
							WritePackFloat(data, vecTarget[1]);
							WritePackFloat(data, vecTarget[2]);
							WritePackCell(data, 160.0); // Distance
							WritePackFloat(data, 0.0); // nphi
							WritePackFloat(data, 250.0); // Range
							WritePackFloat(data, 1000.0); // Damge
							WritePackCell(data, ref);
							ResetPack(data);
							TrueFusionwarrior_IonAttack(data);
						}
					}
				}
			}
			case 11, 12:
			{
				float distance = GetVectorDistance(vecTarget, vecMe, true);
				if(distance < npc.GetLeadRadius()) 
				{
					PredictSubjectPosition(npc, npc.m_iTarget,_,_, vecTarget);
					NPC_SetGoalVector(npc.index, vecTarget);
				}
				else
				{
					NPC_SetGoalEntity(npc.index, npc.m_iTarget);
				}

				npc.StartPathing();
				npc.SetActivity("ACT_DARIO_WALK");

				if(npc.m_iAttackType == 12)
					npc.m_flSpeed = 192.0;
				
				if(npc.m_flAttackHappens < gameTime)
				{
					if(npc.m_iAttackType == 11)
					{
						npc.m_iAttackType = 12;
						npc.AddGesture("ACT_DARIO_ATTACK_GUN_1");
						npc.m_flAttackHappens = gameTime + 0.4;
					}
					else
					{
						npc.m_iAttackType = 11;
						npc.m_flAttackHappens = gameTime + 0.5;
						
						PredictSubjectPositionForProjectiles(npc, npc.m_iTarget, 1600.0,_,vecTarget);
						npc.FireRocket(vecTarget, 600.0, 1600.0, "models/weapons/w_bullet.mdl", 2.0);
						npc.PlayGunSound();

						if(npc.m_bFakeClone)
							npc.m_flAttackHappens += GetRandomFloat(0.0, 0.2);
					}
				}

				npc.FaceTowards(vecTarget, 2500.0);
			}
			case 13, 14:
			{
				npc.StopPathing();
				
				if(npc.m_flAttackHappens < gameTime)
				{
					if(npc.m_iAttackType == 13)
					{
						npc.m_iAttackType = 14;
						npc.m_iState = -1;	// Replay the animation regardless
						npc.SetActivity("ACT_PUSH_PLAYER");
						npc.SetPlaybackRate(2.0);
						npc.m_flAttackHappens = gameTime + 0.2;
					}
					else
					{
						static bool ClientTargeted[MAXENTITIES];
						static int TotalEnemeisInSight;


						//initiate only once per ability
						UnderTides npcGetInfo = view_as<UnderTides>(npc.index);
						if(npc.m_iPullCount == 0)
						{
							Zero(ClientTargeted);
							TotalEnemeisInSight = 0;
							int enemy_2[MAXENTITIES];
							GetHighDefTargets(npcGetInfo, enemy_2, sizeof(enemy_2), true, false);
							for(int i; i < sizeof(enemy_2); i++)
							{
								if(enemy_2[i])
								{
									TotalEnemeisInSight++;
								}
							}
							TotalEnemeisInSight /= 2;
							if(TotalEnemeisInSight <= 1)
							{
								TotalEnemeisInSight = 1;
							}
						}


						int enemy_2[MAXENTITIES];
						int EnemyToPull = 0;
						GetHighDefTargets(npcGetInfo, enemy_2, sizeof(enemy_2), true, false);
						for(int i; i < sizeof(enemy_2); i++)
						{
							if(enemy_2[i] && !ClientTargeted[enemy_2[i]])
							{
								EnemyToPull = enemy_2[i];
								ClientTargeted[enemy_2[i]] = true;
								break;
							}
						}

						npc.DispatchParticleEffect(npc.index, "mvm_soldier_shockwave", NULL_VECTOR, NULL_VECTOR, NULL_VECTOR, npc.FindAttachment("anim_attachment_LH"), PATTACH_POINT_FOLLOW, true);
						npc.PlayRandomEnemyPullSound();

						if(npc.m_iPullCount > TotalEnemeisInSight)
						{
							// After X pulls, revert to normal
							npc.m_iAttackType = 0;
							npc.m_flAttackHappens = gameTime + 0.2;
						}
						else
						{
							// Play animation delay
							npc.m_iAttackType = 13;
							npc.m_flAttackHappens = gameTime + 0.2;
							npc.m_iPullCount++;
						}

						if(EnemyToPull)
						{
							PredictSubjectPosition(npc, EnemyToPull,_,_,vecTarget);
							npc.FaceTowards(vecTarget, 50000.0);
							
							if(!npc.m_bFakeClone)
							{
								BobPullTarget(npc.index, EnemyToPull);
							}
							
							//We succsssfully pulled someone.
							//Take their old position and nuke it.
							float vEnd[3];
					
							GetAbsOrigin(EnemyToPull, vEnd);
							Handle pack;
							CreateDataTimer(BOB_CHARGE_SPAN, Smite_Timer_Bob, pack, TIMER_REPEAT|TIMER_FLAG_NO_MAPCHANGE);
							WritePackCell(pack, EntIndexToEntRef(npc.index));
							WritePackFloat(pack, 0.0);
							WritePackFloat(pack, vEnd[0]);
							WritePackFloat(pack, vEnd[1]);
							WritePackFloat(pack, vEnd[2]);
							if(!npc.m_bFakeClone)
							{
								WritePackFloat(pack, 1000.0);
							}
							else
								WritePackFloat(pack, 650.0);
								
							spawnRing_Vectors(vEnd, BOB_FIRST_LIGHTNING_RANGE * 2.0, 0.0, 0.0, 0.0, "materials/sprites/laserbeam.vmt", 255, 125, 125, 200, 1, BOB_CHARGE_TIME, 6.0, 0.1, 1, 1.0);
						}
					}
				}
			}
			default:
			{
				if(npc.m_flAttackHappens < gameTime)
				{
					if(healthPoints < 19 && npc.m_flNextMeleeAttack < gameTime)
					{
						if(npc.b_SwordIgnition)
						{
							AcceptEntityInput(npc.m_iWearable1, "Disable");
							ExtinguishTarget(npc.m_iWearable1);
							npc.b_SwordIgnition = false;
						}
						
						npc.m_flNextMeleeAttack = gameTime + 10.0;
						npc.StopPathing();
						WorldSpaceCenter(npc.index, vecMe);

						switch(GetURandomInt() % 3)
						{
							case 0:
							{
								npc.SetActivity("ACT_COMBO1_BOBPRIME");
								npc.m_iAttackType = 2;
								npc.m_flAttackHappens = gameTime + 0.916;
								
								BobInitiatePunch(npc.index, vecTarget, vecMe, 0.916, 2000.0, true);
							}
							case 1:
							{
								npc.SetActivity("ACT_COMBO2_BOBPRIME");
								npc.m_iAttackType = 4;
								npc.m_flAttackHappens = gameTime + 0.5;
								
								BobInitiatePunch(npc.index, vecTarget, vecMe, 0.5, 2000.0, false);
							}
							case 2:
							{
								npc.SetActivity("ACT_COMBO3_BOBPRIME");
								npc.m_flAttackHappens = gameTime + 3.25;
								
								BobInitiatePunch(npc.index, vecTarget, vecMe, 2.125, 8000.0, true);
							}
						}

						if(npc.m_bFakeClone)
							npc.m_flNextMeleeAttack += GetRandomFloat(5.0, 10.0);
					}
					else if(healthPoints < 17 && npc.m_flNextRangedAttack < gameTime)
					{
						npc.m_flNextRangedAttack = gameTime + (healthPoints < 9 ? 6.0 : 12.0);
						npc.PlayRangedSound();
						npc.StopPathing();

						npc.SetActivity("ACT_METROPOLICE_DEPLOY_MANHACK");
						npc.m_iAttackType = 8;
						npc.m_flAttackHappens = gameTime + 1.0;

						if(npc.m_bFakeClone)
							npc.m_flNextRangedAttack += GetRandomFloat(20.0, 30.0);
					}
					else if(!npc.m_bFakeClone && healthPoints < 11 && npc.m_flNextRangedSpecialAttack < gameTime)
					{
						npc.m_flNextRangedSpecialAttack = gameTime + (healthPoints < 7 ? 15.0 : 27.0);
						npc.StopPathing();
						npc.PlaySkyShieldSound();

						npc.SetActivity("ACT_METROPOLICE_DEPLOY_MANHACK");
						npc.m_iAttackType = 10;
						npc.m_flAttackHappens = gameTime + 1.0;

						if(npc.m_bFakeClone)
							npc.m_flNextRangedSpecialAttack += GetRandomFloat(15.0, 25.0);
					}
					else if(healthPoints < 15 && npc.m_flNextChargeSpecialAttack < gameTime)
					{
						// Start pull attack chain
						npc.m_flNextChargeSpecialAttack = gameTime + (healthPoints < 7 ? 15.0 : 27.0);
						npc.StopPathing();

						npc.m_iAttackType = 13;
						npc.m_iPullCount = 0;
						//npc.m_flAttackHappens = gameTime + 1.0;
					}
					else if(healthPoints < 3 && npc.m_bFakeClone)
					{
						npc.m_flSpeed = 1.0;
						npc.m_iAttackType = 11;
						npc.m_flAttackHappens = gameTime + 1.333;

						npc.AddGesture("ACT_METROCOP_DEPLOY_PISTOL");
						
						if(IsValidEntity(npc.m_iWearable1))
							RemoveEntity(npc.m_iWearable1);
						
						npc.m_iWearable1 = npc.EquipItem("anim_attachment_RH", "models/weapons/w_pistol.mdl");
						SetVariantString("2.0");
						AcceptEntityInput(npc.m_iWearable1, "SetModelScale");
					}
					else
					{
						if(!npc.b_SwordIgnition)
						{
							AcceptEntityInput(npc.m_iWearable1, "Enable");
							IgniteTargetEffect(npc.m_iWearable1);
							npc.b_SwordIgnition = true;
						}

						float speed = healthPoints < 13 ? 330.0 : 290.0;
						if(npc.m_flSpeed != speed)
						{
							npc.m_flSpeed = speed;
							if(healthPoints == 12)
								npc.PlaySpeedUpSound();
						}
						
						float distance = GetVectorDistance(vecTarget, vecMe, true);
						if(distance < npc.GetLeadRadius()) 
						{
							PredictSubjectPosition(npc, npc.m_iTarget,_,_, vecTarget);
							NPC_SetGoalVector(npc.index, vecTarget);
						}
						else
						{
							NPC_SetGoalEntity(npc.index, npc.m_iTarget);
						}

						npc.StartPathing();
						
						if(distance < 10000.0)	// 100 HU
						{
							npc.StopPathing();
							
							npc.SetActivity("ACT_RUN_BOB");
							npc.AddGesture("ACT_MELEE_BOB");
							npc.m_iAttackType = 9;
							npc.m_flAttackHappens = gameTime + 0.35;
							npc.PlayMeleeHitSound();
							//SPAWN COOL EFFECT
							float flPos[3];
							float flAng[3];
							GetAttachment(npc.index, "special_weapon_effect", flPos, flAng);
							int particle = ParticleEffectAt(flPos, "raygun_projectile_red_crit", 0.45);	
							SetParent(npc.index, particle, "special_weapon_effect");
						}
						else
						{
							npc.SetActivity("ACT_RUN_BOB");
						}
					}
				}
			}
		}
	}
	else
	{
		if(npc.b_SwordIgnition)
		{
			AcceptEntityInput(npc.m_iWearable1, "Disable");
			ExtinguishTarget(npc.m_iWearable1);
			npc.b_SwordIgnition = false;
		}
		
		npc.StopPathing();
		npc.SetActivity("ACT_IDLE_BOBPRIME");
	}
}

static void GiveOneRevive()
{
	for(int client = 1; client <= MaxClients; client++)
	{
		if(IsClientInGame(client))
		{
			int glowentity = EntRefToEntIndex(i_DyingParticleIndication[client][0]);
			if(glowentity > MaxClients)
				RemoveEntity(glowentity);
			
			glowentity = EntRefToEntIndex(i_DyingParticleIndication[client][1]);
			if(glowentity > MaxClients)
				RemoveEntity(glowentity);
			
			if(IsPlayerAlive(client))
			{
				SetEntityMoveType(client, MOVETYPE_WALK);
				TF2_AddCondition(client, TFCond_SpeedBuffAlly, 0.00001);
				int entity, i;
				while(TF2U_GetWearable(client, entity, i))
				{
					if(entity == EntRefToEntIndex(Armor_Wearable[client]) || i_WeaponVMTExtraSetting[entity] != -1)
						continue;

					SetEntityRenderMode(entity, RENDER_NORMAL);
					SetEntityRenderColor(entity, 255, 255, 255, 255);
				}
			}
			
			ForcePlayerCrouch(client, false);
			//just make visible.
			SetEntityRenderMode(client, RENDER_NORMAL);
			SetEntityRenderColor(client, 255, 255, 255, 255);
			
			i_AmountDowned[client]--;
			if(i_AmountDowned[client] < 0)
				i_AmountDowned[client] = 0;
			
			DoOverlay(client, "", 2);
			if(GetClientTeam(client) == 2)
			{
				if((!IsPlayerAlive(client) || TeutonType[client] == TEUTON_DEAD))
				{
					DHook_RespawnPlayer(client);
					GiveCompleteInvul(client, 2.0);
				}
				else if(dieingstate[client] > 0)
				{
					GiveCompleteInvul(client, 2.0);

					if(b_LeftForDead[client])
					{
						dieingstate[client] = -8; //-8 for incode reasons, check dieing timer.
					}
					else
					{
						dieingstate[client] = 0;
					}

					Store_ApplyAttribs(client);
					TF2_AddCondition(client, TFCond_SpeedBuffAlly, 0.00001);

					int entity, i;
					while(TF2U_GetWearable(client, entity, i))
					{
						if(entity == EntRefToEntIndex(Armor_Wearable[client]) || i_WeaponVMTExtraSetting[entity] != -1)
							continue;

						SetEntityRenderMode(entity, RENDER_NORMAL);
						SetEntityRenderColor(entity, 255, 255, 255, 255);
					}

					SetEntityRenderMode(client, RENDER_NORMAL);
					SetEntityRenderColor(client, 255, 255, 255, 255);
					SetEntityCollisionGroup(client, 5);

					SetEntityHealth(client, 50);
					RequestFrame(SetHealthAfterRevive, EntIndexToEntRef(client));
				}
			}
		}
	}

	int entity = MaxClients + 1;
	while((entity = FindEntityByClassname(entity, "zr_base_npc")) != -1)
	{
		if(Citizen_IsIt(entity))
		{
			Citizen npc = view_as<Citizen>(entity);
			if(npc.m_nDowned && npc.m_iWearable3 > 0)
				npc.SetDowned(false);
		}
	}

	CheckAlivePlayers();
	WaveEndLogicExtra();
}

static void SetupMidWave(int entity)
{
	AddBobEnemy(entity, "npc_combine_soldier_elite", 20);
	AddBobEnemy(entity, "npc_combine_soldier_swordsman_ddt", 20);
	AddBobEnemy(entity, "npc_combine_soldier_swordsman", 40);
	AddBobEnemy(entity, "npc_combine_soldier_giant_swordsman", 15);
	AddBobEnemy(entity, "npc_combine_soldier_collos_swordsman", 2, 1);

	AddBobEnemy(entity, "npc_combine_soldier_swordsman_ddt", 30);
	AddBobEnemy(entity, "npc_combine_soldier_elite", 20);
	AddBobEnemy(entity, "npc_combine_soldier_giant_swordsman", 20);

	AddBobEnemy(entity, "npc_combine_soldier_swordsman", 40);
	AddBobEnemy(entity, "npc_combine_soldier_swordsman_ddt", 10);
	AddBobEnemy(entity, "npc_combine_soldier_giant_swordsman", 20);

	AddBobEnemy(entity, "npc_combine_soldier_elite", 50);
	AddBobEnemy(entity, "npc_combine_soldier_swordsman_ddt", 50);
	AddBobEnemy(entity, "npc_combine_soldier_shotgun", 50);

	AddBobEnemy(entity, "npc_combine_soldier_elite", 10);
	AddBobEnemy(entity, "npc_combine_soldier_swordsman_ddt", 10);
	AddBobEnemy(entity, "npc_combine_soldier_ar2", 10);
	AddBobEnemy(entity, "npc_combine_soldier_swordsman", 10);
	AddBobEnemy(entity, "npc_combine_soldier_giant_swordsman", 10);
	AddBobEnemy(entity, "npc_combine_soldier_shotgun", 10);
	AddBobEnemy(entity, "npc_combine_soldier_ar2", 10);
	AddBobEnemy(entity, "npc_combine_police_smg", 10);
	AddBobEnemy(entity, "npc_combine_police_pistol", 10);
}

static void AddBobEnemy(int bobindx, const char[] plugin, int count, int boss = 0)
{
	Enemy enemy;

	enemy.Index = NPC_GetByPlugin(plugin);
	enemy.Is_Boss = boss;
	enemy.Is_Health_Scaled = 1;
	enemy.ExtraMeleeRes = 0.05;
	enemy.ExtraRangedRes = 0.05;
	enemy.ExtraSpeed = 1.5;
	enemy.ExtraDamage = 4.0;
	enemy.ExtraSize = 1.0;
	enemy.Team = GetTeam(bobindx);

	for(int i; i < count; i++)
	{
		Waves_AddNextEnemy(enemy);
	}
}

Action RaidbossBobTheFirst_OnTakeDamage(int victim, int &attacker, int &inflictor, float &damage, int &damagetype, int &weapon, float damageForce[3], float damagePosition[3], int damagecustom)
{
	//Valid attackers only.
	if(attacker < 1)
		return Plugin_Continue;

	RaidbossBobTheFirst npc = view_as<RaidbossBobTheFirst>(victim);
	
	if(npc.Anger || npc.m_bFakeClone || i_RaidGrantExtra[npc.index] > 1)
	{
		damage = 0.0;
		return Plugin_Handled;
	}

	if(i_RaidGrantExtra[npc.index] == 1 && Waves_GetRound() > 55)
	{
		if(damage >= GetEntProp(npc.index, Prop_Data, "m_iHealth"))
		{
			if(IsValidEntity(npc.m_iWearable1))
				RemoveEntity(npc.m_iWearable1);
			
			Music_SetRaidMusicSimple("vo/null.mp3", 30, false, 0.5);
			npc.StopPathing();

			RaidBossActive = -1;

			i_RaidGrantExtra[npc.index] = 2;
			b_DoNotUnStuck[npc.index] = true;
			b_CantCollidieAlly[npc.index] = true;
			b_CantCollidie[npc.index] = true;
			SetEntityCollisionGroup(npc.index, 24);
			b_ThisEntityIgnoredByOtherNpcsAggro[npc.index] = true; //Make allied npcs ignore him.
			b_NpcIsInvulnerable[npc.index] = true;
			int GetTeamOld = GetTeam(npc.index);
			RemoveNpcFromEnemyList(npc.index);
			GiveProgressDelay(30.0);
			damage = 0.0;
			
			for(int i; i < i_MaxcountNpcTotal; i++)
			{
				int other = EntRefToEntIndex(i_ObjectsNpcsTotal[i]);
				if(other != INVALID_ENT_REFERENCE && other != npc.index)
				{
					if(i_NpcInternalId[npc.index] == i_NpcInternalId[other])
					{
						if(GetTeamOld == GetTeam(other))
						{
							SmiteNpcToDeath(other);
						}
					}
				}
			}
			return Plugin_Handled;
		}
	}

	return Plugin_Changed;
}

void RaidbossBobTheFirst_NPCDeath(int entity)
{
	RaidbossBobTheFirst npc = view_as<RaidbossBobTheFirst>(entity);
	
	if(IsValidEntity(npc.m_iWearable1))
		RemoveEntity(npc.m_iWearable1);

	Format(WhatDifficultySetting, sizeof(WhatDifficultySetting), "%s",WhatDifficultySetting_Internal);
	WavesUpdateDifficultyName();
	for(int i; i < i_MaxcountNpcTotal; i++)
	{
		int other = EntRefToEntIndex(i_ObjectsNpcsTotal[i]);
		if(other != INVALID_ENT_REFERENCE && other != npc.index)
		{
			if(i_NpcInternalId[npc.index] == i_NpcInternalId[other])
			{
				if(GetTeam(npc.index) == GetTeam(other))
				{
					SmiteNpcToDeath(other);
				}
			}
		}
	}
}

static Action Bob_DeathCutsceneCheck(Handle timer)
{
	if(!LastMann)
		return Plugin_Continue;
	
	for(int i; i < i_MaxcountNpcTotal; i++)
	{
		int victim = EntRefToEntIndex(i_ObjectsNpcsTotal[i]);
		if(victim != INVALID_ENT_REFERENCE && GetTeam(victim) != TFTeam_Red)
			SmiteNpcToDeath(victim);
	}
	
	GiveProgressDelay(6.0);
	Waves_ForceSetup(6.0);

	for(int client = 1; client <= MaxClients; client++)
	{
		if(IsClientInGame(client) && !IsFakeClient(client))
		{
			if(IsPlayerAlive(client))
				ForcePlayerSuicide(client);
			
			ApplyLastmanOrDyingOverlay(client);
			SendConVarValue(client, sv_cheats, "1");
		}
	}
	ResetReplications();

	cvarTimeScale.SetFloat(0.1);
	CreateTimer(0.5, SetTimeBack);

	GivePlayerItems();
	return Plugin_Stop;
}

static void GivePlayerItems(int coolwin = 0)
{
	for(int client = 1; client <= MaxClients; client++)
	{
		if(IsClientInGame(client) && GetClientTeam(client) == 2 && TeutonType[client] != TEUTON_WAITING)
		{
			Items_GiveNamedItem(client, "Bob's Curing Hand");
			if(coolwin == 0)
				CPrintToChat(client, "{default}Bob has defeated you, however... you gained: {yellow}''Bob's Curing Hand''{default}!");
			else
				CPrintToChat(client, "{default}You didnt attack bob for no reason and thus he gives you: {yellow}''Bob's Curing Hand''{default}!");
		}
	}

}

public Action Smite_Timer_Bob(Handle Smite_Logic, DataPack pack)
{
	ResetPack(pack);
	int entity = EntRefToEntIndex(ReadPackCell(pack));
	
	if (!IsValidEntity(entity))
	{
		return Plugin_Stop;
	}
		
	float NumLoops = ReadPackFloat(pack);
	float spawnLoc[3];
	for (int GetVector = 0; GetVector < 3; GetVector++)
	{
		spawnLoc[GetVector] = ReadPackFloat(pack);
	}
	
	float damage = ReadPackFloat(pack);
	
	if (NumLoops >= BOB_CHARGE_TIME)
	{
		float secondLoc[3];
		for (int replace = 0; replace < 3; replace++)
		{
			secondLoc[replace] = spawnLoc[replace];
		}
		
		for (int sequential = 1; sequential <= 5; sequential++)
		{
			spawnRing_Vectors(secondLoc, 1.0, 0.0, 0.0, 0.0, "materials/sprites/laserbeam.vmt", 255, 50, 50, 120, 1, 0.33, 6.0, 0.4, 1, (BOB_FIRST_LIGHTNING_RANGE * 5.0)/float(sequential));
			secondLoc[2] += 150.0 + (float(sequential) * 20.0);
		}
		
		secondLoc[2] = 1500.0;
		
		spawnBeam(0.8, 255, 50, 50, 255, "materials/sprites/laserbeam.vmt", 4.0, 6.2, _, 2.0, secondLoc, spawnLoc);	
		spawnBeam(0.8, 255, 50, 50, 200, "materials/sprites/lgtning.vmt", 4.0, 5.2, _, 2.0, secondLoc, spawnLoc);	
		spawnBeam(0.8, 255, 50, 50, 200, "materials/sprites/lgtning.vmt", 3.0, 4.2, _, 2.0, secondLoc, spawnLoc);	
		
		EmitAmbientSound(SOUND_WAND_LIGHTNING_ABILITY_PAP_SMITE, spawnLoc, _, 120);
		
		DataPack pack_boom = new DataPack();
		pack_boom.WriteFloat(spawnLoc[0]);
		pack_boom.WriteFloat(spawnLoc[1]);
		pack_boom.WriteFloat(spawnLoc[2]);
		pack_boom.WriteCell(0);
		RequestFrame(MakeExplosionFrameLater, pack_boom);
		 
		CreateEarthquake(spawnLoc, 1.0, BOB_FIRST_LIGHTNING_RANGE * 2.5, 16.0, 255.0);
		Explode_Logic_Custom(damage, entity, entity, -1, spawnLoc, BOB_FIRST_LIGHTNING_RANGE * 1.4,_,0.8, true);  //Explosion range increace
	
		return Plugin_Stop;
	}
	else
	{
		spawnRing_Vectors(spawnLoc, BOB_FIRST_LIGHTNING_RANGE * 2.0, 0.0, 0.0, 0.0, "materials/sprites/laserbeam.vmt", 255, 50, 50, 120, 1, 0.33, 6.0, 0.1, 1, 1.0);
	//	EmitAmbientSound(SOUND_WAND_LIGHTNING_ABILITY_PAP_CHARGE, spawnLoc, _, 60, _, _, GetRandomInt(80, 110));
		
		ResetPack(pack);
		WritePackCell(pack, EntIndexToEntRef(entity));
		WritePackFloat(pack, NumLoops + BOB_CHARGE_TIME);
		WritePackFloat(pack, spawnLoc[0]);
		WritePackFloat(pack, spawnLoc[1]);
		WritePackFloat(pack, spawnLoc[2]);
		WritePackFloat(pack, damage);
	}
	
	return Plugin_Continue;
}


static void spawnBeam(float beamTiming, int r, int g, int b, int a, char sprite[PLATFORM_MAX_PATH], float width=2.0, float endwidth=2.0, int fadelength=1, float amp=15.0, float startLoc[3] = {0.0, 0.0, 0.0}, float endLoc[3] = {0.0, 0.0, 0.0})
{
	int color[4];
	color[0] = r;
	color[1] = g;
	color[2] = b;
	color[3] = a;
		
	int SPRITE_INT = PrecacheModel(sprite, false);

	TE_SetupBeamPoints(startLoc, endLoc, SPRITE_INT, 0, 0, 0, beamTiming, width, endwidth, fadelength, amp, color, 0);
	
	TE_SendToAll();
}

static void spawnRing_Vectors(float center[3], float range, float modif_X, float modif_Y, float modif_Z, char sprite[255], int r, int g, int b, int alpha, int fps, float life, float width, float amp, int speed, float endRange = -69.0) //Spawns a TE beam ring at a client's/entity's location
{
	center[0] += modif_X;
	center[1] += modif_Y;
	center[2] += modif_Z;
			
	int ICE_INT = PrecacheModel(sprite);
		
	int color[4];
	color[0] = r;
	color[1] = g;
	color[2] = b;
	color[3] = alpha;
		
	if (endRange == -69.0)
	{
		endRange = range + 0.5;
	}
	
	TE_SetupBeamRingPoint(center, range, endRange, ICE_INT, ICE_INT, 0, fps, life, width, amp, color, speed, 0);
	TE_SendToAll();
}

stock void BobPullTarget(int bobnpc, int enemy)
{
	CClotBody npc = view_as<CClotBody>(bobnpc);
	//pull player
	float vecMe[3];
	float vecTarget[3];
	WorldSpaceCenter(npc.index, vecMe);
	if(enemy <= MaxClients)
	{
		static float angles[3];
		
		WorldSpaceCenter(enemy, vecTarget );
		GetVectorAnglesTwoPoints(vecTarget, vecMe, angles);
		
		if(GetEntityFlags(enemy) & FL_ONGROUND)
			angles[0] = 0.0; // toss out pitch if on ground

		float distance = GetVectorDistance(vecTarget, vecMe);
		if(distance > 500.0)
			distance = 500.0;

		static float velocity[3];
		GetAngleVectors(angles, velocity, NULL_VECTOR, NULL_VECTOR);
		ScaleVector(velocity, distance * 2.0);
		
		// min Z if on ground
		if(GetEntityFlags(enemy) & FL_ONGROUND)
			velocity[2] = fmax(400.0, velocity[2]);
		
		// apply velocity
		TeleportEntity(enemy, NULL_VECTOR, NULL_VECTOR, velocity);
		TF2_AddCondition(enemy, TFCond_LostFooting, 0.5);
		TF2_AddCondition(enemy, TFCond_AirCurrent, 0.5);	
		IncreaceEntityDamageTakenBy(enemy, 0.5, 0.5);
		//give 50% res for 0.5 seconds
	}
	else
	{
		CClotBody npcenemy = view_as<CClotBody>(enemy);

		PluginBot_Jump(npcenemy.index, vecMe);
	}
}

static int SensalHitDetected_2[MAXENTITIES];

void BobInitiatePunch(int entity, float VectorTarget[3], float VectorStart[3], float TimeUntillHit, float damage, bool kick)
{

	RaidbossBobTheFirst npc = view_as<RaidbossBobTheFirst>(entity);
	npc.PlayBobMeleePreHit();
	npc.FaceTowards(VectorTarget, 20000.0);
	int FramesUntillHit = RoundToNearest(TimeUntillHit * 66.0);

	float vecForward[3], Angles[3];

	GetVectorAnglesTwoPoints(VectorStart, VectorTarget, Angles);

	GetAngleVectors(Angles, vecForward, NULL_VECTOR, NULL_VECTOR);

	float VectorTarget_2[3];
	float VectorForward = 5000.0; //a really high number.
	
	VectorTarget_2[0] = VectorStart[0] + vecForward[0] * VectorForward;
	VectorTarget_2[1] = VectorStart[1] + vecForward[1] * VectorForward;
	VectorTarget_2[2] = VectorStart[2] + vecForward[2] * VectorForward;


	int red = 255;
	int green = 255;
	int blue = 255;
	int Alpha = 255;

	int colorLayer4[4];
	float diameter = float(BOB_MELEE_SIZE * 4);
	SetColorRGBA(colorLayer4, red, green, blue, Alpha);
	//we set colours of the differnet laser effects to give it more of an effect
	int colorLayer1[4];
	SetColorRGBA(colorLayer1, colorLayer4[0] * 5 + 765 / 8, colorLayer4[1] * 5 + 765 / 8, colorLayer4[2] * 5 + 765 / 8, Alpha);
	int glowColor[4];

	for(int BeamCube = 0; BeamCube < 4 ; BeamCube++)
	{
		float OffsetFromMiddle[3];
		switch(BeamCube)
		{
			case 0:
			{
				OffsetFromMiddle = {0.0, BOB_MELEE_SIZE_F,BOB_MELEE_SIZE_F};
			}
			case 1:
			{
				OffsetFromMiddle = {0.0, -BOB_MELEE_SIZE_F,-BOB_MELEE_SIZE_F};
			}
			case 2:
			{
				OffsetFromMiddle = {0.0, BOB_MELEE_SIZE_F,-BOB_MELEE_SIZE_F};
			}
			case 3:
			{
				OffsetFromMiddle = {0.0, -BOB_MELEE_SIZE_F,BOB_MELEE_SIZE_F};
			}
		}
		float AnglesEdit[3];
		AnglesEdit[0] = Angles[0];
		AnglesEdit[1] = Angles[1];
		AnglesEdit[2] = Angles[2];

		float VectorStartEdit[3];
		VectorStartEdit[0] = VectorStart[0];
		VectorStartEdit[1] = VectorStart[1];
		VectorStartEdit[2] = VectorStart[2];

		GetBeamDrawStartPoint_Stock(entity, VectorStartEdit,OffsetFromMiddle, AnglesEdit);

		SetColorRGBA(glowColor, red, green, blue, Alpha);
		TE_SetupBeamPoints(VectorStartEdit, VectorTarget_2, Shared_BEAM_Laser, 0, 0, 0, TimeUntillHit, ClampBeamWidth(diameter * 0.1), ClampBeamWidth(diameter * 0.1), 0, 0.0, glowColor, 0);
		TE_SendToAll(0.0);
	}
	
	
	DataPack pack = new DataPack();
	pack.WriteCell(EntIndexToEntRef(entity));
	pack.WriteFloat(VectorTarget_2[0]);
	pack.WriteFloat(VectorTarget_2[1]);
	pack.WriteFloat(VectorTarget_2[2]);
	pack.WriteFloat(VectorStart[0]);
	pack.WriteFloat(VectorStart[1]);
	pack.WriteFloat(VectorStart[2]);
	pack.WriteFloat(damage);
	pack.WriteCell(kick);
	RequestFrames(BobInitiatePunch_DamagePart, FramesUntillHit, pack);
}

void BobInitiatePunch_DamagePart(DataPack pack)
{
	pack.Reset();
	int entity = EntRefToEntIndex(pack.ReadCell());
	if(!IsValidEntity(entity))
		entity = 0;

	for (int i = 1; i < MAXENTITIES; i++)
	{
		SensalHitDetected_2[i] = false;
	}
	float VectorTarget[3];
	float VectorStart[3];
	VectorTarget[0] = pack.ReadFloat();
	VectorTarget[1] = pack.ReadFloat();
	VectorTarget[2] = pack.ReadFloat();
	VectorStart[0] = pack.ReadFloat();
	VectorStart[1] = pack.ReadFloat();
	VectorStart[2] = pack.ReadFloat();
	float damagedata = pack.ReadFloat();
	bool kick = pack.ReadCell();

	int red = 50;
	int green = 50;
	int blue = 255;
	int Alpha = 222;
	int colorLayer4[4];

	float diameter = float(BOB_MELEE_SIZE * 4);
	SetColorRGBA(colorLayer4, red, green, blue, Alpha);
	//we set colours of the differnet laser effects to give it more of an effect
	int colorLayer1[4];
	SetColorRGBA(colorLayer1, colorLayer4[0] * 5 + 765 / 8, colorLayer4[1] * 5 + 765 / 8, colorLayer4[2] * 5 + 765 / 8, Alpha);
	TE_SetupBeamPoints(VectorStart, VectorTarget, Shared_BEAM_Laser, 0, 0, 0, 0.11, ClampBeamWidth(diameter * 0.5), ClampBeamWidth(diameter * 0.8), 0, 5.0, colorLayer1, 3);
	TE_SendToAll(0.0);
	TE_SetupBeamPoints(VectorStart, VectorTarget, Shared_BEAM_Laser, 0, 0, 0, 0.11, ClampBeamWidth(diameter * 0.4), ClampBeamWidth(diameter * 0.5), 0, 5.0, colorLayer1, 3);
	TE_SendToAll(0.0);
	TE_SetupBeamPoints(VectorStart, VectorTarget, Shared_BEAM_Laser, 0, 0, 0, 0.11, ClampBeamWidth(diameter * 0.3), ClampBeamWidth(diameter * 0.3), 0, 5.0, colorLayer1, 3);
	TE_SendToAll(0.0);

	float hullMin[3];
	float hullMax[3];
	hullMin[0] = -float(BOB_MELEE_SIZE);
	hullMin[1] = hullMin[0];
	hullMin[2] = hullMin[0];
	hullMax[0] = -hullMin[0];
	hullMax[1] = -hullMin[1];
	hullMax[2] = -hullMin[2];
	RaidbossBobTheFirst npc = view_as<RaidbossBobTheFirst>(entity);
	npc.PlayBobMeleePostHit();

	Handle trace;
	trace = TR_TraceHullFilterEx(VectorStart, VectorTarget, hullMin, hullMax, 1073741824, Sensal_BEAM_TraceUsers_2, entity);	// 1073741824 is CONTENTS_LADDER?
	delete trace;
			
	KillFeed_SetKillIcon(entity, kick ? "mantreads" : "fists");

	if(NpcStats_IsEnemySilenced(entity))
		kick = false;
	
	float playerPos[3];
	for (int victim = 1; victim < MAXENTITIES; victim++)
	{
		if (SensalHitDetected_2[victim] && GetTeam(entity) != GetTeam(victim))
		{
			GetEntPropVector(victim, Prop_Send, "m_vecOrigin", playerPos, 0);
			float damage = damagedata;

			if(victim > MaxClients) //make sure barracks units arent bad
				damage *= 0.5;

			SDKHooks_TakeDamage(victim, entity, entity, damage, DMG_CLUB, -1, NULL_VECTOR, playerPos);	// 2048 is DMG_NOGIB?
			
			if(kick)
			{
				if(victim <= MaxClients)
				{
					hullMin[0] = 0.0;
					hullMin[1] = 0.0;
					hullMin[2] = 400.0;
					TeleportEntity(victim, _, _, hullMin, true);
				}
				else if(!b_NpcHasDied[victim])
				{
					FreezeNpcInTime(victim, 1.5);
					
					WorldSpaceCenter(victim, hullMin);
					hullMin[2] += 100.0; //Jump up.
					PluginBot_Jump(victim, hullMin);
				}
			}
		}
	}
	delete pack;

	KillFeed_SetKillIcon(entity, "tf_projectile_rocket");
}


public bool Sensal_BEAM_TraceUsers_2(int entity, int contentsMask, int client)
{
	if (IsEntityAlive(entity))
	{
		SensalHitDetected_2[entity] = true;
	}
	return false;
}



public void Bob_Rocket_Particle_StartTouch(int entity, int target)
{
	if(target > 0 && target < MAXENTITIES)	//did we hit something???
	{
		int owner = GetEntPropEnt(entity, Prop_Send, "m_hOwnerEntity");
		if(!IsValidEntity(owner))
		{
			owner = 0;
		}
		
		int inflictor = h_ArrowInflictorRef[entity];
		if(inflictor != -1)
			inflictor = EntRefToEntIndex(h_ArrowInflictorRef[entity]);

		if(inflictor == -1)
			inflictor = owner;
			
		float ProjectileLoc[3];
		GetEntPropVector(entity, Prop_Data, "m_vecAbsOrigin", ProjectileLoc);
		float DamageDeal = fl_rocket_particle_dmg[entity];
		if(ShouldNpcDealBonusDamage(target))
			DamageDeal *= h_BonusDmgToSpecialArrow[entity];


		if(b_should_explode[entity])	//should we "explode" or do "kinetic" damage
		{
			i_ExplosiveProjectileHexArray[owner] = i_ExplosiveProjectileHexArray[entity];
			Explode_Logic_Custom(fl_rocket_particle_dmg[entity] , inflictor , owner , -1 , ProjectileLoc , fl_rocket_particle_radius[entity] , _ , _ , b_rocket_particle_from_blue_npc[entity]);	//acts like a rocket
		}
		else
		{
			SDKHooks_TakeDamage(target, owner, inflictor, DamageDeal, DMG_BULLET|DMG_PREVENT_PHYSICS_FORCE, -1);	//acts like a kinetic rocket
		}
		EmitSoundToAll("mvm/mvm_tank_explode.wav", entity, SNDCHAN_STATIC, RAIDBOSS_ZOMBIE_SOUNDLEVEL, _, BOSS_ZOMBIE_VOLUME);
		ParticleEffectAt(ProjectileLoc, "hightower_explosion", 1.0);
				
		int particle = EntRefToEntIndex(i_rocket_particle[entity]);
		if(IsValidEntity(particle))
		{
			RemoveEntity(particle);
		}
	}
	else
	{
		int particle = EntRefToEntIndex(i_rocket_particle[entity]);
		//we uhh, missed?
		if(IsValidEntity(particle))
		{
			RemoveEntity(particle);
		}
	}
	RemoveEntity(entity);
}

public void Raidmode_BobFirst_Win(int entity)
{
	i_RaidGrantExtra[entity] = RAIDITEM_INDEX_WIN_COND;
	func_NPCThink[entity] = INVALID_FUNCTION;
	CPrintToChatAll("{white}Bob the First{default}: Deep sea threat cleaned, finally at peace...");
}
