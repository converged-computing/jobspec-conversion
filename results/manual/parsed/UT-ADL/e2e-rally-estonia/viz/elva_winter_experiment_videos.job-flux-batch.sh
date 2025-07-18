#!/bin/bash
#FLUX: --job-name=Elva paper winter experiments videos
#FLUX: --queue=main
#FLUX: -t=72000
#FLUX: --urgency=16

DATASETS=(
        '2022-02-02-10-39-23_e2e_rec_elva_winter_lidar_forward_08' \
        '2022-02-02-10-50-07_e2e_rec_elva_winter_lidar_forward_08' \
        '2022-02-02-10-53-16_e2e_rec_elva_winter_lidar_backw_08' \
        '2022-02-02-11-05-18_e2e_rec_elva_winter_lidar-v5_forw_08' \
        '2022-02-02-11-18-14_e2e_rec_elva_winter_lidar-v5_backw_08' \
        '2022-02-02-11-32-37_e2e_rec_elva_winter_lidar-v3_forw_08' \
        '2022-02-02-11-45-34_e2e_rec_elva_winter_lidar-v3_backw_08' \
        '2022-02-02-11-58-48_e2e_rec_elva_winter_camera-v3_forw_08'
    )
module load any/python/3.8.3-conda
source activate ros2
cd /gpfs/space/home/rometaid/nvidia-e2e/viz
srun ./create_driving_video.sh ${DATASETS[$SLURM_ARRAY_TASK_ID]}
