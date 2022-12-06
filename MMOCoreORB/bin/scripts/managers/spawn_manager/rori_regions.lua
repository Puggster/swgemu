-- Planet Region Definitions
--
-- {"regionName", x, y, shape and size, tier, {"spawnGroup1", ...}, maxSpawnLimit}
-- For circle and ring, x and y are the center point
-- For rectangles, x and y are the bottom left corner. x2 and y2 (see below) are the upper right corner
-- Shape and size is a table with the following format depending on the shape of the area:
--   - Circle: {CIRCLE, radius}
--   - Rectangle: {RECTANGLE, x2, y2}
--   - Ring: {RING, inner radius, outer radius}
-- Tier is a bit mask with the following possible values where each hexadecimal position is one possible configuration.
-- That means that it is not possible to have both a spawn area and a no spawn area in the same region, but
-- a spawn area that is also a no build zone is possible.

require("scripts.managers.spawn_manager.regions")

rori_regions = {
	-- No Build Zones
	{"eastedge_rori_nobuild", 7640, -7640, {RECTANGLE, 8000, 7640}, NOBUILDZONEAREA},
	{"northedge_rori_nobuild", -8000, 7640, {RECTANGLE, 8000, 8000}, NOBUILDZONEAREA},
	{"southedge_rori_nobuild", -7641, -8000, {RECTANGLE, 8000, -7640}, NOBUILDZONEAREA},
	{"westedge_rori_nobuild", -8000, -8000, {RECTANGLE, -7641, 7640}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"old_battlefield_nobuild_ror1", -2337, 6427, {CIRCLE, 256}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"old_battlefield_nobuild_ror2", 2879, -1277, {CIRCLE, 256}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"old_battlfield_nobuild_ror3", -3372, -6972, {CIRCLE, 192}, NOSPAWNAREA + NOBUILDZONEAREA},

	-- POIs and Decor
	{"area", 960.867, 4041.38, {CIRCLE, 30}, UNDEFINEDAREA},
	{"area0", -426.142, 3259.27, {CIRCLE, 30}, UNDEFINEDAREA},
	{"area11", -752.173, -4090.2, {CIRCLE, 30}, UNDEFINEDAREA},
	{"area12", -1233.3, -3219.02, {CIRCLE, 30}, UNDEFINEDAREA},
	{"area14", -2637.51, -3217.46, {CIRCLE, 30}, UNDEFINEDAREA},
	{"area15", -982.622, -319.665, {CIRCLE, 30}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"area16", 952.572, 3475.12, {CIRCLE, 30}, UNDEFINEDAREA},
	{"area17", -1702.93, 6138.29, {CIRCLE, 30}, UNDEFINEDAREA},
	{"area19", -6714.21, 1083.63, {CIRCLE, 30}, UNDEFINEDAREA},
	{"area2", 1123.27, 3824.76, {CIRCLE, 30}, UNDEFINEDAREA},
	{"area21", 1168.88, 691.065, {CIRCLE, 30}, UNDEFINEDAREA},
	{"area25", 1878.93, 1755.96, {CIRCLE, 30}, UNDEFINEDAREA},
	{"area28", 956.945, 2554.44, {CIRCLE, 30}, UNDEFINEDAREA},
	{"area29", -3385.76, -2105.8, {CIRCLE, 30}, UNDEFINEDAREA},
	{"area30", -2636.51, -762.815, {CIRCLE, 50}, UNDEFINEDAREA},
	{"area31", 6124.95, -516.294, {CIRCLE, 30}, UNDEFINEDAREA},
	{"area4", 960.984, 5078.68, {CIRCLE, 30}, UNDEFINEDAREA},
	{"area5", -54.3711, 5221.69, {CIRCLE, 30}, UNDEFINEDAREA},
	{"area6", 1009.56, 5356.68, {CIRCLE, 30}, UNDEFINEDAREA},
	{"area7", 969.351, 4489.17, {CIRCLE, 30}, UNDEFINEDAREA},
	{"area8", 965.01, 6517.82, {CIRCLE, 30}, UNDEFINEDAREA},
	{"area9", 991.101, 7555.32, {RING, 20, 30}, UNDEFINEDAREA},
	{"asworal_everglades_1", -6176, -7360, {RECTANGLE, 5216, -5536}, UNDEFINEDAREA},
	{"asworal_everglades_2", -3600, -6064, {CIRCLE, 1328}, UNDEFINEDAREA},
	{"asworal_everglades_3", -2608, -5904, {CIRCLE, 1328}, UNDEFINEDAREA},
	{"asworal_everglades_4", 912, -6064, {CIRCLE, 1296}, UNDEFINEDAREA},
	{"asworal_everglades_5", -6656, -5600, {CIRCLE, 768}, UNDEFINEDAREA},
	{"asworal_everglades_6", 5200, -7232, {RECTANGLE, 7136, -5984}, UNDEFINEDAREA},
	{"blacksun_bunker_rori", 4846, -1084, {CIRCLE, 250}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"camp_and_BH", -3650, 5530, {CIRCLE, 50}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"camp_and_skeleton", -2641, -3209, {CIRCLE, 50}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"cobral_tent", -4970, -667, {CIRCLE, 30}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"debris", -990, -315, {CIRCLE, 30}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"four_columns", -430, 3265, {CIRCLE, 50}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"graveyard", -1700, 6145, {CIRCLE, 30}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"imperial_outpost", 6543, -4752, {CIRCLE, 150}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"lake_octir_swamp", -3616, 3680, {CIRCLE, 2000}, UNDEFINEDAREA},
	{"madyn_plains_1", -7296, 288, {RECTANGLE, -192, 2240}, UNDEFINEDAREA},
	{"madyn_plains_2", -6016, -2176, {RECTANGLE, -3648, 992}, UNDEFINEDAREA},
	{"madyn_plains_3", -2432, -224, {CIRCLE, 1568}, UNDEFINEDAREA},
	{"militia_commanders_estate", 5211, 1017, {CIRCLE, 75}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"narlis_fens_1", -368, 1776, {CIRCLE, 720}, UNDEFINEDAREA},
	{"narlis_fens_2", 512, 3232, {CIRCLE, 512}, UNDEFINEDAREA},
	{"narmle_deliver_10", -5034, -2225, {CIRCLE, 2}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"narmle_deliver_11", -4983, -2297, {CIRCLE, 5}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"narmle_deliver_12", -5036, -2402, {CIRCLE, 7}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"narmle_deliver_13", -4966, -2321, {CIRCLE, 2}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"narmle_deliver_16", -5160, -2383, {CIRCLE, 2}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"narmle_deliver_17", -5088, -2408, {CIRCLE, 5}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"narmle_deliver_18", -5160, -2499, {CIRCLE, 7}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"narmle_deliver_19", -5269, -2336, {CIRCLE, 10}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"narmle_deliver_20", -5236, -2387, {CIRCLE, 5}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"narmle_deliver_21", -5239, -2356, {CIRCLE, 2}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"narmle_deliver_9", -5090, -2269, {CIRCLE, 5}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"narmle_spike", -3389, -2096, {CIRCLE, 30}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"northern_hard", 29.4746, 37.3096, {RECTANGLE, 8000, 4035}, UNDEFINEDAREA},
	{"northern_islands_1", 2864, 1936, {CIRCLE, 1919}, UNDEFINEDAREA},
	{"northern_islands_2", 2928, 4720, {CIRCLE, 1488}, UNDEFINEDAREA},
	{"northern_islands_3", 2768, 6512, {CIRCLE, 1400}, UNDEFINEDAREA},
	{"northern_medium", -3005, 4040, {RECTANGLE, 2025, 7882}, UNDEFINEDAREA},
	{"northwestern_hard", -7855, 4040, {RECTANGLE, -3000, 7880}, UNDEFINEDAREA},
	{"northwestern_medium", -7855, 2008, {RECTANGLE, -3000, 4040}, UNDEFINEDAREA},
	{"plains_1", 4608, -1664, {RECTANGLE, 7520, 5056}, UNDEFINEDAREA},
	{"plains_2", -7200, -576, {RECTANGLE, -4096, 5920}, UNDEFINEDAREA},
	{"plains_3", -4960, 4512, {RECTANGLE, 928, 6272}, UNDEFINEDAREA},
	{"plains_4", -2096, 1456, {CIRCLE, 1296}, UNDEFINEDAREA},
	{"plains_5", -1584, -6352, {CIRCLE, 1500}, UNDEFINEDAREA},
	{"plains_6", 4608, -6880, {CIRCLE, 1100}, UNDEFINEDAREA},
	{"pygmy_torton_cave", -1986, -4584, {CIRCLE, 150}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"race_coordinator", 4199, 5286, {CIRCLE, 60}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"rancher_and_pets", -430, -5437, {CIRCLE, 50}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"rorgungan_ruins", -5826, 5826, {CIRCLE, 50}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"rorgungan_ruins_2", -6964, -5637, {CIRCLE, 75}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"rorgungan_ruins_3", -1490, 1675, {CIRCLE, 50}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"rorgungan_ruins_4", -2650, -780, {CIRCLE, 75}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"rorgungan_ruins_5", -75, 5230, {CIRCLE, 50}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"rorgungan_ruins_6", 6689, 6879, {CIRCLE, 50}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"rori_bark_mite_cave", 3554, 5438, {CIRCLE, 60}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"rori_force_shrine_01", 307, -979, {CIRCLE, 200}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"rori_force_shrine_02", -6376, 6404, {CIRCLE, 200}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"rori_force_shrine_03", 6854, -1222, {CIRCLE, 200}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"rori_force_shrine_04", -4497, -7535, {CIRCLE, 200}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"rori_force_shrine_05", -926, 6040, {CIRCLE, 200}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"rori_garyn_thieves_camp", -6023, -1821, {CIRCLE, 80}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"rori_gungan_camp", -2066, 3305, {CIRCLE, 109}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"rori_gungan_swamp_town", -2073, 3315, {CIRCLE, 200}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"rori_imperial_encampment", -5565, -5661, {CIRCLE, 200}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"rori_imperial_hyperdrive_facility", -1132, 4533, {CIRCLE, 198}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"rori_rebel_encampment", -5356, 5043, {CIRCLE, 109}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"rori_rebel_encampment", -5320, 5000, {CIRCLE, 150}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"rori_sdungeon_cave_01", 5445, 5029, {CIRCLE, 128}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"rori_sdungeon_cave_02", 860, -4888, {CIRCLE, 128}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"rori_sdungeon_cave_03", 7252, 108, {CIRCLE, 128}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"sdungeon_imperial_encampment", -5574, -5674, {CIRCLE, 100}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"sdungeon_rebel_outpost", 3677, -6447, {CIRCLE, 150}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"shield_generator", -5500, 2100, {CIRCLE, 50}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"statue", -2900, 2587, {CIRCLE, 35}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"tower", -4850, -4250, {CIRCLE, 30}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"vaydean_marsh", 4768, -1216, {RECTANGLE, 7392, 6208}, UNDEFINEDAREA},
	{"wrecked_outpost", 5085, 4674, {CIRCLE, 50}, NOSPAWNAREA + NOBUILDZONEAREA},

	-- Cities
	{"narmle", -5200, -2288, {CIRCLE, 392}, CITY + NOSPAWNAREA},
	{"narmle_nobuild_1", -5200, -2288, {CIRCLE, 800}, NOBUILDZONEAREA},
	{"rebel_outpost", 3677, -6447, {CIRCLE, 1500}, NOSPAWNAREA + NOBUILDZONEAREA},
	{"restuss", 5318, 5680, {CIRCLE, 700}, CITY + NOSPAWNAREA},
	{"restuss_nobuild_1", 5318, 5680, {CIRCLE, 800}, NOBUILDZONEAREA},

	-- Spawn Areas
	{"central_islands_1", -288, -2624, {CIRCLE, 2346}, SPAWNAREA, {"rori_world"}, 256},
	{"central_islands_2", 2128, -1008, {CIRCLE, 2435}, SPAWNAREA, {"rori_world"}, 256},
	{"central_medium", -3009, -3970, {RECTANGLE, 0, 4040}, SPAWNAREA, {"rori_world"}, 256},
	{"eastern_islands_1", 3744, -3168, {CIRCLE, 2638}, SPAWNAREA, {"rori_world"}, 256},
	{"eastern_islands_2", 6368, 4192, {CIRCLE, 765}, SPAWNAREA, {"rori_world"}, 256},
	{"eastern_medium", -9, -3970, {RECTANGLE, 8000, -35}, SPAWNAREA, {"rori_world"}, 256},
	{"eastern_mountains_1", 7264, -4064, {RECTANGLE, 8000, 8000}, SPAWNAREA, {"rori_world"}, 256},
	{"eastern_mountains_2", 4416, 7328, {RECTANGLE, 8000, 8000}, SPAWNAREA, {"rori_world"}, 256},
	{"eastern_mountains_3", 7616, -2528, {CIRCLE, 300}, SPAWNAREA, {"rori_world"}, 256},
	{"easy_ikopi_se", 7256, 2248, {CIRCLE, 90}, SPAWNAREA + NOWORLDSPAWNAREA, {"rori_easy"}, 256},
	{"easy_ikopi_sw", -3552, 6765, {CIRCLE, 90}, SPAWNAREA + NOWORLDSPAWNAREA, {"rori_easy"}, 256},
	{"hard_mauler_ne", -5784, 3700, {CIRCLE, 75}, SPAWNAREA, {"rori_world"}, 256},
	{"hard_mauler_sw", -3845, 5538, {CIRCLE, 80}, SPAWNAREA, {"rori_world"}, 256},
	{"hard_rogungan_nw", -2122, 7128, {CIRCLE, 120}, SPAWNAREA, {"rori_world"}, 256},
	{"hard_torton_nw", -6400, 5433, {CIRCLE, 75}, SPAWNAREA, {"rori_world"}, 256},
	{"monster_island", 2112, -4416, {RECTANGLE, 3328, -3552}, SPAWNAREA, {"rori_world"}, 256},
	{"mud_beach_1", -5520, -1008, {CIRCLE, 898}, SPAWNAREA, {"rori_world"}, 256},
	{"mud_beach_2", -4176, -1776, {CIRCLE, 726}, SPAWNAREA, {"rori_world"}, 256},
	{"mud_beach_3", -3360, -1440, {CIRCLE, 789}, SPAWNAREA, {"rori_world"}, 256},
	{"mud_beach_4", -3632, 560, {CIRCLE, 1329}, SPAWNAREA, {"rori_world"}, 256},
	{"mud_beach_5", -1024, 672, {CIRCLE, 1006}, SPAWNAREA, {"rori_world"}, 256},
	{"mud_beach_6", -5120, 4832, {CIRCLE, 1359}, SPAWNAREA, {"rori_world"}, 256},
	{"mud_beach_7", -1440, 4224, {CIRCLE, 1294}, SPAWNAREA, {"rori_world"}, 256},
	{"mud_beach_8", 4720, 272, {CIRCLE, 1202}, SPAWNAREA, {"rori_world"}, 256},
	{"mud_beach_9", 7408, -3600, {CIRCLE, 500}, SPAWNAREA, {"rori_world"}, 256},
	{"mudflats_1", -5632, -5920, {CIRCLE, 545}, SPAWNAREA, {"rori_world"}, 256},
	{"mudflats_3", -816, -5424, {CIRCLE, 564}, SPAWNAREA, {"rori_world"}, 256},
	{"mudflats_4", 1280, -5440, {CIRCLE, 785}, SPAWNAREA, {"rori_world"}, 256},
	{"mudflats_5", 3728, -6992, {CIRCLE, 510}, SPAWNAREA, {"rori_world"}, 256},
	{"mudflats_6", 6032, -6704, {CIRCLE, 555}, SPAWNAREA, {"rori_world"}, 256},
	{"mudlfats_2", -3408, -6928, {CIRCLE, 290}, SPAWNAREA, {"rori_world"}, 256},
	{"narmle_easy_newbie", -5205, -2290, {CIRCLE, 1400}, SPAWNAREA + NOWORLDSPAWNAREA, {"rori_easy"}, 256},
	{"narmle_medium_newbie", -5200, -2290, {RING, 1400, 2200}, SPAWNAREA + NOWORLDSPAWNAREA, {"rori_medium"}, 384},
	{"northeastern_medium", 2015, 4035, {RECTANGLE, 8000, 7880}, SPAWNAREA, {"rori_world"}, 256},
	{"restuss_easy_newbie", 5300, 5700, {CIRCLE, 1400}, SPAWNAREA + NOWORLDSPAWNAREA, {"rori_easy"}, 256},
	{"restuss_medium_newbie", 5305, 5700, {RING, 1400, 2200}, SPAWNAREA, {"rori_medium"}, 384},
	{"southeastern_borgle_medium", 487, -4363, {CIRCLE, 163}, SPAWNAREA, {"rori_medium"}, 384},
	{"southeastern_medium", -1, -8000, {RECTANGLE, 8000, -3970}, SPAWNAREA, {"rori_medium"}, 384},
	{"southeastern_rebel_medium", 3682, -6454, {CIRCLE, 122}, SPAWNAREA, {"rori_medium"}, 384},
	{"southern_forest_1", -6544, -6544, {CIRCLE, 1400}, SPAWNAREA, {"rori_world"}, 256},
	{"southern_forest_2", -5483, -7300, {RECTANGLE, 8000, -5947}, SPAWNAREA, {"rori_world"}, 256},
	{"southern_forest_3", -5152, -5856, {RECTANGLE, -1312, -4960}, SPAWNAREA, {"rori_world"}, 256},
	{"southern_forest_4", -320, -5856, {RECTANGLE, 672, -4800}, SPAWNAREA, {"rori_world"}, 256},
	{"southern_forest_5", 2208, -5888, {RECTANGLE, 2752, -5024}, SPAWNAREA, {"rori_world"}, 256},
	{"southern_forest_6", 2784, -5824, {RECTANGLE, 3296, -5504}, SPAWNAREA, {"rori_world"}, 256},
	{"southern_forest_7", 3584, -5888, {RECTANGLE, 5888, -5472}, SPAWNAREA, {"rori_world"}, 256},
	{"southern_mountains_1", -8000, -8000, {RECTANGLE, 8000, -7200}, SPAWNAREA, {"rori_world"}, 256},
	{"southern_mountains_2", -8000, -8000, {RECTANGLE, -6208, -6688}, SPAWNAREA, {"rori_world"}, 256},
	{"southern_mountains_3", -8000, -6688, {RECTANGLE, -7168, -5696}, SPAWNAREA, {"rori_world"}, 256},
	{"southern_mountains_4", 7232, -7488, {RECTANGLE, 8000, -5888}, SPAWNAREA, {"rori_world"}, 256},
	{"southern_mud_flats_1", -5584, -6128, {CIRCLE, 768}, SPAWNAREA, {"rori_world"}, 256},
	{"southern_mud_flats_2", -3376, -6960, {CIRCLE, 946}, SPAWNAREA, {"rori_world"}, 256},
	{"southern_mud_flats_3", -832, -5408, {CIRCLE, 1103}, SPAWNAREA, {"rori_world"}, 256},
	{"southern_mud_flats_4", 1424, -5488, {CIRCLE, 848}, SPAWNAREA, {"rori_world"}, 256},
	{"southern_mud_flats_5", 3728, -7056, {CIRCLE, 911}, SPAWNAREA, {"rori_world"}, 256},
	{"southern_mud_flats_6", 6112, -6688, {CIRCLE, 835}, SPAWNAREA, {"rori_world"}, 256},
	{"southwest_imperial_medium", -6039, -5573, {CIRCLE, 186}, SPAWNAREA, {"rori_medium"}, 384},
	{"southwestern_easy", -7859, -3970, {RECTANGLE, -3000, 0}, SPAWNAREA + NOWORLDSPAWNAREA, {"rori_easy"}, 256},
	{"southwestern_medium", -7859, -8000, {RECTANGLE, 0, -3970}, SPAWNAREA, {"rori_world"}, 256},
	{"swamp_general_1", -1984, 1216, {RECTANGLE, 1248, 7136}, SPAWNAREA, {"rori_world"}, 256},
	{"swamp_general_2", -7136, 5824, {RECTANGLE, 800, 7072}, SPAWNAREA, {"rori_world"}, 256},
	{"western_islands_1", -6000, -4112, {CIRCLE, 1723}, SPAWNAREA, {"rori_world"}, 256},
	{"western_islands_2", -3184, -3376, {CIRCLE, 1692}, SPAWNAREA, {"rori_world"}, 256},
	{"western_medium", -7860, 0, {RECTANGLE, -3000, 2010}, SPAWNAREA, {"rori_medium"}, 384},
	{"western_mountains_1", -8000, -3052, {RECTANGLE, -7265, 8000}, SPAWNAREA, {"rori_world"}, 256},
	{"western_mountains_2", 1056, 7392, {RECTANGLE, 8000, 8000}, SPAWNAREA, {"rori_world"}, 256},
	{"western_mountains_3", -7408, 4624, {CIRCLE, 500}, SPAWNAREA, {"rori_world"}, 256},
	{"western_mountains_4", -6816, -1952, {CIRCLE, 800}, SPAWNAREA, {"rori_world"}, 256},



	{"world_spawner", 0, 0, {CIRCLE, -1}, SPAWNAREA + WORLDSPAWNAREA, {"global", "rori_world"}, 2048}
}