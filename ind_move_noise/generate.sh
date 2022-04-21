for s in $( seq 0.000 0.0005 0.01 )
do
	mkdir $PWD/data_$s
	roslaunch intrinsic_simulation cam_launch.launch acquire_file:=$PWD/../raw_data_cwru/task_description.yml cam_file:=$PWD/../raw_data_ind/camera_headon.yml &
	sleep 30
	rosrun image_view image_saver image:=/camera/image_raw_color _save_all_image:=false __name:=saver _filename_format:=$PWD/img_tmp.png &
	sleep 30
	
	echo "s = $i"
	RANDOM=12345
	for z in $( seq 0.35 0.005319149 1.35)
	do
		u_one=$( echo "$RANDOM / 32767" | genius)
		u_two=$( echo "$RANDOM / 32767" | genius)
		normal=$(echo "sqrt(-2 * ln($u_one)) * cos(2 * pi * $u_two)" | genius) #https://en.wikipedia.org/wiki/Box%E2%80%93Muller_transform
		z_wobble=$(echo "($normal * -0.5 * $s) + $z" | genius)
		
		echo "X is -0.1757 Y is -0.1288 Z is $z"
		rosservice call /gazebo/set_model_state "model_state:
  model_name: 'target'
  pose:
    position:
      x: -0.1757
      y: -0.1288
      z: $z_wobble
    orientation:
      x: 0.0
      y: 0.0
      z: 0.0
      w: 0.0
  twist:
    linear:
      x: 0.0
      y: 0.0
      z: 0.0
    angular:
      x: 0.0
      y: 0.0
      z: 0.0
  reference_frame: ''"
		echo "CALLED MOTION COMMAND"
		sleep 1
		echo "SAVER STARTED"
		rosservice call /saver/save --wait
		sleep 1
		echo "SAVER SAVED"
		mv $PWD/img_tmp.png $PWD/data_$s/img_$z.png
		echo "Moved"
	done
	killall image_saver
	killall roslaunch
	sleep 30
done
