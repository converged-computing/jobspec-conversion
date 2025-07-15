#!/bin/bash
#FLUX: --job-name=chunky-rabbit-4605
#FLUX: --queue=any_cpu
#FLUX: --urgency=16

export PATH='/net/pulsar/home/koes/dkoes/git/smina/build/:$PATH'

export PATH=/net/pulsar/home/koes/dkoes/git/smina/build/:$PATH
cd $SLURM_SUBMIT_DIR
cmd=`sed -n "${SLURM_ARRAY_TASK_ID}p" alldock`
eval $cmd
