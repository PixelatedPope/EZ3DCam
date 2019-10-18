/// returns a new vector with the given vectors added together
/// @param vector1
/// @param vector2
/// @param <vector3...>
var _new = [0,0,0];
for(var _i= 0; _i<argument_count; _i++)
{
	var _vec = argument[_i];
	_new[0]+=_vec[0];
	_new[1]+=_vec[1];
	_new[2]+=_vec[2];
}
return _new