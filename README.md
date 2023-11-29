# comparative-calibration
Automated data acquisition scripts for `Precision Camera Calibration Using Known Target Motions Along Three Perpendicular Axes`.
You will need this package, the Genuis command-line calculator, cal-3d and its dependencies, and the testing forks of ros-industrial and image_pipeline:

```
cd ~/ros_ws/src
sudo apt install genius
git clone git@github.com:cwru-robotics/industrial_calibration.git -b indigo-devel
git clone git@github.com:ros-industrial/intelligent_actuator.git
git clone git@github.com:cwru-robotics/image_pipeline.git
git clone git@github.com:cwru-robotics/3d-calibration.git
cd ..
catkin_make
```

Once everything is set up, you will need to acquire the initial image data that the error generation scripts will permute. Then, you can create the comparative data.

# Data Generation

## Acquiring Initial CWRU Data

```
# From comparative-calibration root directory...
roslaunch intrinsic_simulation cam_launch.launch acquire_file:=$PWD/raw_data_cwru/task_description.yml

roslaunch intrinsic_acquisition intrinsic_acquisition.launch path:=$PWD/raw_data_cwru/task_description.yml

roslaunch dotboard_detection dots_detect.launch adf_path:=$PWD/raw_data_cwru/task_description.yml csv_path:=$PWD/raw_data_cwru/intrinsic_detections.csv
```

## Acquiring initial industrial data

```
# From comparative-calibration root directory...
roslaunch intrinsic_simulation cam_launch.launch acquire_file:=$PWD/raw_data_ind/task_description.yml cam_file:=$PWD/raw_data_ind/camera_headon.yml

roslaunch intrinsic_acquisition intrinsic_acquisition.launch path:=$PWD/raw_data_ind/task_description.yml
```

## Acquiring initial Zhang data
Very similar to CWRU acquisition, but you need to have `3d-calibration` package be on branch `zhang_gen` to get the rotation. Then,

```
# From comparative-calibration root directory...
roslaunch intrinsic_simulation cam_launch.launch acquire_file:=$PWD/raw_data_zhang/task_description.yml

roslaunch intrinsic_acquisition intrinsic_acquisition.launch path:=$PWD/raw_data_zhang/task_description.yml

# This version of the target detector eliminates illegible images so that the decimation step removes ten ACTUALLY USEFUL elements each run.
roslaunch dotboard_detection dots_detect.launch adf_path:=$PWD/raw_data_zhang/task_description.yml csv_path:=$PWD/raw_data_zhang/intrinsic_detections.csv
```

# Generating comparative data
The various folders in this repository contain scripts called `generate.sh` and `calibrate.sh`. If it exists, `generate.sh` should be run first. `calibrate.sh` will then output the results of many calibrations to the command line. I use Terminator's logging feature (right click on the terminal and select 'start logging' before running anything) to save all of the output in a single file. I suppose you could also use the `>` command, but I ran into problems with this not properly interleaving (or skipping entirely) output from ros_info, ros_error, printf, and echo sources.

Also, be aware that some of these acquisition scripts can take a long time to run, on the order of hours or even a day or two.

# Processing data
I used grep to strip out all lines that don't contain important data. i.e.:

```
grep "Read in\|RMS value\|fx =\|k1 =" cwru_scale_raw.txt > cwru_scale_proc.txt

grep "s =\|final cost\|camera_matrix data\|distortion data" ind_target_scale_raw.txt > ind_target_scale_proc.txt

grep "s =\|n =\|D =\|P =\|RPE is" zhang_target_scale_raw.txt > zhang_target_scale_proc.csv
```

Some additional manual find-and-replace was used to turn the resulting lines into neat columnar data. Additionally, it would be a good idea to give each data set a manual look-over to see if any weird messages happen to be included in it that will make the data difficult to parse.
