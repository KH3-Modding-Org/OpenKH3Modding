// ---------------------------------------------------
// Save File Layout for Kingdom Hearts 3 (PC version)
// ---------------------------------------------------

// Based on the findings of fungaltissue on Discord and Xeeynamo's Kingdom Save Editor
// WIP. May contain inaccuracies.
// Disclaimer: AI tools were used to help create this file, though results were cross-checked against the game and the Save Editor.

#include <std/time.pat>
#pragma endian little

// --- Custom Types & Enums ---

enum Difficulty : u32 {
    Beginner = 0,
    Standard = 1,
    Proud    = 2,
    Critical = 3
};

// --- Functions ---

fn format_ue4_time(u64 ticks) {
    // Math to get Unix Epoch seconds
    s64 unix_seconds = (s64(ticks) / 10000000) - 62135596800; 
    
    // Convert the raw seconds into a Time object, THEN format it
    return std::time::format(std::time::to_local(unix_seconds));
};

fn format_playtime(u32 total_seconds) {
    // Calculate hours, minutes, and leftover seconds
    u32 hours = total_seconds / 3600;
    u32 minutes = (total_seconds % 3600) / 60;
    
    // std::format uses standard fmt syntax. 
    // {:02} means "pad with a leading zero if it's a single digit"
    return std::format("{:02}:{:02}", hours, minutes);
};

// --- Structs ---

struct Header {
    char MagicCode[0x04] [[color("FF5555")]]; // Expected "S@vE"
    u32 FileSize;
    u16 MajorVersion;
    u16 MinorVersion;
    u32 Checksum;  
};

struct InventoryEntry {
    u8 item_amount;
    u8 item_flags;
};

struct PlayableCharacter {
    u8 data[0x9C0]; 
};

struct ShortcutGroup {
    u8 data[0x10]; 
};

struct Records {
    u8 data[0x1350]; 
};

struct PhotoEntry {
    u8 data[0x19004]; 
};

// TresGameFlags

struct Flags_BT {
    u32 gameflow_BT;
};

struct Flags_BX {
    u32 gameflow_BX;
};

struct Flags_CA {
    u32 gameflow_CA;
    u32 gameflow_CA_chart_last_access;
    u32 gameflow_CA_ship_ride_type;
    u32 gameflow_CA_Sub_Portroyal_Search;
};

struct Flags_CS {
    u32 gameflow_CS;
};

struct Flags_DI {
    u32 gameflow_DI;
};

struct Flags_DP {
    u32 gameflow_DP;
};

struct Flags_DW {
    u32 gameflow_DW;
    u32 gameflow_DW_Sub_INT;
};

struct Flags_EW {
    u32 gameflow_EW;
    u32 gameflow_EW_Sub_TESTB;
    u32 gameflow_EW_MISSION;
    u32 gameflow_EW_MISSION_RA;
    u32 gameflow_EW_MISSION_MI;
    u32 gameflow_EW_MISSION_TS;
    u32 gameflow_EW_MISSION_CA;
    u32 gameflow_EW_MISSION_FZ;
};

struct Flags_EX {
    u32 gameflow_EX;
};

struct Flags_FZ {
    u32 gameflow_FZ;
    u32 gameflow_FZ_Sub_SLIDEMISSION;
};

struct Flags_GM {
    u32 gameflow_GM;
    u32 gameflow_GM_01;
    u32 gameflow_GM_02;
    u32 gameflow_GM_03;
    u32 gameflow_GM_03_SUB;
    u32 gameflow_GM_SYS;
    u32 gameflow_GM_SYS_LEVELUP;
};

struct Flags_HE {
    u32 gameflow_HE;
    u32 gameflow_HE_Sub_HeraculesBoy;
};

struct Flags_KG {
    u32 gameflow_KG;
    u32 gameflow_KG_13_A;
    u32 gameflow_KG_13_B;
    u32 gameflow_KG_13_C;
    u32 gameflow_KG_13_D;
};

struct Flags_MI {
    u32 gameflow_MI;
    u32 gameflow_MI_Sub_INT;
};

struct Flags_PO {
    u32 gameflow_PO; // Hundred Acre Wood
};

struct Flags_RA {
    u32 gameflow_RA;
    u32 gameflow_RA_Dandelion;
    u32 gameflow_RA_Rabbit;
    u32 gameflow_RA_Rainbow;
    u32 gameflow_RA_Bird;
};

struct Flags_RG {
    u32 gameflow_RG;
};

struct Flags_SF {
    u32 gameflow_SF;
};

struct Flags_TS {
    u32 gameflow_TS;
    u32 gameflow_TS_Sub_GAM1;
};

struct Flags_TT {
    u32 gameflow_TT;
    u32 gameflow_TT_PO;
    u32 gameflow_TT_Remy;
};

struct Flags_WM {
    u32 gameflow_WM_WORLD_HE;
    u32 gameflow_WM_WORLD_TT;
    u32 gameflow_WM_WORLD_RA;
    u32 gameflow_WM_WORLD_TS;
    u32 gameflow_WM_WORLD_MI;
    u32 gameflow_WM_WORLD_FZ;
    u32 gameflow_WM_WORLD_CA;
    u32 gameflow_WM_WORLD_BX;
    u32 gameflow_WM_WORLD_KG;
};

struct Flags_Global {
    u32 global_GameBattleLV [[color("FF55FF")]];
    u32 global_GameShopLV;
};

struct Flags_YT {
    u32 gameflow_YT;
};

struct Flags_BT_DLC {
    u32 gameflow_BT_DLC;
    u32 gameflow_BT_DLC_07_BT_01;
    u32 gim_BT_DLC_monument;
};

