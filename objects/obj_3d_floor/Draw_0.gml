/// @description Insert description here
// You can write your code in this editor
var _w = ds_grid_width(ground);
var _h = ds_grid_height(ground);
matrix_set(matrix_world,matrix_build_identity());
for(var _x = 0; _x < _w; _x++)
{
	for(var _y = 0; _y < _h; _y++)
	{
		var _vertex = ground[# _x,_y];
		vertex_submit(_vertex,pr_trianglelist,sprite_get_texture(sprite_index,0));
	}
}