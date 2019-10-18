#region GMode7 Enum: The enum to end all enums!
enum EZ3DCam
{ 
	//Camera
	mode_first_person,
	mode_third_person,
	mode_track_target,
	rotation_local,
	rotation_world,
}
#endregion 

//Debug
#macro EZ3D obj_ez3dcam
#macro EZ3D_ENABLE if(!instance_exists(EZ3D)) instance_create_depth(0,0,0,EZ3D)

//Vectors
#macro vX 0
#macro vY 1
#macro vZ 2

//Common Vector Shortcuts
#macro vZERO [0,0,0]
#macro vONE [1,1,1]

//Matrices
#macro mX 12
#macro mY 13
#macro mZ 14