struct Flags_KG_DLC {
    u32 gameflow_KG_DLC;
    u32 gameflow_KG_DLC_13_A;
    u32 gameflow_KG_DLC_13_B;
    u32 gameflow_KG_DLC_13_C;
    u32 gameflow_KG_DLC_13_D;
    u32 gameflow_KG_DLC_05_AREA_A_CHARSEL;
    u32 gameflow_KG_DLC_05_AREA_B_CHARSEL;
    u32 gameflow_KG_DLC_05_AREA_C_CHARSEL;
    u32 gameflow_KG_DLC_05_AREA_D_CHARSEL;
    u32 gameflow_KG_DLC_06_LAST_CHARSEL;
};

struct Flags_RG_DLC {
    u32 gameflow_RG_DLC;
};

struct Flags_SS_DLC {
    u32 gameflow_SS_DLC;
    u32 gameflow_SS_DLC_Sub_BadEnd;
    u32 gameflow_SS_DLC_Sub_TrueEnd;
};

struct TresGameFlagBlock {
    Flags_BT     ScalaAdCaelum;
    Flags_BX     SanFransokyo;
    Flags_CA     TheCaribbean;
    Flags_CS     Cars;              // Unused?
    Flags_DI     DestinyIslands;
    Flags_DP     LandOfDeparture;
    Flags_DW     DarkWorld;
    Flags_EW     TheFinalWorld;
    Flags_EX     Extra;        
    Flags_FZ     Arendelle;
    Flags_GM     GummiShip;
    Flags_HE     Olympus;
    Flags_KG     KeybladeGraveyard;
    Flags_MI     Monstropolis;
    Flags_PO     HundredAcreWood;
    Flags_RA     KingdomOfCorona;
    Flags_RG     RadiantGarden;
    Flags_SF     SecretForest;
    Flags_TS     ToyBox;
    Flags_TT     TwilightTown;
    Flags_WM     WorldMap;
    
    Flags_Global Global;
    Flags_YT     MysteriousTower;
    
    // Re:Mind DLC
    Flags_BT_DLC ScalaAdCaelum_ReMind;
    Flags_KG_DLC KeybladeGraveyard_ReMind;
    Flags_RG_DLC RadiantGarden_Limitcut; // Data Battles
    Flags_SS_DLC SecretEpisode_Yozora;
};


// --- Bitfields ---

bitfield KeybladeForgeArray {
    KbLv_KingdomKey      : 10;
    KbLv_HerosOrigin     : 10;
    KbLv_ShootingStar    : 10;
    KbLv_FavoriteDeputy  : 10;
    KbLv_EverAfter       : 10;
    KbLv_HappyGear       : 10;
    KbLv_CrystalSnow     : 10;
    KbLv_HunnySpout      : 10;
    KbLv_NanoGear        : 10;
    KbLv_WheelOfFate     : 10;
    KbLv_ClassicTone     : 10;
    KbLv_GrandChef       : 10;
    KbLv_Ultima          : 10;
    
    // Platform Exclusives
    KbLv_DLC_MidnightBlue: 10;
    KbLv_DLC_PhantomGreen: 10;
    KbLv_DLC_ElementalEnc: 10; 
    
    KbLv_Starlight       : 10;
    KbLv_Oathkeeper      : 10;
    KbLv_Oblivion        : 10;
    padding               : 3;
};

