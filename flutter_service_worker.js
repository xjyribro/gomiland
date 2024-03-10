'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/assets/images/rubbish/detegent_bottle.png": "31d728a5670d4220709ad1749e0b1234",
"assets/assets/images/rubbish/egg.png": "15951ae6a98d89fb9edb60da0ae17782",
"assets/assets/images/rubbish/spoon.png": "8c0a96a427819369a5d821d8b7fdb27d",
"assets/assets/images/rubbish/banana.png": "f10dbc47a2855e1db33456821a3c39ad",
"assets/assets/images/rubbish/glass_jar.png": "b4ef097032598a2fccfc5500956ebdfc",
"assets/assets/images/rubbish/gameboy.png": "6cbb69da01c5b2a58b9510c16801ba7f",
"assets/assets/images/rubbish/wine_glass.png": "b54ed74774c3a2a6c7c4c85aee60f287",
"assets/assets/images/rubbish/plastic_bag.png": "2ed5dc326571f5d8abc7c27c93a940e4",
"assets/assets/images/rubbish/pot.png": "bf0eb2ea82add4bbbd42061a9aba6a33",
"assets/assets/images/rubbish/paper_fliers.png": "0ac2fb5a276c3cc7b5dd93e2c18c17f9",
"assets/assets/images/rubbish/milk_carton.png": "c6f5ff4bd380b089420e6c8e1e7dd23f",
"assets/assets/images/rubbish/container.png": "ec2c566d6e4d7692b0f0df6592d78408",
"assets/assets/images/rubbish/metal_cans.png": "e84ec5e1bdd1d5a66e85462b759e459f",
"assets/assets/images/rubbish/fork.png": "086c61d9bc36c13ae578eef389ab0e56",
"assets/assets/images/rubbish/headphones.png": "c97fd789fbbe641eb868900f6a16339b",
"assets/assets/images/rubbish/sandwich.png": "5c893cf73967c4eb3848ac66860c1109",
"assets/assets/images/rubbish/chicken_leg.png": "ccf441353532451e319a5ae06b55af95",
"assets/assets/images/rubbish/pan.png": "59e9d043a5c21739cbad032013bf4031",
"assets/assets/images/rubbish/toilet_roll.png": "bdcc37284c2a8989420db40a88329f88",
"assets/assets/images/rubbish/apple.png": "0c90fc3f832d2e413c9c58feddc0dca4",
"assets/assets/images/rubbish/metal_tins.png": "b72619cf90eef22a33c2c2aa7d6a8815",
"assets/assets/images/rubbish/glass_mug.png": "4bb54f9e91418310bf878181082cd771",
"assets/assets/images/rubbish/letter.png": "c9a6f07b4c661b7b8b2af550b0434ca1",
"assets/assets/images/rubbish/teapot.png": "eb86e4358bf457b932d7ea61d0843aa5",
"assets/assets/images/rubbish/laptop.png": "947dcfe405b6b7c7457d248b34471123",
"assets/assets/images/rubbish/plastic_bottle.png": "ff98908f98dda973f2548080fedaffe1",
"assets/assets/images/rubbish/newspaper.png": "5ba37af4ad40bd7e2a80e2d7841377aa",
"assets/assets/images/rubbish/rubbish_small.png": "d74ad8cf810fbf16d7120ebb9e582ecd",
"assets/assets/images/rubbish/bowl.png": "96f67c7a369cbca5e031f6da3b5ba125",
"assets/assets/images/rubbish/plastic_cup.png": "aa91c2df0d052013602563bb8a117815",
"assets/assets/images/rubbish/paper_cardboard.png": "ab643970c09bb1c1138109bfba7e983b",
"assets/assets/images/rubbish/pizza.png": "fe98d52083ba5e2290da43c537d7bbba",
"assets/assets/images/rubbish/burrito.png": "30b2ed43b6c0d42ab325c634c171fdb8",
"assets/assets/images/rubbish/calendar.png": "a28a0a1dbd408d091033f6371f0c99f0",
"assets/assets/images/rubbish/plate.png": "582fcb7dfcf618c437564ee37bfb32b7",
"assets/assets/images/rubbish/glass_bottle.png": "66f8b0134bd9d3c396c6ccca6246859b",
"assets/assets/images/rubbish/egg_tray.png": "5f87ffc2d11562c2dc2a4db99ea38c46",
"assets/assets/images/rubbish/straw.png": "c3ed4100ae740d4f16acaeca79ada94f",
"assets/assets/images/rubbish/paper_bag.png": "2a8d88146cee9285e00f7aa084157ef6",
"assets/assets/images/rubbish/mobile.png": "6f94790e59263031bb225bf2775c21ef",
"assets/assets/images/rubbish/tablet.png": "17b941cf3b019a607acea946bf359204",
"assets/assets/images/rubbish/battery.png": "f245d8ba715ae920497a7e974953106d",
"assets/assets/images/rubbish/e_drone.png": "2ed39b449eae7000793d0a407f1de499",
"assets/assets/images/rubbish/spanner.png": "2b4d7b1d75fc219587d8b6bb8086571b",
"assets/assets/images/rubbish/cup_noodles.png": "d0fb21d074d08cd449ee1c3f31757290",
"assets/assets/images/player/male.png": "7e94a685736b870fa5a3789e92822791",
"assets/assets/images/player/female.png": "dd7610c7530a0c3e8e102a200911662b",
"assets/assets/images/buildings/shrine_office.png": "2003442290ad1e508ecf4ee02d7bb802",
"assets/assets/images/buildings/beehive.png": "f258659a1afef2a9cc08aef93eac5716",
"assets/assets/images/buildings/apt_side.png": "d044b1fe285c95e83253e0ccec2ea258",
"assets/assets/images/buildings/temple.png": "59e99151a089b362fc431064af4774b2",
"assets/assets/images/buildings/fish_shop.png": "4a9dff46caacdf51fed0771cc0f7a045",
"assets/assets/images/buildings/apt1.png": "c1df5efeefc5c70baf6af5a6be47a215",
"assets/assets/images/buildings/tori_small.png": "279e8f0fcb71bb1292d0bb2ec61acd84",
"assets/assets/images/buildings/shoukudou.png": "79d8ee44063ecfe50209db46529b9d10",
"assets/assets/images/buildings/kiosk_roof.png": "fe20948e14f4ea80f8c7e4982383193d",
"assets/assets/images/buildings/shop_back_jap1.png": "e8267b4c5e4985c2a1cab3751882d6e9",
"assets/assets/images/buildings/park_centre1.png": "c9d0151a48df9276176facfdafdd14ff",
"assets/assets/images/buildings/apt2.png": "521389bac2ccd451b6ab95e33e88fc29",
"assets/assets/images/buildings/soup_kitchen.png": "65d231316482c33ba387098490bc288a",
"assets/assets/images/buildings/shrine3.png": "1e9e39e54211d3d21fd0da8bf666a70a",
"assets/assets/images/buildings/tori_big.png": "8ae3468f17597b5f51d65845b3ae1888",
"assets/assets/images/buildings/shop_back_eng.png": "bb04920a859c66e386bc9587b8f78868",
"assets/assets/images/buildings/shrine1.png": "58c0470b10dafadd9843a1da2bcd0985",
"assets/assets/images/buildings/shops_eng.png": "e70febc6ef3efb863375350dc0bca2ae",
"assets/assets/images/buildings/tea_shop.png": "1c3df8588d250d1e735ca5cfa1d9dcb8",
"assets/assets/images/buildings/charms.png": "6f434ff1e82b2bc29c01857748ec2f10",
"assets/assets/images/buildings/shop_side_jap.png": "d1ba5baa40ad4008266af21feadb1e14",
"assets/assets/images/buildings/office.png": "a477d375ca19fdbfbc8742e3dc72b079",
"assets/assets/images/buildings/home.png": "3f9d8c8533328f3e3227707830be7870",
"assets/assets/images/buildings/apt3.png": "ec16151f8cc7b44c415b084624f4aaeb",
"assets/assets/images/buildings/houses_eng.png": "cca909d8f0d6b0aaa55d357c772a6fc9",
"assets/assets/images/buildings/charms_bare.png": "257cb6b42a012b583e6459128ccb4088",
"assets/assets/images/buildings/school.png": "44f04386d6105f04dfedc78847295354",
"assets/assets/images/buildings/shop_back_jap.png": "7f458b822f5ffe7168f67470a397db10",
"assets/assets/images/buildings/shrine2.png": "7c788ee905d9509a63cf6c38eb73ee00",
"assets/assets/images/buildings/shop_side_eng.png": "b9b200add2129810036d3c653022de8b",
"assets/assets/images/buildings/waterhouse.png": "d53f6cce04017c66b21a8813b9533ce2",
"assets/assets/images/buildings/castle.png": "f762fedd579b89f622226a44455d417d",
"assets/assets/images/buildings/park_centre2.png": "dcb6e84c10a11d28bab300551d101abd",
"assets/assets/images/buildings/pilar.png": "31acf82d724099a2e67e5de5782b9d8e",
"assets/assets/images/buildings/cafe.png": "046576401612fd6e2c39b9f17c3b3de7",
"assets/assets/images/buildings/combini.png": "ee67348334b153513cb167e855c20242",
"assets/assets/images/buildings/inn.png": "b5f1aefa00a1b92793c4c87aed1f2ce5",
"assets/assets/images/buildings/hospital.png": "a75a0fe1902e87b499a96ad5871f15f8",
"assets/assets/images/trees/tree_fluffy.png": "e206fd7e7904a4be9e76579ea677e17c",
"assets/assets/images/trees/tree_bonsai.png": "31b47e0a73dbf631a92c69b7279b4448",
"assets/assets/images/trees/tree_orange.png": "7bb849ba3a646c38e89637aaed56467c",
"assets/assets/images/trees/tree_normal.png": "716b4c89857b6b6112dbc51b2809aed8",
"assets/assets/images/trees/tree_cone.png": "cd78f2e5811312ced2585f5f21863d6d",
"assets/assets/images/trees/tree_spiky.png": "16e689f6e6f0a515b840f444c3ba8f11",
"assets/assets/images/trees/tree_willow.png": "5de3e82264cf8f3ef2f3bcdd283c92bc",
"assets/assets/images/trees/tree_sakura_bare.png": "7bae6c658609e03a561dfdac580ce28c",
"assets/assets/images/trees/tree_sakura.png": "29ca9cc0cca7457d0c25960535a6d55d",
"assets/assets/images/trees/tree_popsicle.png": "78bca04896f24cfeaeaac37fee6f0f5f",
"assets/assets/images/spritesheets/beehive.png": "0947301413d0ad3a435ecea64c1c01fc",
"assets/assets/images/spritesheets/piler.png": "9aff57a6424b0679e4c9f98b2f15e2d1",
"assets/assets/images/spritesheets/temizuya.png": "8cf7d58b74cf978f797bf36757efd2b2",
"assets/assets/images/spritesheets/fountain.png": "8b5e9eb2405933bb2684e919c96480d7",
"assets/assets/images/spritesheets/coin_small.png": "f4216958e59a1552b212f06e7db67fb3",
"assets/assets/images/npcs/ranger.png": "018ef486b0d42afa4b4b9a47c0ddd74a",
"assets/assets/images/npcs/muscle_man.png": "9ac06e41e730aa691d9371c1c7fd5826",
"assets/assets/images/npcs/ms_margret.png": "2a6829f7fb68d86457918ce1e7e99ae6",
"assets/assets/images/npcs/anri.png": "2f9b0c96154f97f2873514b3f1454e4f",
"assets/assets/images/npcs/qianbi.png": "eab8cff5d47cc5c6b422e892cddc232f",
"assets/assets/images/npcs/woman.png": "2728df6968484372902feb0c006b07e4",
"assets/assets/images/npcs/mrs_star.png": "28fb10870169cb5a3c3e1c2004b50fe8",
"assets/assets/images/npcs/manuka.png": "b0abe428f294b8e16d8812ff30e96cff",
"assets/assets/images/npcs/florence.png": "5bf184952b5f134a187bf5df5b67c7b2",
"assets/assets/images/npcs/risa.png": "f019f8ea6212dd8f8be127f2fa8c1cf6",
"assets/assets/images/npcs/boy.png": "b929571f3d32dceccec1fd25be451fd0",
"assets/assets/images/npcs/scarlett.png": "ee8ec651f6862d06d6a6a7382cc21791",
"assets/assets/images/npcs/gaia.png": "4eb0ccdbc4dddcf2e652ba3f538ae856",
"assets/assets/images/npcs/boss.png": "712ab82fe4ecc3541d74c9cff0e2e315",
"assets/assets/images/npcs/himiko.png": "3e5593876dcff261e928d0003c42a051",
"assets/assets/images/npcs/mr_star.png": "e08fbe150dad8c8262e49e922d810606",
"assets/assets/images/npcs/asimov.png": "7d7ea1b6ae7548ba3b20ca621a11ec15",
"assets/assets/images/npcs/stark.png": "47e675c09924c3b0ad1c4dc7be012a51",
"assets/assets/images/npcs/moon.png": "7b80fd796432a50f0643edab6a7cfee7",
"assets/assets/images/npcs/man.png": "e92513c16167d2c665eb73ba1e1d7ae3",
"assets/assets/images/npcs/girl.png": "dce4eeb46b879757ea871288a09d9ac3",
"assets/assets/images/logo/gomiland_icon.png": "0212b7003e5f83b335805018ad5e0ad7",
"assets/assets/images/logo/gomiland_simple.png": "e93e69c9d408400a8e34ff71e2773b8b",
"assets/assets/images/objects/go_sign.png": "59ec4c47251de5c972a4361c2a3561ac",
"assets/assets/images/objects/stone_light.png": "bd80df814b82849b12ca6c948157597f",
"assets/assets/images/objects/piler.png": "83dd6fc9ac40ca38d5eb7a8c839a88a3",
"assets/assets/images/objects/samurai.png": "d70ad1aac9e8d4b2ea4996b4c6bf6cbd",
"assets/assets/images/objects/park_lamp.png": "aa8abd5a464cd000cf131a14caa49d95",
"assets/assets/images/objects/light.png": "19f343889c3e56a22dc84b0c974a5db4",
"assets/assets/images/objects/vacbot.png": "ecbc05d04022b52b0628eb2323ca38f0",
"assets/assets/images/objects/street_lamp.png": "170e6cbae79e3ee00c2cb075b26ffbed",
"assets/assets/images/objects/general_sign.png": "3a7f6d80c1d041e8b79b785d279176d7",
"assets/assets/images/objects/digger.png": "7b997c7ce51826d23afa28ed92bf5e2b",
"assets/assets/images/objects/rock_tall.png": "ef86ed51c6bfffe2e0a8683a6148655a",
"assets/assets/images/objects/rock_small.png": "b1efc3666a9a4e550fa2fddc78963048",
"assets/assets/images/ui/cancel.png": "1f81108e06ea8522ea8b2b56eb17cbb5",
"assets/assets/images/ui/menu_button.png": "c839022b435aa075b1173cebbc30bce9",
"assets/assets/images/ui/a_button_down.png": "a4c533242e38b0b14b1376d93fa6aaf9",
"assets/assets/images/ui/exit_button.png": "a4d42c13b0615290847fabf4f0863e84",
"assets/assets/images/ui/directional_knob.png": "2e187328f28ac11c138b95ae6224d243",
"assets/assets/images/ui/green_button.png": "1b39f42ad947faffabaa6e30b6dc2060",
"assets/assets/images/ui/info_box.png": "2f21f4db88663ae42b2697553552fcb1",
"assets/assets/images/ui/exit_button_down.png": "514711b59f509d170267c0e785c97be4",
"assets/assets/images/ui/directional_pad.png": "3e4fcb57d1d824eb1556ceb62229b19c",
"assets/assets/images/ui/bag.png": "dccdde7fe41e02c0f79205f2678fdb30",
"assets/assets/images/ui/a_button.png": "bccaeeeff3b039abeb2bad207c27af68",
"assets/assets/images/ui/red_button.png": "bd1fcbe4bdad5bb5e1c08bdabcd0265d",
"assets/assets/images/ui/blue_button.png": "9428d438475ed3b51c3b4d58bd0feb04",
"assets/assets/images/ui/menu_button_down.png": "b0c37838a54d9037d105e65fd36481a2",
"assets/assets/images/ui/clock.png": "cdfa5fcb41a6d94eab4d92aa94ff3908",
"assets/assets/images/ui/map_button.png": "5e108b24a5e393d58ff3f7b5bf47a4ba",
"assets/assets/images/ui/dialogue_box.png": "8a69f799fdebe75f5eae65d867dd887c",
"assets/assets/images/tile_maps/objects_grass.png": "a400d38a4804d3abe79d62158f68e242",
"assets/assets/images/tile_maps/mini_hood.png": "8a90e269dc714ca8c4e23cad30ac6358",
"assets/assets/images/tile_maps/bins.png": "9f0da0167dbb2e8718c259b49b39c376",
"assets/assets/images/tile_maps/street_overlays.png": "6f1b1ad9213ab6ccd6d5e824ab41e1ad",
"assets/assets/images/tile_maps/sand.png": "0e4f2ff1ff7494eb4cc6bdde02ff69b4",
"assets/assets/images/tile_maps/wall.png": "ae7360f8695f322e23f74e2b42adaf62",
"assets/assets/images/tile_maps/table.png": "d92d4a117ddb9ccbaba84f18665bc736",
"assets/assets/images/tile_maps/park_overlay.png": "46d8710aa622c44f23623ebda51fec42",
"assets/assets/images/tile_maps/bridge_rail.png": "e79fcf47d91941f7c2d657d3bf568f98",
"assets/assets/images/tile_maps/grass_barriers.png": "18585f083a322c6a01a4dd14ab8cf099",
"assets/assets/images/tile_maps/waterfront.png": "12dc3675db9b6bd57fbf6d5bc4af12da",
"assets/assets/images/tile_maps/track_fence.png": "bb464d905e41df25e11739ed7cfa9c42",
"assets/assets/images/tile_maps/wood_base.png": "c12a8a746590367b35a739571a65ddfb",
"assets/assets/images/tile_maps/water.png": "850540f74c423806e1e4b0958ddd41f3",
"assets/assets/images/tile_maps/mini_park.png": "ed2e9a01c0b65d5509133546bd14b8f9",
"assets/assets/images/tile_maps/transitions.png": "bbf95e45dd2d8264ae793a8c98b203c3",
"assets/assets/images/tile_maps/grass.png": "5d7fddfb34cd3583819d9d93eb448e21",
"assets/assets/images/tile_maps/room.png": "5429e5d8401b811190e3d969cdce771a",
"assets/assets/images/tile_maps/room_door.png": "34186f9e24ea526cdb3213dc88176bc0",
"assets/assets/images/tile_maps/objects_street.png": "f996bc3d718896e6fbc47ca18aa5f2c8",
"assets/assets/images/tile_maps/houses_japanese.png": "6a814a7a2667eb267a609024c9926d62",
"assets/assets/images/tile_maps/bonsai.png": "a8396c17f934d4068d2d59119a359efa",
"assets/assets/images/tile_maps/trees.png": "5b678a94d87c86a7dbef37f08dbc1987",
"assets/assets/images/tile_maps/fence.png": "1a34d01d7a215e32178568ff39f2bdc5",
"assets/assets/images/tile_maps/rock_wall.png": "951221cfbfa3f826b93ef7e0773cdf69",
"assets/assets/images/tile_maps/bamboo.png": "edd5f5202343c497aea54c027551f27c",
"assets/assets/images/tile_maps/buildings.png": "770bc1ae1976a1cfe18e59dade73f2f5",
"assets/assets/images/tile_maps/pavement.png": "0eada31df439bf35e6dceeead290d0e1",
"assets/assets/images/tile_maps/wall_thick.png": "97638a8218e3a50417642b7562d02c48",
"assets/assets/yarn/risa.yarn": "5095c7feb3563fd4deee203ce0515dc3",
"assets/assets/yarn/general.yarn": "3d09bba232eda4b0ce5135ac9654cb5d",
"assets/assets/yarn/gaia.yarn": "f1842385a734816fa0644d12de30dc42",
"assets/assets/yarn/hood_npcs.yarn": "b9f54ceea6e9d423db797e01950c968d",
"assets/assets/yarn/kushi.yarn": "28300bc91d6dfe86c687d012a2845687",
"assets/assets/yarn/scarlett.yarn": "7f30a11ea7bc1062d4daa2f338c62046",
"assets/assets/yarn/hardy.yarn": "512efe27b3ac1105c33c53bf533d4051",
"assets/assets/yarn/park_npcs.yarn": "75da9d9f0989e0b9dd409cfa3a085529",
"assets/assets/yarn/asimov.yarn": "8d51bbac96c4594ad4e61b8aaaf0e36f",
"assets/assets/yarn/qian_bi.yarn": "ad4ff482370c1c546edd97def6f21993",
"assets/assets/yarn/rubbish_error.yarn": "4c7e124767aca0c261caa183ba5612cb",
"assets/assets/yarn/himiko.yarn": "ede1f20576eff291183e6d805574a4c9",
"assets/assets/yarn/moon.yarn": "0b41d9b90d0db5b6489892efaca8f15f",
"assets/assets/yarn/anri.yarn": "90f4783f7a2d95fbfd0ed5a90ccde14b",
"assets/assets/yarn/stark.yarn": "d2e2e3df311ee81ac3922659e5f8b7d5",
"assets/assets/yarn/peach.yarn": "a17100cfe1aa013e8417a82bb8e5d149",
"assets/assets/yarn/margret.yarn": "d608a87e6ace02bd93ced7b0c33babe0",
"assets/assets/yarn/friend.yarn": "c86c58aaaaac1cc042ed62cfdeb4832e",
"assets/assets/yarn/brock.yarn": "e7af6148d91d1a2cc635f6137f007ca9",
"assets/assets/yarn/florence.yarn": "9eda0917384a1e6b2b7d5efbcb0b8375",
"assets/assets/yarn/manuka.yarn": "588e6f4d22b452e71e69276cfb8e6cb9",
"assets/assets/yarn/ranger.yarn": "d23088951aab4350c0ca70922f733f60",
"assets/assets/yarn/rocky.yarn": "fe405705681e6fb66c05139395135da4",
"assets/assets/yarn/star.yarn": "f6663fd0dc85a4002d481092276ff8a6",
"assets/assets/yarn/brocky.yarn": "e9e268cab3055a949cc75c87f76b5cf6",
"assets/assets/tiles/room_tiles.tsx": "76fe129a92c9edb77f9ab6be051a95ba",
"assets/assets/tiles/objects_grass.tsx": "d222e516177637318c2d06d7a582924e",
"assets/assets/tiles/trees.tsx": "0f1b5ab64a3043e4628de7656a14552c",
"assets/assets/tiles/hood.tmx": "4ea6018528908c6168109df0f07e1714",
"assets/assets/tiles/street_overlays.tsx": "251da047cb2fb5cc4f97b5059e0f6a48",
"assets/assets/tiles/sand.tsx": "8b6f14f5b7c207eeef0e5db30dd697d9",
"assets/assets/tiles/wall.tsx": "ad954c3b7b5d24f57dc5f96b92c2cb79",
"assets/assets/tiles/buildings.tsx": "43b3ee586c012c787ca367d50a0a1cf2",
"assets/assets/tiles/lights.tsx": "a842a61c29499bc5ed76e9d2aee1f829",
"assets/assets/tiles/transitions.tsx": "f7e1c49c221132864ad18955284b0302",
"assets/assets/tiles/water.tsx": "22a807a73c9c5ace58eb7ec601bdd079",
"assets/assets/tiles/grass.tsx": "322abb7190abf8e0e38233539ac0e73d",
"assets/assets/tiles/fence.tsx": "fcfbf7acefffee549aa56fae308e89bb",
"assets/assets/tiles/wall_thick.tsx": "ad15d32fcc0dbbdd2d54a0a9cfa35861",
"assets/assets/tiles/pavement.tsx": "eb81548635c0a09fd9667f04da3f7498",
"assets/assets/tiles/bridge_rail.tsx": "cd6c3d35af57438592e06a00bcd26c36",
"assets/assets/tiles/bins.tsx": "85fbe1ba3de8d640ec036c38c3f63563",
"assets/assets/tiles/objects_street.tsx": "18598079f70b79666b4aa3ee2f7a3fed",
"assets/assets/tiles/track_fence.tsx": "2b40e25bd29a2279e6e3412fea4cc047",
"assets/assets/tiles/bamboo.tsx": "d28327d694628cf6db2944ece74e9334",
"assets/assets/tiles/room.tmx": "5106a442510b320cdc50c000439d23a9",
"assets/assets/tiles/rock_wall.tsx": "5b08c5515f38192c0ca84a9f56f0ecaa",
"assets/assets/tiles/table.tsx": "fe5b9d19d8588cd9dcb376edcffffac2",
"assets/assets/tiles/park_overlay.tsx": "a84b9e882ecee897d21fe5de7996422d",
"assets/assets/tiles/bonsai.tsx": "49a7719926fdfcdccfcbd939577f6cb5",
"assets/assets/tiles/room_door.tsx": "37fe867a7c6a6b856d275b2cfebf29b9",
"assets/assets/tiles/waterfront.tsx": "07f1d1dc6694b197d7cb451930466e02",
"assets/assets/tiles/grass_barriers.tsx": "5aeebd1e310f4804af2a49e4c41673aa",
"assets/assets/tiles/wood_base.tsx": "a1fb3884ead736c279cc6cbc04ac28f8",
"assets/assets/tiles/park.tmx": "d75929d361cd020ac7dca18c0d13c418",
"assets/assets/audio/sfx/pickup.mp3": "cfbc3e5fc764d2e29b14aefea45923fc",
"assets/assets/audio/sfx/next.mp3": "57134650568017353c32382459564e17",
"assets/assets/audio/sfx/correct.mp3": "4e6050b5a717d163bd58506471c8a8c5",
"assets/assets/audio/sfx/incorrect.mp3": "9bd8e7b40c6bb8a1dcb64afc8c764ecd",
"assets/assets/audio/bgm/park_bgm.mp3": "616110c6e503c281a8132908dcc5ed90",
"assets/assets/audio/bgm/hood_bgm.mp3": "5dafbaad6c5f8ac6669b3da10a030510",
"assets/assets/audio/bgm/olib_oil.mp3": "f5c179108666bf75425422ffdfbdf257",
"assets/assets/audio/bgm/behind_the_rocks.mp3": "e42bdca3520469f9925cc7c8084638b8",
"assets/AssetManifest.bin": "fcc49b15011af36f0a54f28616709b4e",
"assets/AssetManifest.bin.json": "6ecea45fe377a5b8a2a39320b593e127",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/NOTICES": "0359657f79678660cd170490b8e4bd01",
"assets/AssetManifest.json": "421578b9dd9ebcd9bd1260d1692f48aa",
"assets/fonts/minecraft.ttf": "d7b98c450349bef0631c7229b804a5c7",
"assets/fonts/MaterialIcons-Regular.otf": "a26079e0a63a02fc92c1df1aa8cf0d13",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/FontManifest.json": "288ec7536eb8d389033a388c791c2b72",
"canvaskit/skwasm.js.symbols": "741d50ffba71f89345996b0aa8426af8",
"canvaskit/canvaskit.wasm": "3d2a2d663e8c5111ac61a46367f751ac",
"canvaskit/canvaskit.js": "c86fbd9e7b17accae76e5ad116583dc4",
"canvaskit/chromium/canvaskit.wasm": "f5934e694f12929ed56a671617acd254",
"canvaskit/chromium/canvaskit.js": "43787ac5098c648979c27c13c6f804c3",
"canvaskit/chromium/canvaskit.js.symbols": "4525682ef039faeb11f24f37436dca06",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"canvaskit/skwasm.js": "445e9e400085faead4493be2224d95aa",
"canvaskit/canvaskit.js.symbols": "38cba9233b92472a36ff011dc21c2c9f",
"canvaskit/skwasm.wasm": "e42815763c5d05bba43f9d0337fa7d84",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"version.json": "aeb7bab323751ee0f61ab55348b52d06",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "c71a09214cb6f5f8996a531350400a9a",
"manifest.json": "482a9e49f7763635766487a9bfefe2ba",
"index.html": "b078111e485d47e4f98e2eaaa1cb4e7a",
"/": "b078111e485d47e4f98e2eaaa1cb4e7a",
"main.dart.js": "7e6462b11f2d6eb72700a07e22c2d015"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
