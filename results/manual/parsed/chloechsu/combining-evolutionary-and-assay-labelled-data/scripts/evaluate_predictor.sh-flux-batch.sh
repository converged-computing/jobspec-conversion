#!/bin/bash
#FLUX: --job-name=evaluate
#FLUX: -c=16
#FLUX: --queue=<partitionname>
#FLUX: -t=1440
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
dataset=$1
predictor=$2
n_seeds=$3
n_train=$4
n_threads=16
kwargs=$5
python src/evaluate.py $dataset $predictor \
	--n_threads=$n_threads --n_seeds=$n_seeds \
	--n_train=$n_train --joint_training $kwargs
