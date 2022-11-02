/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

#include "ScriptMgr.h"
#include "Player.h"
#include "Config.h"
#include "Chat.h"
#include "ZoneDifficulty.h"

enum Spells
{
    SPELL_BEACON_OF_LIGHT     = 53652, // Holy Light... each procs a different spell...
    SPELL_BEACON_OF_LIGHT_2   = 53654, // Flash of Light, Holy Shock
    SPELL_ANCESTRAL_AWAKENING = 52752,
    SPELL_SWIFTMEND           = 18562
};

ZoneDifficulty* ZoneDifficulty::instance()
{
    static ZoneDifficulty instance;
    return &instance;
}

void ZoneDifficulty::LoadMapDifficultySettings()
{
    if (!sZoneDifficulty->IsEnabled)
    {
        return;
    }

    if (QueryResult result = WorldDatabase.Query("SELECT * FROM zone_difficulty_info"))
    {
        do
        {
            uint32 mapId = (*result)[0].Get<uint32>();
            if (!sMapStore.LookupEntry(mapId))
            {
                LOG_ERROR("modules", "ModZoneDifficulty: Invalid map issued. Map {} does not exist. Skipping.", (*result)[0].Get<uint32>());
                continue;
            }

            ZoneDifficultyData data;
            data.HealingNerfPct = (*result)[1].Get<float>();
            data.Enabled = (*result)[2].Get<bool>();
            sZoneDifficulty->ZoneDifficultyInfo[mapId] = data;

        } while (result->NextRow());
    }
}

class mod_zone_difficulty_unitscript : public UnitScript
{
public:
    mod_zone_difficulty_unitscript() : UnitScript("mod_zone_difficulty_unitscript") { }

    void ModifyHealReceived(Unit* target, Unit* healer, uint32& heal, SpellInfo const* spellInfo) override
    {
        if (!sZoneDifficulty->IsEnabled)
        {
            return;
        }

        if (target->IsPlayer())
        {
            if (spellInfo)
            {
                switch (spellInfo->Id)
                {
                    case SPELL_BEACON_OF_LIGHT:
                    case SPELL_BEACON_OF_LIGHT_2:
                    case SPELL_ANCESTRAL_AWAKENING:
                    case SPELL_SWIFTMEND:
                        // Don't apply reductions to those spells, as they are procs
                        // and the source spell is already nerfed.
                        return;
                    default:
                        break;
                }

                // Skip spells not affected by vulnerability (potions) and bandages
                if (spellInfo->HasAttribute(SPELL_ATTR0_NO_IMMUNITIES) || spellInfo->Mechanic == MECHANIC_BANDAGE)
                {
                    return;
                }
            }

            uint32 mapId = target->GetMapId();
            if (sZoneDifficulty->ZoneDifficultyInfo.find(mapId) != sZoneDifficulty->ZoneDifficultyInfo.end())
            {
                if (sZoneDifficulty->ZoneDifficultyInfo[target->GetMapId()].Enabled)
                {
                    heal = heal * sZoneDifficulty->ZoneDifficultyInfo[target->GetMapId()].HealingNerfPct;
                }
            }
        }
    }
};

class mod_zone_difficulty_worldscript : public WorldScript
{
public:
    mod_zone_difficulty_worldscript() : WorldScript("mod_zone_difficulty_worldscript") { }

    void OnAfterConfigLoad(bool reload) override
    {
        sZoneDifficulty->IsEnabled = sConfigMgr->GetOption<bool>("ModZoneDifficulty.Enable", false);
        sZoneDifficulty->LoadMapDifficultySettings();
    }

    void OnStartup() override
    {
        sZoneDifficulty->IsEnabled = sConfigMgr->GetOption<bool>("ModZoneDifficulty.Enable", false);
        sZoneDifficulty->LoadMapDifficultySettings();
    }
};

// Add all scripts in one
void AddModZoneDifficultyScripts()
{
    new mod_zone_difficulty_unitscript();
    new mod_zone_difficulty_worldscript();
}