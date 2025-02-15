{
  "$GMObject":"",
  "%Name":"obj_player",
  "eventList":[
    {"$GMEvent":"v1","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":0,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
    {"$GMEvent":"v1","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":3,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
    {"$GMEvent":"v1","%Name":"","collisionObjectId":null,"eventNum":4,"eventType":7,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
    {"$GMEvent":"v1","%Name":"","collisionObjectId":null,"eventNum":1,"eventType":3,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
  ],
  "managed":true,
  "name":"obj_player",
  "overriddenProperties":[
    {"$GMOverriddenProperty":"v1","%Name":"","name":"","objectId":{"name":"obj_caster","path":"objects/obj_caster/obj_caster.yy",},"propertyId":{"name":"known_spells","path":"objects/obj_caster/obj_caster.yy",},"resourceType":"GMOverriddenProperty","resourceVersion":"2.0","value":"8",},
    {"$GMOverriddenProperty":"v1","%Name":"","name":"","objectId":{"name":"obj_caster","path":"objects/obj_caster/obj_caster.yy",},"propertyId":{"name":"prepared_spells","path":"objects/obj_caster/obj_caster.yy",},"resourceType":"GMOverriddenProperty","resourceVersion":"2.0","value":"array_create(max_prepared_spells, {spell_id : 8, is_ready : true, target_bitmask: 0});",},
    {"$GMOverriddenProperty":"v1","%Name":"","name":"","objectId":{"name":"obj_caster","path":"objects/obj_caster/obj_caster.yy",},"propertyId":{"name":"current_mana","path":"objects/obj_caster/obj_caster.yy",},"resourceType":"GMOverriddenProperty","resourceVersion":"2.0","value":"0",},
    {"$GMOverriddenProperty":"v1","%Name":"","name":"","objectId":{"name":"obj_character","path":"objects/obj_character/obj_character.yy",},"propertyId":{"name":"percent_health_regen_per_second","path":"objects/obj_character/obj_character.yy",},"resourceType":"GMOverriddenProperty","resourceVersion":"2.0","value":"10",},
    {"$GMOverriddenProperty":"v1","%Name":"","name":"","objectId":{"name":"obj_character","path":"objects/obj_character/obj_character.yy",},"propertyId":{"name":"current_health","path":"objects/obj_character/obj_character.yy",},"resourceType":"GMOverriddenProperty","resourceVersion":"2.0","value":"0",},
    {"$GMOverriddenProperty":"v1","%Name":"","name":"","objectId":{"name":"obj_character","path":"objects/obj_character/obj_character.yy",},"propertyId":{"name":"max_health","path":"objects/obj_character/obj_character.yy",},"resourceType":"GMOverriddenProperty","resourceVersion":"2.0","value":"50",},
  ],
  "parent":{
    "name":"player",
    "path":"folders/Objects/character/player.yy",
  },
  "parentObjectId":{
    "name":"obj_caster",
    "path":"objects/obj_caster/obj_caster.yy",
  },
  "persistent":true,
  "physicsAngularDamping":0.1,
  "physicsDensity":0.5,
  "physicsFriction":0.2,
  "physicsGroup":1,
  "physicsKinematic":false,
  "physicsLinearDamping":0.1,
  "physicsObject":false,
  "physicsRestitution":0.1,
  "physicsSensor":false,
  "physicsShape":1,
  "physicsShapePoints":[],
  "physicsStartAwake":true,
  "properties":[
    {"$GMObjectProperty":"v1","%Name":"last_required_percent_spell_index","filters":[],"listItems":[],"multiselect":false,"name":"last_required_percent_spell_index","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"selected_spell_index","varType":1,},
    {"$GMObjectProperty":"v1","%Name":"visible_spell_slot_01","filters":[],"listItems":[],"multiselect":false,"name":"visible_spell_slot_01","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"noone","varType":4,},
    {"$GMObjectProperty":"v1","%Name":"visible_spell_slot_02","filters":[],"listItems":[],"multiselect":false,"name":"visible_spell_slot_02","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"noone","varType":4,},
    {"$GMObjectProperty":"v1","%Name":"visible_spell_slot_03","filters":[],"listItems":[],"multiselect":false,"name":"visible_spell_slot_03","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"noone","varType":4,},
    {"$GMObjectProperty":"v1","%Name":"camera","filters":[],"listItems":[],"multiselect":false,"name":"camera","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"instance_create_layer(x, y, \"utility\", obj_camera, {follow_target : id});","varType":4,},
    {"$GMObjectProperty":"v1","%Name":"vertical_look_ratio","filters":[],"listItems":[],"multiselect":false,"name":"vertical_look_ratio","rangeEnabled":true,"rangeMax":1.0,"rangeMin":-1.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"0","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"last_valid_vertical_look_ratio","filters":[],"listItems":[],"multiselect":false,"name":"last_valid_vertical_look_ratio","rangeEnabled":true,"rangeMax":1.0,"rangeMin":-1.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"0","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"horizontal_look_ratio","filters":[],"listItems":[],"multiselect":false,"name":"horizontal_look_ratio","rangeEnabled":true,"rangeMax":1.0,"rangeMin":-1.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"0","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"last_valid_horizontal_look_ratio","filters":[],"listItems":[],"multiselect":false,"name":"last_valid_horizontal_look_ratio","rangeEnabled":true,"rangeMax":1.0,"rangeMin":-1.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"1","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"walk_speed","filters":[],"listItems":[],"multiselect":false,"name":"walk_speed","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"10","varType":1,},
    {"$GMObjectProperty":"v1","%Name":"run_speed","filters":[],"listItems":[],"multiselect":false,"name":"run_speed","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"16","varType":1,},
    {"$GMObjectProperty":"v1","%Name":"current_move_speed","filters":[],"listItems":[],"multiselect":false,"name":"current_move_speed","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"0","varType":1,},
    {"$GMObjectProperty":"v1","%Name":"move_x","filters":[],"listItems":[],"multiselect":false,"name":"move_x","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"0.0","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"move_y","filters":[],"listItems":[],"multiselect":false,"name":"move_y","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"0.0","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"default_control_scheme","filters":[],"listItems":[],"multiselect":false,"name":"default_control_scheme","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"{horizontal_move: gp_axislh, vertical_move: gp_axislv, horizontal_look: gp_axisrh, vertical_look: gp_axisrv, run: gp_stickl, cast_spell: gp_shoulderrb, open_spellbook: gp_select}","varType":4,},
    {"$GMObjectProperty":"v1","%Name":"max_health","filters":[],"listItems":[],"multiselect":false,"name":"max_health","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"50","varType":1,},
    {"$GMObjectProperty":"v1","%Name":"current_health","filters":[],"listItems":[],"multiselect":false,"name":"current_health","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"50","varType":1,},
    {"$GMObjectProperty":"v1","%Name":"percent_health_regen_per_second","filters":[],"listItems":[],"multiselect":false,"name":"percent_health_regen_per_second","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"2","varType":1,},
    {"$GMObjectProperty":"v1","%Name":"is_spellbook_open","filters":[],"listItems":[],"multiselect":false,"name":"is_spellbook_open","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"False","varType":3,},
  ],
  "resourceType":"GMObject",
  "resourceVersion":"2.0",
  "solid":false,
  "spriteId":{
    "name":"spr_player",
    "path":"sprites/spr_player/spr_player.yy",
  },
  "spriteMaskId":null,
  "visible":true,
}