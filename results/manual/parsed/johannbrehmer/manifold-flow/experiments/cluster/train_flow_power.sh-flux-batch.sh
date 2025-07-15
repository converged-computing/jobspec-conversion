#!/bin/bash
#FLUX: --job-name=t-sf-p
#FLUX: -c=4
#FLUX: -t=604800
#FLUX: --priority=16

export OMP_NUM_THREADS='1'

module load cuda/10.1.105
source activate ml
export OMP_NUM_THREADS=1
cd /scratch/jb6504/manifold-flow/experiments
python -u train.py --modelname march --dataset power --algorithm flow --splinebins 10 --splinerange 6. --samplesize 100000 -i ${SLURM_ARRAY_TASK_ID}
