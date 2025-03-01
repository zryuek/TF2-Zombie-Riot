public void Rogue_HandMulti_Weapon(int entity)
{
	if(i_WeaponArchetype[entity] == 1 || i_WeaponArchetype[entity] == 2)	// Multi Pellet
	{
		// +35% melee resistance
		Attributes_SetMulti(entity, 206, 0.65);
		Attributes_SetAdd(entity, 877, 0.5);
	}
}

public void Rogue_HandGrenade_Weapon(int entity)
{
	char classname[36];
	GetEntityClassname(entity, classname, sizeof(classname));
	if(!StrContains(classname, "tf_weapon_jar") || i_WeaponArchetype[entity] == 8)
	{
		// +200% damage bonus
		Attributes_SetMulti(entity, 2, 1.5);
		Attributes_SetMulti(entity, 524, 2.5);
	}
}

public void Rogue_HandSupport_HealTick(int client)
{
	if(!b_SupportHealHandPassive)
		return;

	int weapon = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");
		
	if(IsValidEntity(weapon))
	{
		if(i_WeaponArchetype[weapon] == 9 || i_WeaponArchetype[weapon] == 25 || i_WeaponArchetype[weapon] == 24 ||i_WeaponArchetype[weapon] == 22)	// Team Support and vamp knives
		{
			// +10 health regen
			int healing_Amount = HealEntityGlobal(client, client, 10.0, 1.0, 0.0, HEAL_SELFHEAL);		
			ApplyHealEvent(client, healing_Amount);	
		}
	}
}
public void Rogue_HandSupport_Collect()
{
	b_SupportHealHandPassive = true;
}

public void Rogue_HandSupport_Remove()
{
	b_SupportHealHandPassive = false;
}

public void Rogue_HandFlame_Weapon(int entity)
{
	if(Attributes_Has(entity, 208))
	{
		Attributes_SetAdd(entity, 149, Attributes_Get(entity, 208) * 1.5);
		Attributes_Set(entity, 208, 0.0);
	}
}

public void Rogue_HandTrap_Weapon(int entity)
{
	char classname[36];
	if(!StrContains(classname, "tf_weapon_shotgun_building_rescue"))
	{
		// Firing Speed -> Reload Speed
		float value = Attributes_Get(entity, 6);
		Attributes_Set(entity, 97, value);

		switch(GetEntProp(entity, Prop_Send, "m_iItemDefinitionIndex"))
		{
			case 997:	// Spike Layer
			{
				// +90% firing speed
				Attributes_Set(entity, 6, 0.1);

				// 40/60 clip size
				Attributes_Set(entity, 303, value > 2.0 ? 40.0 : 60.0);
			}
			case 1004:	// Aresenal
			{
				// +60% firing speed
				Attributes_Set(entity, 6, 0.4);

				// 6 clip size
				Attributes_Set(entity, 303, 6.0);
			}
		}
	}
	else
	{
		switch(GetEntProp(entity, Prop_Send, "m_iItemDefinitionIndex"))
		{
			case 20, 207, 130, 265, 661, 1150:
			{
				// +6 max pipebombs
				Attributes_SetAdd(entity, 88, 6.0);

				// Detonates stickybombs near the crosshair and directly under your feet
				Attributes_Set(entity, 119, 1.0);
			}
		}
	}
}


public void Rogue_HandleBrawler_Weapon(int entity)
{
	if(i_WeaponArchetype[entity] == 11 || i_WeaponArchetype[entity] == 5)	// Or Single Pellet
	{
		// +25% fire rate
		Attributes_SetMulti(entity, 6, 0.75);
		Attributes_SetMulti(entity, 97, 0.75);
	}
}

public void Rogue_HandAmbusher_Weapon(int entity)
{
	if(i_WeaponArchetype[entity] == 12 || i_WeaponArchetype[entity] == 13)	// Ambusher && combatant
	{
		// +5s bleed duration
		Attributes_SetAdd(entity, 149, 5.0);
		Attributes_SetMulti(entity, 6, 0.76);
	}
}
public void Rogue_HandInfinite_Weapon(int entity)
{
	if(i_WeaponArchetype[entity] == 3 || i_WeaponArchetype[entity] == 10)	// Infinite Fire && // Debuff
	{
		// +3 health on hit
		Attributes_SetAdd(entity, 16, 3.0);
		Attributes_SetMulti(entity, 205, 0.65);
	}
}

public void Rogue_HandDuelist_Weapon(int entity)
{
	if(i_WeaponArchetype[entity] == 15 || i_WeaponArchetype[entity] == 14)	// Duelist and abberition
	{
		// +150% damage bonus when half health
		Attributes_SetMulti(entity, 224, 2.5);
	}
}

public void Rogue_HandCaster_Weapon(int entity)
{
	if(i_WeaponArchetype[entity] == 21)	// Base Caster
	{
		// +100% max mana
		Attributes_SetMulti(entity, 405, 2.0);
		Attributes_SetMulti(entity, 6, 0.5);
	}
}

public void Rogue_HandKazimierz_Weapon(int entity)
{
	if(i_WeaponArchetype[entity] == 23 || i_WeaponArchetype[entity] == 16)	// Kazimierz and Lord
	{
		// +75% damage bonus while over half health
		Attributes_SetMulti(entity, 225, 1.75);
	}
}