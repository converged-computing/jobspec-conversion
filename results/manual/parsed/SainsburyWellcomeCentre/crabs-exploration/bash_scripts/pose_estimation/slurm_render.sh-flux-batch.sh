#!/bin/bash
#FLUX: --job-name=chunky-latke-1941
#FLUX: --urgency=16

module load SLEAP
DATA_DIR=/ceph/zoo/users/sminano/crabs_pose_4k_TD4
JOB_DIR=$DATA_DIR/labels.v001.slp.training_job
PREDICTIONS_PATH=$JOB_DIR/Camera2-NINJAV_S001_S001_T010.MOV.predictions.slp
sleap-render $PREDICTIONS_PATH --frames 2000-6000 \
    --distinctly_color nodes \
    --marker_size 1 \
    --show_edges 0 \
    --fps 60
