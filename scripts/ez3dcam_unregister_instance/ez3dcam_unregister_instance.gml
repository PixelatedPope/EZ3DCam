///@param instance_id
///@param [ez3dcam_instance]
var _id = argument0;
var _ez = argument_count > 1 ? argument[1] : EZ3D;

with(_ez)
{
  if(!ds_exists(ds_type_list,instance_register)) exit;
  var _index = ds_list_find_index(instance_register,_id);
  if(_index != -1)
    ds_list_delete(instance_register, _index);
}