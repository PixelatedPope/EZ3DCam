/// @description wrap(value,min,max)
/// @param value
/// @param min
/// @param max
//returns the value wrapped. If it is above or below the threshold it will wrap around
function wrap(_val, _min, _max) {
	return (_val-_min)-floor((_val-_min)/(_max-_min))*(_max-_min) + _min;
}
