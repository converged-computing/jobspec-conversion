#!/bin/bash
#FLUX: --job-name=moolicious-destiny-4500
#FLUX: --queue=any_cpu
#FLUX: --priority=16

cd $SLURM_SUBMIT_DIR
cmd=`sed -n "${SLURM_ARRAY_TASK_ID}p" genrdunmin`
eval $cmd