bitfield TresGameBoolBlock {
    // --- General / Early Worlds ---
    gameflow_BT_BATTLEPORTAL_OPENED : 1;
    gameflow_BX_CE_SAVE_GOGO : 1;
    gameflow_BX_CE_SAVE_HONEY : 1;
    gameflow_BX_CE_SAVE_WASABI : 1;
    gameflow_BX_CE_SAVE_FRED : 1;
    gameflow_BX_FLASHTRACER_01_RANK_A : 1;
    gameflow_BX_FLASHTRACER_02_RANK_A : 1;
    gameflow_BX_Sub_Pudding_CLEAR_A : 1;
    gameflow_BX_FLASHTRACER_OPENED : 1;

    // --- Caribbean (CA) ---
    gameflow_CA_TUTO_ship_user_guide : 1;
    gameflow_CA_TUTO_flight : 1;
    gameflow_CA_TUTO_swim_and_magic : 1;
    gameflow_CA_TUTO_ship_magic : 1;
    gameflow_CA_TUTO_ship_powerup : 1;
    gameflow_CA_TUTO_search_crab : 1;
    gameflow_CA_specialship_powerup : 1;
    gameflow_CA_caribisland_enemy_spawn01 : 1;
    gameflow_CA_caribisland_enemy_spawn02 : 1;
    gameflow_CA_caribisland_enemy_spawn03 : 1;
    gameflow_CA_caribisland_enemy_spawn04 : 1;
    gameflow_CA_carib_suggest_fv_01 : 1;
    gameflow_CA_carib_suggest_fv_02 : 1;
    gameflow_CA_carib_suggest_fv_03 : 1;
    gameflow_CA_carib_suggest_fv_04 : 1;
    gameflow_CA_carib_suggest_fv_05 : 1;
    gameflow_CA_carib_suggest_fv_06 : 1;
    gameflow_CA_carib_suggest_fv_07 : 1;
    gameflow_CA_carib_island_pirates_fv_sunkenship : 1;
    gameflow_CA_carib_island_pirates_fv_enter_seacave : 1;
    gameflow_CA_carib_island_pirates_fv_hint_jellyfish : 1;
    gameflow_CA_carib_island_pirates_fv_enter_limestone : 1;
    gameflow_CA_carib_island_twoway_fv_01 : 1;
    gameflow_CA_carib_island_twoway_fv_02 : 1;
    gameflow_CA_carib_island_twoway_fv_03 : 1;
    gameflow_CA_carib_island_monkey_fv_01 : 1;
    gameflow_CA_carib_island_monkey_fv_02 : 1;
    gameflow_CA_carib_island_monkey_fv_03 : 1;
    gameflow_CA_carib_island_sunkenship_fv_01 : 1;
    gameflow_CA_carib_island_sunkenship_fv_02 : 1;
    gameflow_CA_carib_island_sunkenship_fv_03 : 1;
    gameflow_CA_carib_island_lagoon_fv_01 : 1;
    gameflow_CA_carib_island_lagoon_fv_02 : 1;
    gameflow_CA_carib_island_lagoon_fv_03 : 1;
    gameflow_CA_carib_island_rock_fv_01 : 1;
    gameflow_CA_carib_island_rock_fv_02 : 1;
    gameflow_CA_carib_island_rock_fv_03 : 1;
    gameflow_CA_chart_visit01_island01_Pirates : 1;
    gameflow_CA_chart_visit02_island02_TwoWay : 1;
    gameflow_CA_chart_visit03_island03_Sunkenship : 1;
    gameflow_CA_chart_visit04_island04_Monkey : 1;
    gameflow_CA_chart_visit05_island05_Lagoon : 1;
    gameflow_CA_chart_visit06_island06_Forest : 1;
    gameflow_CA_chart_visit07_FinalDestination : 1;
    gameflow_CA_chart_visit08_island08_Rock : 1;
    gameflow_CA_chart_visit09_island09_Desert : 1;
    gameflow_CA_chart_visit10_island10_Center : 1;
    gameflow_CA_chart_visit11_island12_West : 1;
    gameflow_CA_chart_visit12_island14_FrontPortroyal : 1;
    gameflow_CA_chart_visit13_Portroyal : 1;
    gameflow_CA_Sub_Pudding_CLEAR_A : 1;
    gameflow_CA_island03_gareki : 1;
    gameflow_CA_portroyal_watch_crabcrowd01 : 1;
    gameflow_CA_portroyal_watch_crabcrowd02 : 1;
    gameflow_CA_portroyal_watch_crabcrowd03 : 1;
    gameflow_CA_portroyal_watch_crabcrowd04 : 1;
    gameflow_CA_portroyal_watch_crabcrowd05 : 1;
    gameflow_CA_portroyal_watch_crabcrowd06 : 1;
    gameflow_CA_portroyal_watch_crabcrowd07 : 1;
    gameflow_CA_portroyal_quest_town_01 : 1;
    gameflow_CA_portroyal_quest_town_02 : 1;
    gameflow_CA_portroyal_quest_town_03 : 1;
    gameflow_CA_portroyal_quest_town_04 : 1;
    gameflow_CA_portroyal_quest_town_05 : 1;
    gameflow_CA_portroyal_quest_town_06 : 1;
    gameflow_CA_portroyal_quest_town_07 : 1;

    // --- Others (DW, EW, EX) ---
    gameflow_DW_Sub_BOOL : 1;
    gameflow_EW_Sub_TESTA : 1;
    gameflow_EX_minigame_Remy : 1;
    gameflow_EX_minigame_AllPuddingRankA : 1;
    
    // --- Frozen (FZ) ---
    gameflow_FZ_Sub_Fz1_ms010 : 1;
    gameflow_FZ_Sub_Fz1_ms040 : 1;
    gameflow_FZ_Sub_Fz1_Is_Gorge : 1;
    gameflow_FZ_Sub_Fz1_Is_IcePalace : 1;
    gameflow_FZ_Sub_Fz2_Is_Labyrinth : 1;
    gameflow_FZ_Sub_Snowstorm : 1;
    gameflow_FZ_Sub_Snowstorm_clear : 1;
    gameflow_FZ_Sub_Revisited : 1;
    gameflow_FZ_Sub_Revisited2 : 1;
    gameflow_FZ_Sub_PILLAR_A : 1;
    gameflow_FZ_Sub_PILLAR_B : 1;
    gameflow_FZ_Sub_PILLAR_C : 1;
    gameflow_FZ_Sub_PILLAR_D : 1;
    gameflow_FZ_Sub_PILLAR_E : 1;
    gameflow_FZ_Sub_ATHLETIC_FLOW : 1;
    gameflow_FZ_Sub_CENTER_ELEVATOR : 1;
    gameflow_FZ_Sub_CENTER_SHORTCUT : 1;
    gameflow_FZ_Sub_OUT_ELEVATOR : 1;
    gameflow_FZ_Sub_LABYRINTH_REVISITED : 1;
    gameflow_FZ_Sub_DISP_HELP_SS : 1;
    gameflow_FZ_Sub_RESULT_RANK_A : 1;
    gameflow_FZ_Sub_RESULT_TREASURECOMPLETE : 1;
    gameflow_FZ_Sub_MISSION_OLAF : 1;
    gameflow_FZ_Sub_OLAF_AGAIN_CLEAR : 1;
    gameflow_FZ_Sub_Pudding_CLEAR_A : 1;
    gameflow_FZ_Sub_USE_WORMHOLE : 1;
    gameflow_FZ_Sub_DEBUG_PILLAR_A_USE_AFTER_START : 1;

    // --- Gimmicks ---
    gim_HE_divegim_01 : 1;
    gim_TS_divegim_01 : 1;
    gim_RA_divegim_01 : 1;
    gim_MI_divegim_01 : 1;
    gim_FZ_divegim_01 : 1;
    gim_FZ_divegim_02 : 1;
    gim_CA_divegim_01 : 1;
    gim_CA_divegim_02 : 1;
    gim_CA_divegim_03 : 1;
    gim_CA_divegim_04 : 1;
    gim_BX_divegim_01 : 1;
    gim_BX_divegim_02 : 1;
    gim_BX_divegim_03 : 1;
    gim_BX_divegim_04 : 1;
    gim_TT_postcard_01 : 1;
    gim_TT_postcard_02 : 1;
    gim_TT_postcard_03 : 1;
    gim_TT_postcard_04 : 1;
    gim_TT_postcard_05 : 1;
    gim_TT_postcard_06 : 1;
    gim_TT_postcard_07 : 1;
    gim_TT_postcard_08 : 1;
    gim_TT_postcard_09 : 1;
    gim_TT_postcard_10 : 1;
    gim_TT_postcard_11 : 1;
    gim_TT_postcard_12 : 1;
    gim_TT_postcard_13 : 1;
    gim_TT_postcard_14 : 1;
    gim_TT_postcard_15 : 1;
    gim_TT_postcard_16 : 1;
    gim_ex_battleportal_01_help : 1;

    // --- Gummi Ship---
    gameflow_GM_01_ : 1;
    gameflow_GM_01_BOSS_01_BATTLE_ : 1;
    gameflow_GM_01_BOSS_01_BATTLE_END : 1;
    gameflow_GM_01_BOSS_02_BATTLE_ : 1;
    gameflow_GM_01_BOSS_02_BATTLE_END : 1;
    gameflow_GM_01_BOSS_03_BATTLE_ : 1;
    gameflow_GM_01_BOSS_03_BATTLE_END : 1;
    gameflow_GM_01_BOSS_04_BATTLE_ : 1;
    gameflow_GM_01_BOSS_04_BATTLE_END : 1;
    gameflow_GM_01_OPEN_WORMHOLE : 1;
    gameflow_GM_02_ : 1;
    gameflow_GM_02_BOSS_01_BATTLE_ : 1;
    gameflow_GM_02_BOSS_01_BATTLE_END : 1;
    gameflow_GM_02_BOSS_02_BATTLE_ : 1;
    gameflow_GM_02_BOSS_02_BATTLE_END : 1;
    gameflow_GM_02_BOSS_03_BATTLE_ : 1;
    gameflow_GM_02_BOSS_03_BATTLE_END : 1;
    gameflow_GM_02_BOSS_04_BATTLE_ : 1;
    gameflow_GM_02_BOSS_04_BATTLE_END : 1;
    gameflow_GM_02_OPEN_WORMHOLE : 1;
    gameflow_GM_03_OPEN_KEYBRAID_GRAVEYARD : 1;
    gameflow_GM_03_BOSS_01_BATTLE_END : 1;
    gameflow_GM_03_ARENA_EAST_END : 1;
    gameflow_GM_03_ARENA_WEST_END : 1;
    gameflow_GM_03_ARENA_SOUTH_END : 1;
    gameflow_GM_03_ARENA_UNDER_END : 1;
    gameflow_GM_03_BOSS_02_BATTLE_END : 1;
    gameflow_GM_03_OPEN_WORMHOLE : 1;
    gameflow_GM_SYS_boss_defeat_010 : 1;
    gameflow_GM_SYS_boss_defeat_020 : 1;
    gameflow_GM_SYS_boss_defeat_030 : 1;
    gameflow_GM_SYS_boss_defeat_040 : 1;
    gameflow_GM_SYS_boss_defeat_050 : 1;
    gameflow_GM_SYS_boss_defeat_060 : 1;
    gameflow_GM_SYS_boss_defeat_070 : 1;
    gameflow_GM_SYS_boss_defeat_080 : 1;
    gameflow_GM_SYS_boss_defeat_090 : 1;
    gameflow_GM_SYS_boss_defeat_100 : 1;
    gameflow_GM_SYS_boss_defeat_110 : 1;
    
    // --- Olympus (HE) ---
    gameflow_HE_OL_RIVER_A_EVENT : 1;
    gameflow_HE_OL_RIVER_A_END : 1;
    gameflow_HE_OL_RIVER_B_EVENT : 1;
    gameflow_HE_OL_RIVER_B_END : 1;
    gameflow_HE_OL_EARTHELE_EVENT : 1;
    gameflow_HE_OL_EARTHELE_END : 1;
    gameflow_HE_OL_FRAC_B : 1;
    gameflow_HE_OL_FRAC_C : 1;
    gameflow_HE_OL_GROUND_SHAK_1 : 1;
    gameflow_HE_OL_GROUND_SHAK_2 : 1;
    gameflow_HE_OL_GROUND_SHAK_3 : 1;
    gameflow_HE_OL_GROUND_SHAK_4 : 1;
    gameflow_HE_HEV_FACTORY : 1;
    gameflow_HE_THEBES_ACHILLES : 1;
    gameflow_HE_COLLAPSED_EVENT02 : 1;
    gameflow_HE_03_CURLINGGIMMICK_01 : 1;
    gameflow_HE_03_CURLINGGIMMICK_02 : 1;
    gameflow_HE_03_CURLINGGIMMICK_03 : 1;
    gameflow_HE_03_CURLINGGIMMICK_04 : 1;
    gameflow_HE_03_CURLINGGIMMICK_05 : 1;
    gameflow_HE_RESCUE_AREA_E : 1;
    gameflow_HE_RESCUE_AREA_C : 1;
    gameflow_HE_RESCUE_AREA_B01 : 1;
    gameflow_HE_RESCUE_AREA_B02 : 1;
    gameflow_HE_TUTO_WALK : 1;
    gameflow_HE_TUTO_BATTLE : 1;
    gameflow_HE_TUTO_MENU : 1;
    gameflow_HE_TUTO_FREERUN : 1;
    gameflow_HE_TUTO_FREEFLOW : 1;
    gameflow_HE_TUTO_SAVE : 1;
    gameflow_HE_TUTO_MAGIC : 1;
    gameflow_HE_TUTO_RENKEI : 1;
    gameflow_HE_TUTO_FORMCHANGE : 1;
    gameflow_HE_TUTO_ATTRACTION : 1;
    gameflow_HE_TUTO_SHOOTFLOW : 1;
    gameflow_HE_TUTO_ATHLETICFLOW : 1;
    gameflow_HE_TUTO_SPECIALRAIL : 1;
    gameflow_HE_TUTO_KEYCHANGE : 1;
    gameflow_HE_OL_ROCKTITAN_DEBUG : 1;
    gameflow_HE_FVoice_sora_0040 : 1;
    gameflow_HE_FVoice_heracules_0060 : 1;
    gameflow_HE_02_EnemySpawnEvent_01 : 1;
    gameflow_HE_01_DIVEGIMMICK01_DESTROYED : 1;
    gameflow_HE_02_FRAC_C_TREASURE : 1;
    gameflow_HE_FVoice_sora_0130 : 1;
    gameflow_HE_FVoice_donald_0060 : 1;
    gameflow_HE_FVoice_ShootFlowHint : 1;
    gameflow_HE_Sub_Pudding_CLEAR_A : 1;
    gameflow_HE_Sub_Got_GoldenHeracules_01 : 1;
    gameflow_HE_Sub_Got_GoldenHeracules_02 : 1;
    gameflow_HE_Sub_Got_GoldenHeracules_03 : 1;
    gameflow_HE_Sub_Got_GoldenHeracules_04 : 1;
    gameflow_HE_Sub_Got_GoldenHeracules_05 : 1;
    gameflow_HE_Sub_HE_04_THANKYOU_01 : 1;
    gameflow_HE_Sub_HE_04_THANKYOU_02 : 1;
    gameflow_HE_Sub_HE_04_THANKYOU_03 : 1;
    gameflow_HE_Sub_HE_04_THANKYOU_04 : 1;
    gameflow_HE_Sub_HE_04_THANKYOU_05 : 1;
    gameflow_HE_Sub_HE_04_THANKYOU_06 : 1;
    gameflow_HE_Sub_HE_04_THANKYOU_07 : 1;
    
    // --- Keyblade Graveyard ---
    gameflow_KG_02_AREA_A : 1;
    gameflow_KG_02_AREA_B : 1;
    gameflow_KG_02_AREA_C : 1;
    gameflow_KG_02_AREA_D : 1;
    gameflow_KG_02_AREA_E : 1;
    gameflow_KG_13_A_1 : 1;
    gameflow_KG_13_A_2 : 1;
    gameflow_KG_13_A_3 : 1;
    gameflow_KG_13_B_1 : 1;
    gameflow_KG_13_B_2 : 1;
    gameflow_KG_13_B_3 : 1;
    gameflow_KG_13_B_4 : 1;
    gameflow_KG_13_C_1 : 1;
    gameflow_KG_13_C_2 : 1;
    gameflow_KG_13_E_1 : 1;
    gameflow_KG_13_E_2 : 1;
    gameflow_KG_13_E_3 : 1;
    gameflow_KG_got_Starlight : 1;
    
    // --- Monstropolis ---
    gameflow_MI_Sub_BOOL : 1;
    gameflow_MI_Sub_mi_04_COMICAL_01 : 1;
    gameflow_MI_Sub_mi_02_COMICAL_02 : 1;
    gameflow_MI_Sub_mi_03_CDA_HELICOPTER_01 : 1;
    gameflow_MI_Sub_mi_03_CDA_HELICOPTER_01_2 : 1;
    gameflow_MI_Sub_mi_03_CDA_HELICOPTER_02 : 1;
    gameflow_MI_Sub_mi_03_DIVEGIMMICK01_DESTROYED : 1;
    gameflow_MI_Sub_mi_02_BOOSBGIMMICK_DESTROYED : 1;
    gameflow_MI_Sub_Pudding_CLEAR_A : 1;
    
    // --- Pooh ---
    gameflow_PO_TUTO_vegetable : 1;
    gameflow_PO_TUTO_orchard : 1;
    gameflow_PO_TUTO_flower : 1;
    
    // --- Kingdom of Corona (Rapunzel) ---
    gameflow_RA_PWildCamera1 : 1;
    gameflow_RA_PWildCamera2 : 1;
    gameflow_RA_Hair1 : 1;
    gameflow_RA_Hair2 : 1;
    gameflow_RA_Dive : 1;
    gameflow_RA_AfterDance : 1;
    gameflow_RA_AfterDance_CLEAR_A : 1;
    gameflow_RA_Sub_Pudding_CLEAR_A : 1;
    
    // --- Toy Box (Toy Story) ---
    gameflow_TS_Sub_KAIJU : 1;
    gameflow_TS_Sub_MagneBlock : 1;
    gameflow_TS_Sub_SabotenA : 1;
    gameflow_TS_Sub_SabotenB : 1;
    gameflow_TS_Sub_SabotenC : 1;
    gameflow_TS_GigasReview : 1;
    gameflow_TS_Measurement : 1;
    gameflow_TS_Sub_Minigame_CLEAR_A : 1;
    gameflow_TS_Sub_Pudding_CLEAR_A : 1;
    
    // --- Twilight Town ---
    gameflow_TT_Sub_Fvoice01_Poster : 1;
    gameflow_TT_Sub_Fvoice02_Poster : 1;
    gameflow_TT_Sub_Fvoice_Theater : 1;
    gameflow_TT_Sub_Fvoice_Yashiki : 1;

    // --- VBONUS ---
    gameflow_VBONUS_001_he_001 : 1;
    gameflow_VBONUS_002_he_002 : 1;
    gameflow_VBONUS_003_he_003 : 1;
    gameflow_VBONUS_004_he_004 : 1;
    gameflow_VBONUS_005_he_005 : 1;
    gameflow_VBONUS_006_he_006 : 1;
    gameflow_VBONUS_007_he_007 : 1;
    gameflow_VBONUS_008_he_008 : 1;
    gameflow_VBONUS_009_he_009 : 1;
    gameflow_VBONUS_010_he_010 : 1;
    gameflow_VBONUS_011_he_011 : 1;
    gameflow_VBONUS_012_he_012 : 1;
    gameflow_VBONUS_013_he_013 : 1;
    gameflow_VBONUS_014_tt_001 : 1;
    gameflow_VBONUS_015_tt_002 : 1;
    gameflow_VBONUS_016_tt_003 : 1;
    gameflow_VBONUS_017_ts_001 : 1;
    gameflow_VBONUS_018_ts_002 : 1;
    gameflow_VBONUS_019_ts_003 : 1;
    gameflow_VBONUS_020_ts_004 : 1;
    gameflow_VBONUS_021_ts_005 : 1;
    gameflow_VBONUS_022_ts_006 : 1;
    gameflow_VBONUS_023_ts_007 : 1;
    gameflow_VBONUS_024_ra_001 : 1;
    gameflow_VBONUS_025_ra_002 : 1;
    gameflow_VBONUS_026_ra_003 : 1;
    gameflow_VBONUS_027_ra_004 : 1;
    gameflow_VBONUS_028_ra_005 : 1;
    gameflow_VBONUS_029_ra_006 : 1;
    gameflow_VBONUS_030_ra_007 : 1;
    gameflow_VBONUS_031_ra_008 : 1;
    gameflow_VBONUS_032_mi_001 : 1;
    gameflow_VBONUS_033_mi_002 : 1;
    gameflow_VBONUS_034_mi_003 : 1;
    gameflow_VBONUS_035_mi_004 : 1;
    gameflow_VBONUS_036_mi_005 : 1;
    gameflow_VBONUS_037_mi_006 : 1;
    gameflow_VBONUS_038_mi_007 : 1;
    gameflow_VBONUS_039_mi_008 : 1;
    gameflow_VBONUS_040_mi_009 : 1;
    gameflow_VBONUS_041_fz_001 : 1;
    gameflow_VBONUS_042_fz_002 : 1;
    gameflow_VBONUS_043_fz_003 : 1;
    gameflow_VBONUS_044_fz_004 : 1;
    gameflow_VBONUS_045_fz_005 : 1;
    gameflow_VBONUS_046_fz_006 : 1;
    gameflow_VBONUS_047_fz_007 : 1;
    gameflow_VBONUS_048_fz_008 : 1;
    gameflow_VBONUS_049_fz_009 : 1;
    gameflow_VBONUS_050_fz_010 : 1;
    gameflow_VBONUS_051_bx_001 : 1;
    gameflow_VBONUS_052_bx_002 : 1;
    gameflow_VBONUS_053_bx_003 : 1;
    gameflow_VBONUS_054_bx_004 : 1;
    gameflow_VBONUS_055_bx_005 : 1;
    gameflow_VBONUS_056_bx_006 : 1;
    gameflow_VBONUS_057_bx_007 : 1;
    gameflow_VBONUS_058_ca_001 : 1;
    gameflow_VBONUS_059_ca_002 : 1;
    gameflow_VBONUS_060_ca_003 : 1;
    gameflow_VBONUS_061_ca_004 : 1;
    gameflow_VBONUS_062_ca_005 : 1;
    gameflow_VBONUS_063_ca_006 : 1;
    gameflow_VBONUS_064_ca_007 : 1;
    gameflow_VBONUS_065_ca_008 : 1;
    gameflow_VBONUS_066_ca_009 : 1;
    gameflow_VBONUS_067_dw_001 : 1;
    gameflow_VBONUS_068_ew_001 : 1;
    gameflow_VBONUS_069_kg_001 : 1;
    gameflow_VBONUS_070_kg_002 : 1;
    gameflow_VBONUS_071_kg_003 : 1;
    gameflow_VBONUS_072_kg_004 : 1;
    gameflow_VBONUS_073_kg_005 : 1;
    gameflow_VBONUS_074_kg_006 : 1;
    gameflow_VBONUS_075_kg_007 : 1;
    gameflow_VBONUS_076_ew_002 : 1;
    gameflow_VBONUS_077_bt_001 : 1;
    gameflow_VBONUS_078_bt_002 : 1;
    gameflow_VBONUS_079_Select_HP : 1;
    gameflow_VBONUS_080_Select_NT : 1;
    gameflow_VBONUS_081_Select_MP : 1;
    gameflow_VBONUS_082_ew_001 : 1;
    gameflow_VBONUS_083_ew_002 : 1;
    gameflow_VBONUS_084_ew_003 : 1;
    gameflow_VBONUS_GPE_STATUS_HE_01 : 1;
    gameflow_VBONUS_GPE_STATUS_TS_01 : 1;
    gameflow_VBONUS_GPE_STATUS_TS_02 : 1;
    
    // --- Get Stuff ---
    gameflow_GET_MAGIC_FIRE_01 : 1;
    gameflow_GET_MAGIC_FIRE_02 : 1;
    gameflow_GET_MAGIC_FIRE_03 : 1;
    gameflow_GET_MAGIC_BLIZZA_01 : 1;
    gameflow_GET_MAGIC_BLIZZA_02 : 1;
    gameflow_GET_MAGIC_BLIZZA_03 : 1;
    gameflow_GET_MAGIC_THUNDER_01 : 1;
    gameflow_GET_MAGIC_THUNDER_02 : 1;
    gameflow_GET_MAGIC_THUNDER_03 : 1;
    gameflow_GET_MAGIC_WATER_01 : 1;
    gameflow_GET_MAGIC_WATER_02 : 1;
    gameflow_GET_MAGIC_WATER_03 : 1;
    gameflow_GET_MAGIC_AERO_01 : 1;
    gameflow_GET_MAGIC_AERO_02 : 1;
    gameflow_GET_MAGIC_AERO_03 : 1;
    gameflow_GET_MAGIC_CARE_01 : 1;
    gameflow_GET_MAGIC_CARE_02 : 1;
    gameflow_GET_MAGIC_CARE_03 : 1;
    gameflow_GET_ITEM_SLOT_01 : 1;
    gameflow_GET_ITEM_SLOT_02 : 1;
    gameflow_GET_ITEM_SLOT_03 : 1;
    
    // --- World Map ---
    gameflow_WM_FirstSave : 1;
    gameflow_WM_IsKGExposed : 1;
    
    // --- Battle Portals ---
    global_BATTLEPORTAL_ex_21_CLEARED : 1;
    global_BATTLEPORTAL_ex_22_CLEARED : 1;
    global_BATTLEPORTAL_ex_23_CLEARED : 1;
    global_BATTLEPORTAL_ex_24_CLEARED : 1;
    global_BATTLEPORTAL_ex_25_CLEARED : 1;
    global_BATTLEPORTAL_ex_26_CLEARED : 1;
    global_BATTLEPORTAL_ex_27_CLEARED : 1;
    global_BATTLEPORTAL_ex_28_CLEARED : 1;
    global_BATTLEPORTAL_ex_29_CLEARED : 1;
    global_BATTLEPORTAL_ex_30_CLEARED : 1;
    global_BATTLEPORTAL_ex_31_CLEARED : 1;
    global_BATTLEPORTAL_ex_32_CLEARED : 1;
    global_BATTLEPORTAL_ex_33_CLEARED : 1;
    global_BATTLEPORTAL_ex_34_CLEARED : 1;
    global_BATTLEPORTAL_ex_35_CLEARED : 1;
    global_BATTLEPORTAL_ex_36_CLEARED : 1;
    global_BATTLEPORTAL_ex_37_CLEARED : 1;
    global_BATTLEPORTAL_ex_38_CLEARED : 1;
    global_BATTLEPORTAL_ex_39_CLEARED : 1;
    global_BATTLEPORTAL_ex_40_CLEARED : 1;
    global_GameCutsceneRendering : 1;

    // --- Re:Mind ---
    
    gameflow_BT_DLC_07_KAIRI_01 : 1;
    gameflow_BT_DLC_07_KAIRI_02 : 1;
    gameflow_BT_DLC_07_KAIRI_03 : 1;
    gameflow_BT_DLC_07_KAIRI_04 : 1;
    gameflow_BT_DLC_07_KAIRI_05 : 1;
    gameflow_BT_DLC_07_KAIRI_06 : 1;
    gameflow_BT_DLC_07_KAIRI_07 : 1;
    gameflow_EW_Sub_STAR : 1;
    gim_BT_DLC_divegim_01 : 1;
    gim_BT_DLC_fence_01 : 1;
    gim_BT_DLC_celestialsphere_01 : 1;
    gameflow_KG_DLC_02_AREA_A : 1;
    gameflow_KG_DLC_02_AREA_B : 1;
    gameflow_KG_DLC_02_AREA_C : 1;
    gameflow_KG_DLC_02_AREA_D : 1;
    gameflow_KG_DLC_02_AREA_E : 1;
    gameflow_KG_DLC_13_A_1 : 1;
    gameflow_KG_DLC_13_A_2 : 1;
    gameflow_KG_DLC_13_A_3 : 1;
    gameflow_KG_DLC_13_B_1 : 1;
    gameflow_KG_DLC_13_B_2 : 1;
    gameflow_KG_DLC_13_B_3 : 1;
    gameflow_KG_DLC_13_B_4 : 1;
    gameflow_KG_DLC_13_C_1 : 1;
    gameflow_KG_DLC_13_C_2 : 1;
    gameflow_KG_DLC_13_E_1 : 1;
    gameflow_KG_DLC_13_E_2 : 1;
    gameflow_KG_DLC_13_E_3 : 1;
    gameflow_RG_DLC_SHU_BATTLE_10_INIT : 1;
    gameflow_RG_DLC_SHU_BATTLE_10 : 1;
    gameflow_RG_DLC_SHU_BATTLE_11_INIT : 1;
    gameflow_RG_DLC_SHU_BATTLE_11 : 1;
    gameflow_RG_DLC_SHU_BATTLE_12_INIT : 1;
    gameflow_RG_DLC_SHU_BATTLE_12 : 1;
    gameflow_RG_DLC_SHU_BATTLE_13_INIT : 1;
    gameflow_RG_DLC_SHU_BATTLE_13 : 1;
    gameflow_RG_DLC_SHU_BATTLE_14_INIT : 1;
    gameflow_RG_DLC_SHU_BATTLE_14 : 1;
    gameflow_RG_DLC_SHU_BATTLE_15_INIT : 1;
    gameflow_RG_DLC_SHU_BATTLE_15 : 1;
    gameflow_RG_DLC_SHU_BATTLE_16_INIT : 1;
    gameflow_RG_DLC_SHU_BATTLE_16 : 1;
    gameflow_RG_DLC_SHU_BATTLE_17_INIT : 1;
    gameflow_RG_DLC_SHU_BATTLE_17 : 1;
    gameflow_RG_DLC_SHU_BATTLE_18_INIT : 1;
    gameflow_RG_DLC_SHU_BATTLE_18 : 1;
    gameflow_RG_DLC_SHU_BATTLE_19_INIT : 1;
    gameflow_RG_DLC_SHU_BATTLE_19 : 1;
    gameflow_RG_DLC_SHU_BATTLE_20_INIT : 1;
    gameflow_RG_DLC_SHU_BATTLE_20 : 1;
    gameflow_RG_DLC_SHU_BATTLE_21_INIT : 1;
    gameflow_RG_DLC_SHU_BATTLE_21 : 1;
    gameflow_RG_DLC_SHU_BATTLE_22_INIT : 1;
    gameflow_RG_DLC_SHU_BATTLE_22 : 1;
    gameflow_SS_DLC_Battle_01_Retry : 1;
    gameflow_VBONUS_DLC_001_kg_001 : 1;
    gameflow_VBONUS_DLC_002_kg_002 : 1;
    gameflow_VBONUS_DLC_003_kg_003 : 1;
    gameflow_VBONUS_DLC_004_kg_004 : 1;
    gameflow_VBONUS_DLC_005_kg_005 : 1;
    gameflow_VBONUS_DLC_006_kg_006 : 1;
    gameflow_VBONUS_DLC_007_kg_007 : 1;
    gameflow_VBONUS_DLC_008_kg_008 : 1;
    gameflow_VBONUS_DLC_009_bt_001 : 1;
    gameflow_VBONUS_DLC_010_bt_002 : 1;
    gameflow_VBONUS_DLC_011_bt_003 : 1;
    gameflow_VBONUS_DLC_012_kg_009 : 1;
    gameflow_VBONUS_DLC_013_kg_010 : 1;
    gameflow_VBONUS_DLC_014_kg_011 : 1;
    gameflow_VBONUS_DLC_015_kg_012 : 1;
    gameflow_VBONUS_DLC_lim_01 : 1;
    gameflow_VBONUS_DLC_lim_02 : 1;
    gameflow_VBONUS_DLC_lim_03 : 1;
    gameflow_VBONUS_DLC_lim_04 : 1;
    gameflow_VBONUS_DLC_lim_05 : 1;
    gameflow_VBONUS_DLC_lim_06 : 1;
    gameflow_VBONUS_DLC_lim_07 : 1;
    gameflow_VBONUS_DLC_lim_08 : 1;
    gameflow_VBONUS_DLC_lim_09 : 1;
    gameflow_VBONUS_DLC_lim_10 : 1;
    gameflow_VBONUS_DLC_lim_11 : 1;
    gameflow_VBONUS_DLC_lim_12 : 1;
    gameflow_VBONUS_DLC_lim_13 : 1;
    gameflow_VBONUS_DLC_sec_01 : 1;
    gameflow_VBONUS_DLC_init_01 : 1;
    gameflow_VBONUS_DLC_init_02 : 1;
    gameflow_VBONUS_DLC_init_03 : 1;
    padding : 7;
};


