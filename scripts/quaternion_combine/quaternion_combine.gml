///@param quat1
///@param quat2
///@param <quat3>
///@param <quat...>


var _q = quaternion_multiply(argument[0],argument[1])
for(var _i=2; _i<argument_count; _i++)
{
	_q = quaternion_multiply(_q,argument[_i]);
}
return _q;