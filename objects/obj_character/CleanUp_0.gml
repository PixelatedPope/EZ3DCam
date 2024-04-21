/// @description

for(var _y=0; _y<3; _y++)
{
	for(var _x=0; _x<4; _x++)
	{
		var _buff = frames[# _x, _y];
		vertex_delete_buffer(_buff);
	}
}
vertex_delete_buffer(shadow_vertex);