// ============
// --- MAIN ---
// ============

Header Header                @ 0x00;

Difficulty DifficultyLevel   @ 0x14; // Uses Enum
u32 WorldLogo                @ 0x18; 
u32 PlayTime @ 0x20 [[color("AAAAFF"), format("format_playtime")]];
u32 TotalExp                 @ 0x24;
u32 Munny                    @ 0x28 [[color("FFFF55")]];
u8 Level                     @ 0x2C [[color("FF55FF")]];

u8 DesireChoice              @ 0x30;
u8 PowerChoice               @ 0x31;
u8 Party[5]                  @ 0x32; 
bool SaveClear               @ 0x39; 

u32 LocationName             @ 0x54;
u64 SaveTimestamp @ 0x58 [[format("format_ue4_time")]];
u32 BaseSaveIcon             @ 0x60;
u32 DlcSaveIcon              @ 0x68;

u32 EnemiesDefeated          @ 0x70;
u16 SavesCount               @ 0x5B8;

u16 RecordAttractionsCount[5]@ 0x696;
u16 RecordShotlocksCount[30] @ 0x6D0; 

InventoryEntry Inventory[1024] @ 0x8F4;  

u16 MaterialsCount[100]      @ 0x165E;
u32 CrabsCollected           @ 0x17EC;

PlayableCharacter Pc[16]     @ 0x1880;

u32 BonusHp                  @ 0xB49C;
u32 BonusMp                  @ 0xB4A0;
u32 BonusStrength            @ 0xB4A4;
u32 BonusMagic               @ 0xB4A8;
u32 BonusDefense             @ 0xB4AC;

TresGameFlagBlock TresGameFlags   @ 0xB4C4;
TresGameBoolBlock TresGameBools      @ 0xB6C4;
KeybladeForgeArray MoogleForge @ 0xBB78;

char MapPath[0x100]          @ 0xBBA0;
char MapSpawn[0x40]          @ 0xBCA0;
char PlayerScript[0x100]     @ 0xBCE0;
char PlayerCharacter[0x100]  @ 0xBDE0;

ShortcutGroup Shortcuts[3]   @ 0xBF20;
u32 Magics[6]                @ 0xBF50 [[color("55FFFF")]];
u32 Links[5]                 @ 0xBF68;

Records RecordsData          @ 0x83CD8;
u32 PhotoMaxCount            @ 0x85028;
PhotoEntry Photos[90]        @ 0x8503C;

char DlcMapPath[0x100]       @ 0x94F1A4;
char DlcSpawnPoint[0x40]     @ 0x94F2A4;