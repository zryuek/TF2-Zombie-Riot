#pragma semicolon 1
#pragma newdecls required

static const char g_KnifeHitFlesh[][] = {
	"weapons/blade_hit1.wav",
	"weapons/blade_hit2.wav",
	"weapons/blade_hit3.wav",
	"weapons/blade_hit4.wav",
};

static const char g_KnifeHitWorld[][] = {
	"weapons/blade_hitworld.wav",
};

static const char g_UberSawHitFlesh[][] = {
	"weapons/ubersaw_hit1.wav",
	"weapons/ubersaw_hit2.wav",
	"weapons/ubersaw_hit3.wav",
	"weapons/ubersaw_hit4.wav",
};

static const char g_DefaultHitWorld[][] = {
	"weapons/cbar_hit1.wav",
	"weapons/cbar_hit2.wav",
};

static const char g_DefaultHitFlesh[][] = {
	"weapons/cbar_hitbod1.wav",
	"weapons/cbar_hitbod2.wav",
	"weapons/cbar_hitbod3.wav",
};

static const char g_ThirdDegreeHitWorld[][] = {
	"weapons/3rd_degree_hit_world_01.wav",
	"weapons/3rd_degree_hit_world_02.wav",
	"weapons/3rd_degree_hit_world_03.wav",
	"weapons/3rd_degree_hit_world_04.wav",
	
};

static const char g_ThirdDegreeHitFlesh[][] = {
	"weapons/3rd_degree_hit_01.wav",
	"weapons/3rd_degree_hit_02.wav",
	"weapons/3rd_degree_hit_03.wav",
	"weapons/3rd_degree_hit_04.wav",
};

static const char g_SwordHitWorld[][] = {
	"weapons/demo_sword_hit_world1.wav",
	"weapons/demo_sword_hit_world2.wav",
};

static const char g_SwordHitFlesh[][] = {
	"weapons/blade_slice_2.wav",
	"weapons/blade_slice_3.wav",
	"weapons/blade_slice_4.wav",
};


static const char g_BatSaberHitWorld[][] = {
	"weapons/batsaber_hit_world1.wav",
	"weapons/batsaber_hit_world2.wav",
};

static const char g_BatSaberHitFlesh[][] = {
	"weapons/batsaber_hit_flesh1.wav",
	"weapons/batsaber_hit_flesh2.wav",
};


static const char g_HHHAxeHitWorld[][] = {
	"weapons/halloween_boss/knight_axe_miss.wav",
};

static const char g_HHHAxeHitFlesh[][] = {
	"weapons/halloween_boss/knight_axe_hit.wav",
};

static const char g_FistsMetalHitWorld[][] = {
	"weapons/metal_gloves_hit_world1.wav",
	"weapons/metal_gloves_hit_world2.wav",
	"weapons/metal_gloves_hit_world3.wav",
	"weapons/metal_gloves_hit_world4.wav",
};

static const char g_FistsMetalHitFlesh[][] = {
	"weapons/metal_gloves_hit_flesh1.wav",
	"weapons/metal_gloves_hit_flesh2.wav",
	"weapons/metal_gloves_hit_flesh3.wav",
	"weapons/metal_gloves_hit_flesh4.wav",
};


static const char g_FistsHitWorld[][] = {
	"weapons/fist_hit_world1.wav",
	"weapons/fist_hit_world2.wav",
};

static const char g_AxeHitFlesh[][] = {
	"weapons/axe_hit_flesh1.wav",
	"weapons/axe_hit_flesh2.wav",
	"weapons/axe_hit_flesh3.wav",
};

static const char g_BatHitFlesh[][] = {
	"weapons/bat_hit.wav",
};


static const char g_WeebKnifeLaughBackstab[][] = {
	"vo/spy_laughhappy01.mp3",
	"vo/spy_laughhappy02.mp3",
	"vo/spy_laughhappy03.mp3",
};


static const char g_KatanaHitFlesh[][] = {
	"weapons/samurai/tf_katana_slice_01.wav",
	"weapons/samurai/tf_katana_slice_02.wav",
	"weapons/samurai/tf_katana_slice_03.wav",
};


static const char g_KatanaHitWorld[][] = {
	"weapons/samurai/tf_katana_impact_object_01.wav",
	"weapons/samurai/tf_katana_impact_object_02.wav",
	"weapons/samurai/tf_katana_impact_object_03.wav",
};
/*
static const char g_MeatHitFlesh[][] = {
	"weapons/holy_mackerel1.wav",
	"weapons/holy_mackerel2.wav",
	"weapons/holy_mackerel3.wav",
};


static const char g_MeatHitWorld[][] = {
	"weapons/holy_mackerel1.wav",
	"weapons/holy_mackerel2.wav",
	"weapons/holy_mackerel3.wav",
};
*/

