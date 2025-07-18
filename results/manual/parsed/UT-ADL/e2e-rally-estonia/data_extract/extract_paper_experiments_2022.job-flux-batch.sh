#!/bin/bash
#FLUX: --job-name=Extract driving data from bag file
#FLUX: --queue=main
#FLUX: -t=72000
#FLUX: --urgency=16

BAGS=(
    '2022-04-28-11-59-00_e2e_elva_forw_inTrain_camera_0.8.bag' \
    '2022-04-28-12-10-19_e2e_elva_back_inTrain_camera_0.8.bag' \
    '2022-04-28-13-02-25_e2e_elva_forw_inTrain_lidar_x517_y45_0.8.bag' \
    '2022-04-28-13-14-00_e2e_elva_back_inTrain_lidar_x517_y45_0.8.bag' \
    '2022-04-28-13-37-48_e2e_elva_forw_BGR_inTrain_0.8.bag' \
    '2022-04-28-13-48-48_e2e_elva_back_BGR_inTrain_0.8.bag' \
    '2022-04-28-15-23-45_e2e_elva_RGB_forw_0.8.bag' \
    '2022-04-28-15-35-09_e2e_elva_RGB_back_0.8.bag' \
    '2022-04-28-15-46-30_e2e_elva_BGR_forw_0.8.bag' \
    '2022-04-28-15-57-16_e2e_elva_BGR_back_0.8.bag' \
    '2022-04-28-16-09-27_e2e_elva_lidar_forw_x45_y517_0.8.bag' \
    '2022-04-28-16-20-09_e2e_elva_lidar_back_x45_y517_0.8.bag' \
    '2022-04-28-16-31-42_e2e_elva_camera_v1_forw_0.8.bag' \
    '2022-04-28-16-42-14_e2e_elva_camera_v1_back_0.8.bag' \
    '2022-05-04-10-54-24_e2e_elva_seasonal_val_set_forw.bag' \
    '2022-05-04-11-01-40_e2e_elva_seasonal_val_set_back.bag' \
    '2022-05-04-11-11-34_e2e_elva_camera_inTrain_forw_0.8.bag' \
    '2022-05-04-11-22-13_e2e_elva_camera_inTrain_back_0.8.bag' \
    '2022-05-04-11-33-45_e2e_elva_camera_v1_forw_0.8.bag' \
    '2022-05-04-11-44-53_e2e_elva_camera_v1_back_0.8.bag' \
    '2022-05-04-11-55-47_e2e_elva_camera_v2_forw_0.8.bag' \
    '2022-05-04-12-06-46_e2e_elva_camera_v2_back_0.8.bag' \
    '2022-05-04-12-18-31_e2e_elva_camera_v3_forw_0.8.bag' \
    '2022-05-04-12-29-12_e2e_elva_camera_v3_back_0.8.bag' \
    '2022-05-04-13-39-42_e2e_elva_lidar_intrain_forw_0.8.bag' \
    '2022-05-04-14-15-58_e2e_elva_lidar_intrain_back2_0.8.bag' \
    '2022-05-04-14-22-26_e2e_elva_intensity_forw_0.8.bag' \
    '2022-05-04-14-27-04_e2e_elva_lidar_v2_forw_0.8.bag' \
    '2022-05-04-14-37-56_e2e_elva_lidar_v2_back_0.8.bag' \
    '2022-05-04-14-48-47_e2e_elva_lidar_v1_forw_0.8.bag' \
    '2022-05-04-14-59-26_e2e_elva_lidar_v1_back_0.8.bag' \
    '2022-05-04-15-10-31_e2e_elva_lidar_v3_forw_0.8.bag' \
    '2022-05-04-15-27-12_e2e_elva_lidar_v3_back_0.8.bag' \
    '2022-05-04-15-19-38_e2e_elva_lidar_v3_forw2_0.8.bag' \
    )
module load any/python/3.8.3-conda
source activate ros
cd /gpfs/space/home/rometaid/nvidia-e2e/data_extract
srun ./extract_rocket.sh ${BAGS[$SLURM_ARRAY_TASK_ID]}  /gpfs/space/projects/Bolt/dataset-paper
