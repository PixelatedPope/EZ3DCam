///@param instance_id
///@param [ez3dcam_instance]
var _id = argument0;
var _ez = argument_count > 1 ? argument[1] : EZ3D;
_id.visible = false;
with(_ez)
{
  ds_list_add(instance_register, _id);
}
