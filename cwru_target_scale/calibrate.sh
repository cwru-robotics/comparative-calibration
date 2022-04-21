for s in $( seq 0.9 0.01 1.10 )
do
	while [ $(cat $PWD/data_$s/intrinsic_detections.csv | wc -l ) -gt 0 ]
	do
		roslaunch intrinsic_calibration calibrate.launch data:=$PWD/data_$s/intrinsic_detections.csv position_initial:=$PWD/data_$s/task_description.yml
		sed -i -e 1,480d $PWD/data_$s/intrinsic_detections.csv
	done
done