int i_EntitiesHitAoeSwing[MAXENTITIES]= {-1, ...};	//Who got hit
int i_EntitiesHitAtOnceMax; //How many do we stack
bool b_iHitNothing;

void MapStart_CustomMeleePrecache()
{
	for (int i = 0; i < (sizeof(g_KnifeHitFlesh));	   i++) { PrecacheSound(g_KnifeHitFlesh[i]);	   }
	for (int i = 0; i < (sizeof(g_KnifeHitWorld));	   i++) { PrecacheSound(g_KnifeHitWorld[i]);	   }
	for (int i = 0; i < (sizeof(g_ThirdDegreeHitWorld));	   i++) { PrecacheSound(g_ThirdDegreeHitWorld[i]);	   }
	for (int i = 0; i < (sizeof(g_ThirdDegreeHitFlesh));	   i++) { PrecacheSound(g_ThirdDegreeHitFlesh[i]);	   }
	for (int i = 0; i < (sizeof(g_UberSawHitFlesh));	   i++) { PrecacheSound(g_UberSawHitFlesh[i]);	   }
	for (int i = 0; i < (sizeof(g_DefaultHitWorld));	   i++) { PrecacheSound(g_DefaultHitWorld[i]);	   }
	for (int i = 0; i < (sizeof(g_DefaultHitFlesh));	   i++) { PrecacheSound(g_DefaultHitFlesh[i]);	   }
	for (int i = 0; i < (sizeof(g_SwordHitWorld));	   i++) { PrecacheSound(g_SwordHitWorld[i]);	   }
	for (int i = 0; i < (sizeof(g_SwordHitFlesh));	   i++) { PrecacheSound(g_SwordHitFlesh[i]);	   }
	for (int i = 0; i < (sizeof(g_BatSaberHitWorld));	   i++) { PrecacheSound(g_BatSaberHitWorld[i]);	   }
	for (int i = 0; i < (sizeof(g_BatSaberHitFlesh));	   i++) { PrecacheSound(g_BatSaberHitFlesh[i]);	   }
	for (int i = 0; i < (sizeof(g_HHHAxeHitWorld));	   i++) { PrecacheSound(g_HHHAxeHitWorld[i]);	   }
	for (int i = 0; i < (sizeof(g_HHHAxeHitFlesh));	   i++) { PrecacheSound(g_HHHAxeHitFlesh[i]);	   }
	for (int i = 0; i < (sizeof(g_FistsMetalHitWorld));	   i++) { PrecacheSound(g_FistsMetalHitWorld[i]);	   }
	for (int i = 0; i < (sizeof(g_FistsMetalHitFlesh));	   i++) { PrecacheSound(g_FistsMetalHitFlesh[i]);	   }
	for (int i = 0; i < (sizeof(g_FistsHitWorld));	   i++) { PrecacheSound(g_FistsHitWorld[i]);	   }
	for (int i = 0; i < (sizeof(g_AxeHitFlesh));	   i++) { PrecacheSound(g_AxeHitFlesh[i]);	   }
	for (int i = 0; i < (sizeof(g_BatHitFlesh));	   i++) { PrecacheSound(g_BatHitFlesh[i]);	   }
	for (int i = 0; i < (sizeof(g_WeebKnifeLaughBackstab));	   i++) { PrecacheSound(g_WeebKnifeLaughBackstab[i]);	   }
	for (int i = 0; i < (sizeof(g_KatanaHitWorld));	   i++) { PrecacheSound(g_KatanaHitWorld[i]);	   }
	for (int i = 0; i < (sizeof(g_KatanaHitFlesh));	   i++) { PrecacheSound(g_KatanaHitFlesh[i]);	   }
}

public void SepcialBackstabLaughSpy(int attacker)
{
	EmitSoundToAll(g_WeebKnifeLaughBackstab[GetRandomInt(0, sizeof(g_WeebKnifeLaughBackstab) - 1)], attacker, SNDCHAN_VOICE, 70, _, 1.0);
}

