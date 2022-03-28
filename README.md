# comparative-calibration
Automated data acquisition scripts for FILL IN NAME OF PAPER HERE.

## Acquiring Initial CWRU Data

CWRU calibration testing uses a single set of data, and changes the expected parameters of the calibration away from it.
```
roslaunch intrinsic_simulation cam_launch.launch acquire_file:=$PWD/raw_data_cwru/task_description.yml

roslaunch intrinsic_acquisition intrinsic_acquisition.launch path:=$PWD/raw_data_cwru/task_description.yml

roslaunch dotboard_detection dots_detect.launch adf_path:=$PWD/task_description.yml csv_path:=$PWD/intrinsic_detections.csv
```

##Acquiring initial industrial data

```
roslaunch intrinsic_simulation cam_launch.launch acquire_file:=$PWD/raw_data_ind/task_description.yml cam_file:=$PWD/raw_data_ind/camera_headon.yml

roslaunch intrinsic_acquisition intrinsic_acquisition.launch path:=$PWD/raw_data_ind/task_description.yml
```

grep "Read in\|task_description.yml\|RMS vale\|fx =\|k1 =" cwru_scale_raw.txt > cwru_scale_proc.txt

grep "s =\|final cost\|camera_matrix data\|distortion data" ind_target_scale_raw.txt > ind_target_scale_proc.txt
