-- TYPE_VANILLA = 1;
-- TYPE_RAID_MC = 2;
-- TYPE_RAID_ONY = 3;
-- TYPE_RAID_BWL = 4;
-- TYPE_RAID_ZG = 5;
-- TYPE_RAID_AQ20 = 6;
-- TYPE_RAID_AQ40 = 7;
-- TYPE_HEROIC_TBC = 8;
-- TYPE_RAID_T4 = 9;
-- TYPE_RAID_T5 = 10;
-- TYPE_RAID_T6 = 11;
-- TYPE_HEROIC_WOTLK = 12;
-- TYPE_RAID_T7 = 13;
-- TYPE_RAID_T8 = 14;
-- TYPE_RAID_T9 = 15;
-- TYPE_RAID_T10 = 16;

DROP TABLE IF EXISTS `zone_difficulty_mythicmode_instance_data`;
CREATE TABLE `zone_difficulty_mythicmode_instance_data` (
    `MapID` INT NOT NULL DEFAULT 0,
    `SourceEntry` INT NOT NULL,

    -- Bitmask `Override`:
    -- 0 = nothing
    -- 1 = no score, just log
    `Override` INT NOT NULL DEFAULT 0,
    `InstanceType` TINYINT NOT NULL DEFAULT 0,
	PRIMARY KEY (`MapID`, `SourceEntry`)
);

INSERT INTO `zone_difficulty_mythicmode_instance_data` (`MapID`, `SourceEntry`, `Override`, `InstanceType`) VALUES
-- TBC Raids
(544, 17257, 0, 9),    -- Magtheridon, Magtheridon's Lair
(565, 18831, 0, 9),    -- High King Maulgar, Gruul's Lair
(565, 19044, 0, 9),    -- Gruul, Gruul's Lair
-- SSC
(548, 21216, 0, 10), -- Hydross
(548, 21217, 0, 10), -- Lurker
(548, 21215, 0, 10), -- Leotheras
(548, 21213, 0, 10), -- Morogrim
(548, 21214, 0, 10), -- Karathress
(548, 21212, 0, 10), -- Vashj
-- Hyjal
(534, 17767, 0, 18), -- Rage Winterchill
(534, 17808, 0, 18), -- Anetheron
(534, 17888, 0, 18), -- Kazrogal
(534, 17842, 0, 18), -- Azgalor
(534, 17968, 0, 18), -- Archimonde
-- Black Temple
(564, 22887, 0, 11), -- Najentus
(564, 22898, 0, 11), -- Supremus
(564, 22841, 0, 11), -- Akama
(564, 22871, 0, 11), -- Teron
(564, 22947, 0, 11), -- Mother Shahraz
(564, 22948, 0, 11), -- Gurtogg
(564, 22917, 0, 11), -- Illidan
-- ZA
(568, 23574, 0, 12), -- Akilzon
(568, 23578, 0, 12), -- Janalai
(568, 24239, 0, 12), -- Hexlord
(568, 23577, 0, 12), -- Halazzi
(568, 23576, 0, 12), -- Narolakk
(568, 23863, 0, 12), -- Zuljin
-- SWP
(580, 24882, 0, 19), -- Brutallus
(580, 25038, 0, 19), -- Felmyst
(580, 25840, 0, 19), -- Muru
(580, 25315, 0, 19), -- Kiljaeden
-- TBC 5man Heroics
(269, 17881, 0, 8),    -- Aeonus, The Black Morass
(540, 16808, 0, 8),    -- Warchief Kargath Bladefist, Shattered Halls
(542, 17377, 0, 8),    -- Keli'dan the Breaker, Blood Furnace
(543, 18433, 0, 8),    -- Omor the Unscarred, Hellfire Ramparts
(545, 17798, 0, 8),    -- Warlord Kalithresh, The Steamvault
(546, 17882, 0, 8),    -- The Black Stalker, The Underbog
(547, 17942, 0, 8),    -- Quagmirran, Slave Pens
(552, 20912, 0, 8),    -- Harbinger Sykriss, The Arcatraz
(553, 17977, 0, 8),    -- Warp Splinter, The Botanica
(554, 19220, 0, 8),    -- Pathaleon the Calculator, The Mechanar
(555, 18708, 0, 8),    -- Murmur, Shadow Labyrinth
(556, 18473, 0, 8),    -- Talon King Ikiss, Sethekk Halls
(557, 18344, 0, 8),    -- Nexus-Prince Shaffar, Mana-Tombs
(558, 18373, 0, 8),    -- Talon King Ikiss, Auchenai Crypts
(560, 18096, 0, 8),    -- The Escape From Durnholde
(585, 24664, 0, 8);    -- Karl-Heinz Sonnenfurz, Magister's Terrace
