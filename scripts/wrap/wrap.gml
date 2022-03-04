/// @description wrap(value,min,max)
/// @param value
/// @param min
/// @param max
function wrap(argument0, argument1, argument2) {
	//returns the value wrapped. If it is above or below the threshold it will wrap around

	var _val = argument0;
	var _min = min(argument1,argument2);
	var _max = max(argument1,argument2);

	return (_val-_min)-floor((_val-_min)/(_max-_min))*(_max-_min) + _min;







}
