#!/bin/bash
#FLUX: --job-name=bricky-leader-7568
#FLUX: -n=2
#FLUX: --queue=gpu
#FLUX: -t=259440
#FLUX: --urgency=16

module load SLEAP
DATA_DIR=/ceph/zoo/users/sminano/crabs_pose_4k_TD4
JOB_DIR=$DATA_DIR/labels.v001.slp.training_job
INFER_DIR_NAME=Camera2
INFER_VIDEO_NAME=NINJAV_S001_S001_T010.MOV
INFER_VIDEO_PATH=/ceph/zoo/raw/CrabField/swc-courtyard_2023/$INFER_DIR_NAME/$INFER_VIDEO_NAME
cd $JOB_DIR
sleap-track $INFER_VIDEO_PATH \
    -m $JOB_DIR/models/230725_174219.centroid/training_config.json \
    -m $JOB_DIR/models/230725_174219.centered_instance/training_config.json \
    -o $INFER_DIR_NAME-$INFER_VIDEO_NAME.predictions.slp \
    --frames 2000-6000 \
    --verbosity json \
    --no-empty-frames \
    --tracking.tracker none \
    --gpu auto \
    --max_instances 1 \
    --batch_size 4
