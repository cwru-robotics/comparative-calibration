roslaunch intrinsic_simulation cam_launch.launch acquire_file:=$PWD/task_description.yml cam_file:=$PWD/camera_headon.yml &
sleep 30
rosrun image_view image_saver image:=/camera/image_raw_color _save_all_image:=false __name:=saver _filename_format:=$PWD/img_TMP.png &
sleep 30

for z in $( seq 0.35 0.005319149 1.35) #To produce exactly 188 images.
do
	echo "Z is $z"
	rosservice call /motion_command "x: -0.1757
y: -0.1288
theta: $z
name: ''" --wait
	echo "CALLED MOTION COMMAND"
	sleep 1.0
	echo "SAVER STARTED"
	rosservice call /saver/save --wait
	echo "SAVER SERVICE CALLED"
	sleep 2.0
	echo "SAVER DONE"
	mv $PWD/img_TMP.png $PWD/img_$z.png
done
killall roslaunch
killall image_saver
rm $PWD/*.ini
