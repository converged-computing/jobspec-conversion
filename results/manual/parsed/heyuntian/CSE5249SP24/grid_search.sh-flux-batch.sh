#!/bin/bash
#FLUX: --job-name=arid-salad-3392
#FLUX: -t=21600
#FLUX: --priority=16

source /home/he.1773/.bashrc
source activate confMILE
echo $CONDA_PREFIX
echo $SLURM_JOB_ID
GPUS=$(srun hostname | tr '\n' ' ')
GPUS=${GPUS//".cluster"/""}
echo $GPUS
module load cuda/11.8
nvidia-smi
which nvidia-smi
for EPOCH in 200 500 1000
do
  for LAMBDA in 0.1 0.3 0.5 0.7 0.9 0.99
  do
    for LR in 0.02 0.01 0.005 0.001
    do
      python main.py --jobid ${SLURM_JOB_ID} --lambda-fl ${LAMBDA} --learning-rate ${LR} --epoch ${EPOCH}
    done
  done
done