#define MELEE_RANGE 64.0
#define MELEE_BOUNDS 22.0
stock void DoSwingTrace_Custom(Handle &trace, int client, float vecSwingForward[3], float CustomMeleeRange = 0.0,
 bool Hit_ally = false, float CustomMeleeWide = 0.0, bool ignore_walls = false, int &enemies_hit_aoe = 1, int weapon = -1)
{
#if defined ZR
	if(weapon > 0)
	{
		switch(i_CustomWeaponEquipLogic[weapon])
		{
			case WEAPON_LEPER_MELEE_PAP, WEAPON_LEPER_MELEE:
			{
				enemies_hit_aoe = LeperEnemyAoeHit(client);
			}
			case WEAPON_SPECTER: //yes, if we miss, then we do other stuff.
			{
				enemies_hit_aoe = SpecterHowManyEnemiesHit(client, weapon);
			}	
			case WEAPON_SAGA: //yes, if we miss, then we do other stuff.
			{
				SagaAttackBeforeSwing(client);
			}
			case WEAPON_SEABORNMELEE:
			{
				SeaMelee_DoSwingTrace(client, CustomMeleeRange, CustomMeleeWide, ignore_walls, enemies_hit_aoe);
			}
			case WEAPON_RAPIER:
			{
				Rapier_DoSwingTrace(CustomMeleeRange, CustomMeleeWide);
			}
			case WEAPON_ANGELIC_SHOTGUN:
			{
				Angelic_Shotgun_DoSwingTrace(client, CustomMeleeRange, CustomMeleeWide, ignore_walls, enemies_hit_aoe);
			}
			case WEAPON_FLAGELLANT_MELEE:
			{
				Flagellant_DoSwingTrace(client);
			}
			case WEAPON_IMPACT_LANCE:
			{
				Wand_Impact_Lance_Multi_Hit(client, CustomMeleeRange, CustomMeleeWide);
			}
			case WEAPON_KIT_BLITZKRIEG_CORE:
			{
				Blitzkrieg_Kit_Custom_Melee_Logic(client, CustomMeleeRange, CustomMeleeWide, enemies_hit_aoe);
			}
		}	
	}
#endif

	// Setup a volume for the melee weapon to be swung - approx size, so all melee behave the same.
	float vecSwingMins[3];
	float vecSwingMaxs[3];
	if(CustomMeleeWide)
	{
		vecSwingMins[0] = -CustomMeleeWide;
		vecSwingMins[1] = -CustomMeleeWide;
		vecSwingMins[2] = -CustomMeleeWide;
		vecSwingMaxs[0] = CustomMeleeWide;
		vecSwingMaxs[1] = CustomMeleeWide;
		vecSwingMaxs[2] = CustomMeleeWide;

		if(ignore_walls)
		{
			
		}
	}
	else
	{
		vecSwingMins = view_as<float>({-MELEE_BOUNDS, -MELEE_BOUNDS, -MELEE_BOUNDS});
		vecSwingMaxs = view_as<float>({MELEE_BOUNDS, MELEE_BOUNDS, MELEE_BOUNDS});
	}

	float vecSwingStart[3];
//	float vecSwingForward[3];
	float ang[3];
	GetClientEyePosition(client, vecSwingStart);
	GetClientEyeAngles(client, ang);
	
	GetAngleVectors(ang, vecSwingForward, NULL_VECTOR, NULL_VECTOR);
	
	float vecSwingEnd[3];

	//here is a problem, hull traces kinda go further as a its a box being fired.
	//this is a problem.
	//we will modify the ranges for specically these traces in melee to compensate for this lack of sight.
	float vecSwingEndHull[3];
	float vecSwingEndHullHeadshot[3];
	

	if(CustomMeleeRange)
	{
		vecSwingEnd[0] = vecSwingStart[0] + vecSwingForward[0] * CustomMeleeRange;
		vecSwingEnd[1] = vecSwingStart[1] + vecSwingForward[1] * CustomMeleeRange;
		vecSwingEnd[2] = vecSwingStart[2] + vecSwingForward[2] * CustomMeleeRange;

		vecSwingEndHullHeadshot[0] = vecSwingStart[0] + vecSwingForward[0] * (CustomMeleeRange * 2.75);
		vecSwingEndHullHeadshot[1] = vecSwingStart[1] + vecSwingForward[1] * (CustomMeleeRange * 2.75);
		vecSwingEndHullHeadshot[2] = vecSwingStart[2] + vecSwingForward[2] * (CustomMeleeRange * 2.75);
	
		vecSwingEndHull[0] = vecSwingStart[0] + vecSwingForward[0] * (CustomMeleeRange * 2.1);
		vecSwingEndHull[1] = vecSwingStart[1] + vecSwingForward[1] * (CustomMeleeRange * 2.1);
		vecSwingEndHull[2] = vecSwingStart[2] + vecSwingForward[2] * (CustomMeleeRange * 2.1);
	}
	else
	{
		vecSwingEnd[0] = vecSwingStart[0] + vecSwingForward[0] * MELEE_RANGE;
		vecSwingEnd[1] = vecSwingStart[1] + vecSwingForward[1] * MELEE_RANGE;
		vecSwingEnd[2] = vecSwingStart[2] + vecSwingForward[2] * MELEE_RANGE;

		vecSwingEndHullHeadshot[0] = vecSwingStart[0] + vecSwingForward[0] * (MELEE_RANGE * 2.75);
		vecSwingEndHullHeadshot[1] = vecSwingStart[1] + vecSwingForward[1] * (MELEE_RANGE * 2.75);
		vecSwingEndHullHeadshot[2] = vecSwingStart[2] + vecSwingForward[2] * (MELEE_RANGE * 2.75);

		vecSwingEndHull[0] = vecSwingStart[0] + vecSwingForward[0] * (MELEE_RANGE * 2.1);
		vecSwingEndHull[1] = vecSwingStart[1] + vecSwingForward[1] * (MELEE_RANGE * 2.1);
		vecSwingEndHull[2] = vecSwingStart[2] + vecSwingForward[2] * (MELEE_RANGE * 2.1);
	}

	i_EntitiesHitAtOnceMax = enemies_hit_aoe;
	
	if(enemies_hit_aoe < 2)
	{
		if(!Hit_ally)
		{
			// See if we hit anything.
			/*
				Inacse we want to hit, hitboxes.
			*/
			i_MeleeHitboxHit[client] = -1;

			if(weapon > 0 && b_MeleeCanHeadshot[weapon])
			{
				//can we headshot?
				//if yes, did we hit an enemy?
				//if no, resort to normal hit detection.
				trace = TR_TraceRayFilterEx( vecSwingStart, vecSwingEndHullHeadshot, MASK_SHOT, RayType_EndPoint, BulletAndMeleeTrace, client );
				if ( TR_GetFraction(trace) < 1.0)
				{
					int target = TR_GetEntityIndex(trace);	
					if(target > 0)
					{
						i_MeleeHitboxHit[client] = TR_GetHitGroup(trace);
						return;
					}
					else
					{
						FinishLagCompensation_Base_boss();
						b_LagCompNPC_No_Layers = true;
						StartLagCompensation_Base_Boss(client);
						delete trace;
					}
				}
				else
				{
					FinishLagCompensation_Base_boss();
					b_LagCompNPC_No_Layers = true;
					StartLagCompensation_Base_Boss(client);
					delete trace;
				}
			}
			trace = TR_TraceRayFilterEx( vecSwingStart, vecSwingEnd, MASK_SOLID, RayType_EndPoint, BulletAndMeleeTrace, client );
			if ( TR_GetFraction(trace) >= 1.0 && enemies_hit_aoe != -1)
			{
				delete trace;
				trace = TR_TraceHullFilterEx( vecSwingStart, vecSwingEnd, vecSwingMins, vecSwingMaxs, ( MASK_SOLID ), BulletAndMeleeTrace, client );
				FindHullIntersection(vecSwingStart, trace, vecSwingMins, vecSwingMaxs, client );
			//	TE_DrawBox(client, vecSwingStart, vecSwingMins, vecSwingMaxs, 0.5, view_as<int>( { 0, 0, 255, 255 } ));
			}
		}
		else
		{
			// See if we hit anything.
			trace = TR_TraceRayFilterEx( vecSwingStart, vecSwingEndHull, ( MASK_SOLID ), RayType_EndPoint, BulletAndMeleeTraceAlly, client );
			if ( TR_GetFraction(trace) >= 1.0)
			{
				delete trace;
				trace = TR_TraceHullFilterEx( vecSwingStart, vecSwingEnd, vecSwingMins, vecSwingMaxs, ( MASK_SOLID ), BulletAndMeleeTraceAlly, client );
				FindHullIntersection(vecSwingStart, trace, vecSwingMins, vecSwingMaxs, client );
			//	TE_DrawBox(client, vecSwingStart, vecSwingMins, vecSwingMaxs, 0.5, view_as<int>( { 0, 0, 255, 255 } ));
			}			
		}		
	}
	else
	{
		b_iHitNothing = true;
		Handle TempTrace = TR_TraceHullFilterEx(vecSwingStart, vecSwingEndHull, vecSwingMins, vecSwingMaxs, ( MASK_SOLID ), BulletAndMeleeTrace_Multi, client);	// 1073741824 is CONTENTS_LADDER?
		delete TempTrace;
		if(b_iHitNothing) //aaa panic
		{
			delete trace;
			trace = TR_TraceRayFilterEx( vecSwingStart, vecSwingEnd, ( MASK_SOLID ), RayType_EndPoint, BulletAndMeleeTrace, client );
			if ( TR_GetFraction(trace) >= 1.0)
			{
				delete trace;
				trace = TR_TraceHullFilterEx( vecSwingStart, vecSwingEnd, vecSwingMins, vecSwingMaxs, ( MASK_SOLID ), BulletAndMeleeTrace, client );
				FindHullIntersection(vecSwingStart, trace, vecSwingMins, vecSwingMaxs, client);
			//	TE_DrawBox(client, vecSwingStart, vecSwingMins, vecSwingMaxs, 0.5, view_as<int>( { 0, 0, 255, 255 } ));
			}
		}
	}

}

