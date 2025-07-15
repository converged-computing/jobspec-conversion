#!/bin/bash
#FLUX: --job-name=reclusive-dog-4614
#FLUX: --priority=16

module load tensorflow/intel-1.13.1-py36
module load cray-hpo
script=genetic.py
args="-N ${SLURM_JOB_NUM_NODES} --verbose"
path=hpo/mnist-lenet5
cd $path && python $script $args
