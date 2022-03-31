for s in $( seq 0.90 0.01 1.10 )
do
	mkdir $PWD/data_$s
	cp $PWD/task_description.yml $PWD/data_$s/task_description.yml
	
	c=0
	
	RANDOM=12345
	while read l
	do
		echo "	$c"
		c=$((c+1))
		
		vals=(${l//,/ })
		x_start=${vals[2]}
		y_start=${vals[3]}
		z_start=${vals[4]}
		
		x_distort=$(echo "$x_start / $s" | genius)
		y_distort=$(echo "$y_start / $s" | genius)
		z_distort=$(echo "$z_start / $s" | genius)
		
		echo "${vals[0]}, ${vals[1]}, $x_distort, $y_distort, $z_distort, ${vals[5]}, ${vals[6]}" >> $PWD/data_$s/intrinsic_detections.csv
	done < $PWD/../raw_data_cwru/intrinsic_detections.csv
done