stock int PlayCustomWeaponSoundFromPlayerCorrectly(int client, int target, int weapon_index, int weapon, bool &PlayOnceOnly = false)
{
	if(target == -1)
		return ZEROSOUND;

	if(target > 0 && !b_NpcHasDied[target])
	{
		switch(weapon_index)
		{
			case 649: //The Spy-cicle, because it has no hit enemy sound.
			{
				EmitSoundToAll(g_KnifeHitFlesh[GetRandomInt(0, sizeof(g_KnifeHitFlesh) - 1)], client, SNDCHAN_ITEM, 90, _, 1.0);
				return ZEROSOUND;
			}
		}
#if defined ZR
		switch(i_CustomWeaponEquipLogic[weapon])
		{
			case WEAPON_LEPER_MELEE_PAP, WEAPON_LEPER_MELEE:
			{
				PlayCustomSoundLeper(client, target);
				PlayOnceOnly = false;
				return ZEROSOUND;
			}
			case WEAPON_SPECTER: //yes, if we miss, then we do other stuff.
			{
				PlayCustomSoundSpecter(client);
				return ZEROSOUND;
			}	
		}
#endif
		return MELEE_HIT;
	}
	else
	{
		return MELEE_HIT_WORLD;
	}
}


stock bool IsValidCurrentWeapon(int client, int weapon)
{
	int Active_weapon = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");
	if(weapon > 1 && Active_weapon > 1 && weapon == Active_weapon)
	{
#if defined ZR
		switch(i_CustomWeaponEquipLogic[Active_weapon])
		{
			case WEAPON_LEPER_MELEE, WEAPON_LEPER_MELEE_PAP:
			{
				if(IsLeperInAnimation(client))
					return false;
			}
		}
#endif
		return true;
	}
	return false;
}

