#!/bin/bash
#FLUX: --job-name=nnUnet_job
#FLUX: -t=1800
#FLUX: --priority=16

. setup_paths.sh
. preprocess.sh
. resume_training.sh
. start_multi_gpu_training_2d.sh
