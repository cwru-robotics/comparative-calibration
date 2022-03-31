for s in $( seq 0.000 0.0005 0.01 )
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
		
		u_one=$( echo "$RANDOM / 32767" | genius)
		u_two=$( echo "$RANDOM / 32767" | genius)
		normal=$(echo "sqrt(-2 * ln($u_one)) * cos(2 * pi * $u_two)" | genius) #https://en.wikipedia.org/wiki/Box%E2%80%93Muller_transform
		x_distort=$(echo "($normal * -0.5 * $s) + $x_start" | genius)
		u_one=$( echo "$RANDOM / 32767" | genius)
		u_two=$( echo "$RANDOM / 32767" | genius)
		normal=$(echo "sqrt(-2 * ln($u_one)) * cos(2 * pi * $u_two)" | genius)
		y_distort=$(echo "($normal * -0.5 * $s) + $y_start" | genius)
		u_one=$( echo "$RANDOM / 32767" | genius)
		u_two=$( echo "$RANDOM / 32767" | genius)
		normal=$(echo "sqrt(-2 * ln($u_one)) * cos(2 * pi * $u_two)" | genius)
		z_distort=$(echo "($normal * -0.5 * $s) + $z_start" | genius)
		
		echo "${vals[0]}, ${vals[1]}, $x_distort, $y_distort, $z_distort, ${vals[5]}, ${vals[6]}" >> $PWD/data_$s/intrinsic_detections.csv
	done < $PWD/../raw_data_cwru/intrinsic_detections.csv
done