/*
typedef enum {
    EMPTY,
    SINGLE,
    SINGLE_NPC,
    WPN_DOUBLE, // Can't be "DOUBLE" because windows.h uses it.
    DOUBLE_NPC,
    BURST,
    RELOAD,
    RELOAD_NPC,
    MELEE_MISS,
    MELEE_HIT,
    MELEE_HIT_WORLD,
    SPECIAL1,
    SPECIAL2,
    SPECIAL3,
    TAUNT,
    DEPLOY,

    // Add new shoot sound types here

    NUM_SHOOT_SOUND_TYPES,
} WeaponSound_t;*/

enum
{
	ZEROSOUND 						= 0,	
    SINGLE							= 1,
    SINGLE_NPC						= 2,
    WPN_DOUBLE						= 3,
    DOUBLE_NPC						= 4,
    BURST							= 5,
    RELOAD							= 6,
    RELOAD_NPC						= 7,
    MELEE_MISS						= 8,
    MELEE_HIT						= 9,
    MELEE_HIT_WORLD					= 10,
    SPECIAL1						= 11,
    SPECIAL2						= 12,
    SPECIAL3						= 13,
    TAUNT							= 14,
    DEPLOY							= 15,

};

public void Timer_Do_Melee_Attack(DataPack pack)
{
	pack.Reset();
	int client = GetClientOfUserId(pack.ReadCell());
	int weapon = EntRefToEntIndex(pack.ReadCell());
	char classname[32];
	pack.ReadString(classname, 32);
	if(client && weapon != -1 && IsValidCurrentWeapon(client, weapon))
	{

#if defined ZR
		float damage_test_validity = 1.0; 
		switch(i_CustomWeaponEquipLogic[weapon])
		{
			case WEAPON_IMPACT_LANCE: //yes, if we miss, then we do other stuff.
			{
				LanceDamageCalc(client, weapon, damage_test_validity, true);
			}
		}
		if(damage_test_validity == 0.0) //here we put weapons that have special rules regarding attacking via a melee, can they even attack? etc etc.
		{
			delete pack;
			return;
		}
#endif

		int aoeSwing = 1;

		Handle swingTrace;
		if(!b_MeleeCanHeadshot[weapon])
			b_LagCompNPC_No_Layers = true;
		else
			b_LagCompNPC_ExtendBoundingBox = true;

		float vecSwingForward[3];
		StartLagCompensation_Base_Boss(client);
		DoSwingTrace_Custom(swingTrace, client, vecSwingForward,_,_,_,_,aoeSwing, weapon);
		
		aoeSwing = i_EntitiesHitAtOnceMax;
	
		int target = TR_GetEntityIndex(swingTrace);	

		//This is here beacuse if we manipulate the eyes alot of the client, hitting with traces becomes bad, so we force them to hit.
		if(IsValidEntity(i_EntityToAlwaysMeleeHit[client]))
		{
			target = i_EntityToAlwaysMeleeHit[client];
		}						
		float vecHit[3];
		TR_GetEndPosition(vecHit, swingTrace);	
#if defined ZR		
		//We want extra rules!, do we have a melee that acts differently when we didnt hit an enemy or ally?
		if(target < 1)
		{
			switch(i_CustomWeaponEquipLogic[weapon])
			{
				case WEAPON_LAPPLAND: //yes, if we miss, then we do other stuff.
				{
					Weapon_ark_LapplandRangedAttack(client, weapon);
					delete swingTrace;
					FinishLagCompensation_Base_boss();
					delete pack;
					return;
				}
				case WEAPON_QUIBAI:
				{
					Weapon_ark_QuibaiRangedAttack(client, weapon);
					delete swingTrace;
					FinishLagCompensation_Base_boss();
					delete pack;
					return;
				}
				case WEAPON_GLADIIA:
				{
					Gladiia_RangedAttack(client, weapon);
					delete swingTrace;
					FinishLagCompensation_Base_boss();
					delete pack;
					return;
				}	
			}
		}
#endif
		int Item_Index = GetEntProp(weapon, Prop_Send, "m_iItemDefinitionIndex");
		int soundIndex = PlayCustomWeaponSoundFromPlayerCorrectly(client, target, Item_Index, weapon);	
		if(soundIndex > 0)
		{
			char SoundStringToPlay[256];
			if(soundIndex == MELEE_HIT && c_WeaponSoundOverrideString[weapon][0])
			{
				EmitSoundToAll(c_WeaponSoundOverrideString[weapon], client, SNDCHAN_STATIC, RoundToNearest(90.0 * f_WeaponVolumeSetRange[weapon])
				, _, 1.0 * f_WeaponVolumeStiller[weapon]);
			}
			else if(i_WeaponSoundIndexOverride[weapon] != -1)
			{
				if(i_WeaponSoundIndexOverride[weapon] > 0)
					SetEntProp(weapon, Prop_Send, "m_iItemDefinitionIndex", i_WeaponSoundIndexOverride[weapon]);

				SDKCall_GetShootSound(weapon, soundIndex, SoundStringToPlay, sizeof(SoundStringToPlay));

				if(i_WeaponSoundIndexOverride[weapon] > 0)
					SetEntProp(weapon, Prop_Send, "m_iItemDefinitionIndex", Item_Index);

				EmitGameSoundToAll(SoundStringToPlay, client);
			}
		}

		float damage = 65.0;
		if(!StrContains(classname, "tf_weapon_bat"))
		{
			damage = 35.0;
		}
		else if(!StrContains(classname, "tf_weapon_knife"))
		{
			damage = 40.0;
		}

		if(Item_Index != 155)
		{
			damage *= Attributes_Get(weapon, 2, 1.0);
		}
		else
		{
			damage = 30.0;
			float attack_speed;		
			attack_speed = 1.0 / Attributes_FindOnPlayerZR(client, 343, true, 1.0); //Sentry attack speed bonus
						
			damage = attack_speed * damage * Attributes_FindOnPlayerZR(client, 287, true, 1.0);			//Sentry damage bonus

#if defined ZR
			damage *= BuildingWeaponDamageModif(1);
			damage *= 0.5;
#endif

		}
		
			
		damage *= Attributes_Get(weapon, 1, 1.0);

#if defined ZR
		switch(i_CustomWeaponEquipLogic[weapon])
		{
			case WEAPON_IMPACT_LANCE: //yes, if we miss, then we do other stuff.
			{
				LanceDamageCalc(client, weapon, damage);
			}
			case WEAPON_KIT_BLITZKRIEG_CORE:
			{
				Blitzkrieg_Kit_OnHitEffect(client, weapon, damage);
			}
		}
#endif
		
		bool PlayOnceOnly = false;
		float playerPos[3];
		for (int counter = i_EntitiesHitAtOnceMax; counter > 0; counter--)
		{
			if (i_EntitiesHitAoeSwing[counter] != -1)
			{
				if(IsValidEntity(i_EntitiesHitAoeSwing[counter]))
				{
					if(!PlayOnceOnly)
					{
						PlayOnceOnly = true;
						soundIndex = PlayCustomWeaponSoundFromPlayerCorrectly(client, i_EntitiesHitAoeSwing[counter], Item_Index, weapon, PlayOnceOnly);	

						if(soundIndex > 0)
						{
							if(i_WeaponSoundIndexOverride[weapon] != -1)
							{
								char SoundStringToPlay[256];
								if(i_WeaponSoundIndexOverride[weapon] > 0)
									SetEntProp(weapon, Prop_Send, "m_iItemDefinitionIndex", i_WeaponSoundIndexOverride[weapon]);

								SDKCall_GetShootSound(weapon, soundIndex, SoundStringToPlay, sizeof(SoundStringToPlay));
								if(i_WeaponSoundIndexOverride[weapon] > 0)
									SetEntProp(weapon, Prop_Send, "m_iItemDefinitionIndex", Item_Index);
									
								EmitGameSoundToAll(SoundStringToPlay, client);
							}
						}	
					}
					GetEntPropVector(i_EntitiesHitAoeSwing[counter], Prop_Data, "m_vecAbsOrigin", playerPos);
					playerPos[2] += 45.0;
#if defined ZR
					switch(i_CustomWeaponEquipLogic[weapon])
					{
						case WEAPON_ANGELIC_SHOTGUN:
						{
							Angelic_Shotgun_Meleetrace_Hit_Before(client, damage, i_EntitiesHitAoeSwing[counter]);
						}
						default:
						{
							
						}
					}
#endif				
					float CalcDamageForceVec[3]; CalculateDamageForce(vecSwingForward, 20000.0, CalcDamageForceVec);
					SDKHooks_TakeDamage(i_EntitiesHitAoeSwing[counter], client, client, damage, DMG_CLUB, weapon, CalcDamageForceVec, playerPos);
					
#if defined ZR
					switch(i_CustomWeaponEquipLogic[weapon])
					{
						case WEAPON_SEABORNMELEE:
						{
							damage *= 0.5;
						}
						case WEAPON_ANGELIC_SHOTGUN:
						{
							Angelic_Shotgun_Meleetrace_Hit_After(client, damage);
						}
						default:
						{
							
						}
					}
#endif
				}
			}
		}
		for (int i = 1; i < MAXENTITIES; i++)
		{
			i_EntitiesHitAoeSwing[i] = -1;
		}

		if(target > 0 && IsValidEntity(target) && Item_Index != 214)
		{
		//	PrintToChatAll("%i",MELEE_HIT);
		//	SDKCall_CallCorrectWeaponSound(weapon, MELEE_HIT, 1.0);
		// 	This doesnt work sadly and i dont have the power/patience to make it work, just do a custom check with some big shit, im sorry.
			
			float CalcDamageForceVec[3]; CalculateDamageForce(vecSwingForward, 20000.0, CalcDamageForceVec);
			SDKHooks_TakeDamage(target, client, client, damage, DMG_CLUB, weapon, CalcDamageForceVec, vecHit);	
		}
		else if(target > -1 && Item_Index == 214)
		{
			i_ExplosiveProjectileHexArray[weapon] = 0;
			i_ExplosiveProjectileHexArray[weapon] |= EP_DEALS_CLUB_DAMAGE;
			i_ExplosiveProjectileHexArray[weapon] |= EP_GIBS_REGARDLESS;
				
			Explode_Logic_Custom(damage, client, weapon, weapon, vecHit, _, _, _, _, 5,_,_,_,AOEHammerExtraLogic); //Only allow 5 targets hit, otherwise it can be really op.
			DataPack pack_boom = new DataPack();
			pack_boom.WriteFloat(vecHit[0]);
			pack_boom.WriteFloat(vecHit[1]);
			pack_boom.WriteFloat(vecHit[2]);
			pack_boom.WriteCell(1);
			RequestFrame(MakeExplosionFrameLater, pack_boom);
		}
		//only if we did not hit an enemy.
		if(!IsValidEnemy(client, target, true, true) && !PlayOnceOnly) //dont play if we already made one.
		{
			float pos[3];
			float angles[3];
			GetClientEyeAngles(client, angles);
			GetClientEyePosition(client, pos);
			float impactEndPos[3];
			GetAngleVectors(angles, impactEndPos, NULL_VECTOR, NULL_VECTOR);
			ScaleVector(impactEndPos, MELEE_RANGE);
			AddVectors(impactEndPos, vecHit, impactEndPos);

			TR_TraceRayFilter(vecHit, impactEndPos, MASK_SHOT_HULL, RayType_EndPoint, BulletAndMeleeTrace, client);
			if(TR_DidHit())
			{
				UTIL_ImpactTrace(client, pos, DMG_CLUB);
			}
		}
		delete swingTrace;
		FinishLagCompensation_Base_boss();
	}
	delete pack;

#if defined ZR
	SagaAttackAfterSwing(client);
#endif
}
static bool BulletAndMeleeTrace_Multi(int entity, int contentsMask, int client)
{
	bool type = BulletAndMeleeTrace(entity, contentsMask, client);
	if(!type) //if it collised, return.
	{
		return type;
	}

	for(int i=1; i <= (i_EntitiesHitAtOnceMax); i++)
	{
		if(i_EntitiesHitAoeSwing[i] == -1)
		{
			b_iHitNothing = false;
			i_EntitiesHitAoeSwing[i] = entity;
			break;
		}
	}
	return false;
}

