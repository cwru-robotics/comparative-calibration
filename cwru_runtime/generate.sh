for s in $( seq 1.0 0.01 1.0 )
do
	mkdir $PWD/data_$s
	cp $PWD/task_description.yml $PWD/data_$s/task_description.yml
	cp $PWD/../raw_data_cwru/*.png $PWD/data_$s/
	new_spacing=$(echo "0.0502 / $s" | genius)
	sed -i -e "s/0.0502/$new_spacing/g" $PWD/data_$s/task_description.yml
	roslaunch dotboard_detection dots_detect.launch adf_path:=$PWD/data_$s/task_description.yml csv_path:=$PWD/data_$s/intrinsic_detections.csv
done
