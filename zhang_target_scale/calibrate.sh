for s in $( seq 0.90 0.01 1.10 )
do

	RANDOM=12345
	spacing_scaled=$(echo "0.0502 / $s" | genius)

	cp $PWD/../raw_data_zhang/*.png $PWD/data/
	
	SIGMA=0
	export SIGMA

	n=188
	list=$(find $PWD/data -type f | shuf)
	for f in $list
	do
		if ! ((($n - 8) % 10)) && (($n > 0)) #Calibrate every ten files blanked, with an offset of 18. Don't calibrate if n < 40.
		then
			echo "s = $s, n = $n"
			roscore &
			sleep 3
			
			
			rosrun camera_calibration cameracalibrator.py -p circles --size 8x6 --square $spacing_scaled image:=/camera/image_raw camera:=/camera --no-service-check &

			CAMCAL_PID=$!

			sleep 10

			WINDOW_ID=$(xdotool search --pid $CAMCAL_PID --onlyvisible)

			sleep 10
			xdotool windowsize $WINDOW_ID 1024 1024
			for f_prime in $list
			do
				rosrun image_publisher image_publisher $f_prime __name:=camera &
				sleep 1
				killall image_publisher
			done

			xdotool mousemove --sync --window $WINDOW_ID 695 350
			xdotool mousedown 1
			sleep 1
			xdotool mouseup 1 

			wait $CAMCAL_PID

			killall roscore
			sleep 3
		fi
		
		#Blanking
		n=$(($n-1))
		cp $PWD/../raw_data_ind/flatblack.png $f
	done

done
