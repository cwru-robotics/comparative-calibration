for s in $( seq 0.0 0.5 10.0 )
do
	echo "$s"
	mkdir $PWD/data_$s
	cp $PWD/task_description.yml $PWD/data_$s/task_description.yml
	
	c=0
	
	RANDOM=12345
	while read l
	do
		echo "	$c"
		c=$((c+1))
		
		vals=(${l//,/ })
		u_start=${vals[0]}
		v_start=${vals[1]}
		
		u_one=$( echo "$RANDOM / 32767" | genius)
		u_two=$( echo "$RANDOM / 32767" | genius)
		normal=$(echo "sqrt(-2 * ln($u_one)) * cos(2 * pi * $u_two)" | genius) #https://en.wikipedia.org/wiki/Box%E2%80%93Muller_transform
		u_distort=$(echo "($normal * -0.5 * $s) + $u_start" | genius)
		u_one=$( echo "$RANDOM / 32767" | genius)
		u_two=$( echo "$RANDOM / 32767" | genius)
		normal=$(echo "sqrt(-2 * ln($u_one)) * cos(2 * pi * $u_two)" | genius)
		v_distort=$(echo "($normal * -0.5 * $s) + $v_start" | genius)
		
		echo "$u_distort, $v_distort, ${vals[2]}, ${vals[3]}, ${vals[4]}, ${vals[5]}, ${vals[6]}" >> $PWD/data_$s/intrinsic_detections.csv
	done < $PWD/../raw_data_cwru/intrinsic_detections.csv
done
