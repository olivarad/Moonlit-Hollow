/// @function			create_standard_room_layers()
/// @description		create standard room layers in current room.
function create_standard_room_layers()
{
	var _background_layer = layer_create(RoomLayerDepths.background, "background");
	layer_background_create(_background_layer, spr_blank);
	layer_create(RoomLayerDepths.utility, "utility");
	layer_create(RoomLayerDepths.ground, "ground");
	layer_create(RoomLayerDepths.middleground, "middleground");
	layer_create(RoomLayerDepths.foreground, "foreground");
	layer_create(RoomLayerDepths.ui, "ui");
}