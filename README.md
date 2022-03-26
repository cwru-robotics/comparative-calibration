# comparative-calibration
Automated data acquisition scripts for FILL IN NAME OF PAPER HERE.

## Acquiring Initial CWRU Data

CWRU calibration testing uses a single set of data, and changes the expected parameters of the calibration away from it.
```
roslaunch intrinsic_simulation cam_launch.launch acquire_file:=$PWD/raw_data/task_description.yml

roslaunch intrinsic_acquisition intrinsic_acquisition.launch path:=$PWD/raw_data/task_description.yml
```


grep "Read in\|task_description.yml\|RMS vale\|fx =\|k1 =" cwru_scale_raw.txt > cwru_scale_proc.txt
