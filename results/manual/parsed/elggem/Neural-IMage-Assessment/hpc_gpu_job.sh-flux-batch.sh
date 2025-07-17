#!/bin/bash
#FLUX: --job-name=nima-pqd
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=32400
#FLUX: --urgency=16

source ~/miniconda3/bin/activate base
module load nvidia/cuda/10.1
./train.sh $1 | tee > hpc_job_$1.log
