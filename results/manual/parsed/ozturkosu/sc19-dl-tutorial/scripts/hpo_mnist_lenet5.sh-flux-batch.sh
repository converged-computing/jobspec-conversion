#!/bin/bash
#FLUX: --job-name=hpo-mnist-lenet5
#FLUX: -N=4
#FLUX: --queue=debug
#FLUX: -t=1800
#FLUX: --urgency=16

module load tensorflow/intel-1.13.1-py36
module load cray-hpo
script=genetic.py
args="-N ${SLURM_JOB_NUM_NODES} --verbose"
path=hpo/mnist-lenet5
cd $path && python $script $args
