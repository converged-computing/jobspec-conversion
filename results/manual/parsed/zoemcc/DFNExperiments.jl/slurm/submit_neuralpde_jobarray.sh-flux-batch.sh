#!/bin/bash
#FLUX: --job-name=chunky-punk-0030
#FLUX: --urgency=16

export LOG_DIR='/home/gridsan/zmccarthy/logs/spme_c_e_first'
export SLURM_ARRAY_TASK_ID='$SLURM_ARRAY_TASK_ID'
export SLURM_ARRAY_TASK_COUNT='$SLURM_ARRAY_TASK_COUNT'

source /home/gridsan/zmccarthy/.julia_profile
export LOG_DIR="/home/gridsan/zmccarthy/logs/spme_c_e_first"
export SLURM_ARRAY_TASK_ID=$SLURM_ARRAY_TASK_ID
export SLURM_ARRAY_TASK_COUNT=$SLURM_ARRAY_TASK_COUNT
echo "args:"
echo $SLURM_ARRAY_TASK_ID
echo $SLURM_ARRAY_TASK_COUNT
echo $LOG_DIR
julia $DFNEXPERIMENTS_DIR/test/pybamm_generate_spme.jl 
