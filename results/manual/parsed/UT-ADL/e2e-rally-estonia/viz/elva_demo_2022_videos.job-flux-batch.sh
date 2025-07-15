#!/bin/bash
#FLUX: --job-name="Elva demo experiments videos"
#FLUX: --queue=main
#FLUX: -t=72000
#FLUX: --priority=16

DATASETS=(
    '2022-06-17-13-21-37_e2e_elva__steering' \
    '2022-06-17-13-21-51_e2e_elva__steering' \
    '2022-06-17-13-42-44_e2e_elva__trajectory' \
    '2022-06-17-14-00-57_e2e_elva__trajectory_turn' \
    '2022-06-17-14-06-10_e2e_elva__trajectory_bal' \
    '2022-06-17-14-26-28_e2e_elva__steering_wide' \
    '2022-06-17-14-41-00_e2e_elva__steering_wide' \
    '2022-06-17-14-45-02_e2e_elva__steering_wide' \
    '2022-06-17-14-51-25_e2e_elva__steering_wide_bal' \
)
module load any/python/3.8.3-conda
source activate ros2
cd /gpfs/space/home/rometaid/nvidia-e2e/viz
srun ./create_driving_video.sh ${DATASETS[$SLURM_ARRAY_TASK_ID]}
