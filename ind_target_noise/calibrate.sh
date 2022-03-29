roscore &
sleep 3

rosparam set /rail_cal_service/camera_inaccurate/min_area 10
rosparam set /rail_cal_service/camera_inaccurate/max_area 80000
#We don't want the solver to start with EXACTLY the right answer.
rostopic pub /camera_inaccurate/camera_info sensor_msgs/CameraInfo "header:
  seq: 0
  stamp: {secs: 0, nsecs: 0}
  frame_id: ''
height: 480
width: 640
distortion_model: 'plumb_bob'
D: [-0.15, 0.3, -0.001, 0.005, -0.03]
K: [500.0, 0.0, 275.0, 0.0, 500.0, 200.0, 0.0, 0.0, 1.0]
R: [1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0]
P: [500.0, 0.0, 275.0, 0.0, 0.0, 500.0, 200.0, 0.0, 0.0, 0.0, 1.0, 0.0]
binning_x: 0
binning_y: 0
roi: {x_offset: 0, y_offset: 0, height: 0, width: 0, do_rectify: false}" &
sleep 3

rosrun image_view image_view image:=/camera/image_raw __name:=view_1 &
rosrun image_view image_view image:=/camera_inaccurate/observer_results_image __name:=view_2 &
sleep 3

for s in $( seq 0.0 0.5 10.0 )
do
	rosparam set /rail_cal_service/camera_inaccurate/random_wobble $s
	mkdir $PWD/data_$s
	cp $PWD/../raw_data_ind/img_* $PWD/data_$s
	list=$(find $PWD/data_$s -type f | shuf)
	sorted_list=$(find $PWD/data_$s -type f | sort)
	n=200
	for f in $list
	do
		if ! (($n % 10)) && (($n > 0)) #Calibrate every ten files blanked.
		then
			echo "s = $s, n = $n"
			rosrun intrinsic_cal rail_ical _target_rows:=6 _target_cols:=8 _target_circle_dia:=0.03 _target_spacing:=0.0502 _target_to_rail_distance:=0.35 _num_camera_locations:=188 _camera_spacing:=0.005319149 _image_topic:=/camera/image_raw _camera_name:=camera_inaccurate _image_height:=480 _image_width:=640 _use_circle_detector:=true &
			cal_pid=$!
			sleep 3
		
			rosservice call --wait /RailCalService "allowable_cost_per_observation: 9000.0" &
			srv_pid=$!
			sleep 1
			for i in $sorted_list
			do
				rosrun image_publisher image_publisher $i __name:=camera &
				rosparam set /rail_cal_service/camera_ready true
				while $(rosparam get /rail_cal_service/camera_ready) && ps -p $srv_pid > /dev/null
				do
					: #echo "Waiting"
				done
				killall image_publisher
			done
		
			echo "WAITING ON SERV TO FINISH"
			wait $srv_pid
			killall rail_ical
			wait $cal_pid
		fi
		#Blank one file to reduce the total number
		n=$(($n-1))
		cp $PWD/../raw_data_ind/flatblack.png $f
	done

done