void FindHullIntersection(const float vecSrc[3], Handle &tr, const float mins[3], const float maxs[3], int client)
{
	Handle tmpTrace;
	float vecEnd[3];
	float distance = FAR_FUTURE;
	float vecHullEnd[3];
	TR_GetEndPosition(vecHullEnd, tr);

	for(int repeat; repeat < 3; repeat++)
	{
		vecHullEnd[repeat] = vecSrc[repeat] + ((vecHullEnd[repeat] - vecSrc[repeat])*2);
	}
				
	tmpTrace = TR_TraceRayFilterEx(vecSrc, vecHullEnd, MASK_SOLID, RayType_EndPoint, BulletAndMeleeTrace, client);
	//UTIL_TraceLine( vecSrc, vecHullEnd, MASK_SOLID, pEntity, COLLISION_GROUP_NONE, &tmpTrace );

	if(TR_GetFraction(tmpTrace) < 1.0)
	{
		delete tr;
		tr = tmpTrace;
		return;
	}

	delete tmpTrace;

	for(int i; i < 2; i++)
	{
		for(int j; j < 2; j++)
		{
			for(int k; k < 2; k++)
			{
				vecEnd[0] = vecHullEnd[0] + (i ? maxs[0] : mins[0]);
				vecEnd[1] = vecHullEnd[1] + (j ? maxs[1] : mins[1]);
				vecEnd[2] = vecHullEnd[2] + (k ? maxs[2] : mins[2]);

				tmpTrace = TR_TraceRayFilterEx(vecSrc, vecEnd, MASK_SOLID, RayType_EndPoint, BulletAndMeleeTrace, client);
				//UTIL_TraceLine( vecSrc, vecEnd, MASK_SOLID, pEntity, COLLISION_GROUP_NONE, &tmpTrace );
				
				if(TR_GetFraction(tmpTrace) < 1.0)
				{
					TR_GetEndPosition(vecEnd, tmpTrace);
					float thisDistance = GetVectorDistance(vecEnd, vecSrc, true);
					if(thisDistance < distance)
					{
						delete tr;
						tr = tmpTrace;
						distance = thisDistance;
					}
					else
					{
						delete tmpTrace;
					}
				}
				else
				{
					delete tmpTrace;
				}
			}
		}
	}
}

void AOEHammerExtraLogic(int entity, int victim, float damage, int weapon)
{
	if(b_thisNpcIsARaid[victim])
	{
		damage *= 2.0;
	}	
	else if(b_thisNpcIsABoss[victim])
	{
		damage *= 1.15;
	}	
}