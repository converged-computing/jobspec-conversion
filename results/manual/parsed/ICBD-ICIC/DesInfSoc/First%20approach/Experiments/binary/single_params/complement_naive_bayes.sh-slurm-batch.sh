#!/bin/bash
#FLUX: --job-name=itrust-complement_naive_bayes
#FLUX: -c=2
#FLUX: -t=604800
#FLUX: --urgency=16

source .experiments_env/bin/activate
srun python complement_naive_bayes.py ${SLURM_ARRAY_TASK_ID} context_SPREAD60_K3_H4_P12-BINARY 0 True
srun python complement_naive_bayes.py ${SLURM_ARRAY_TASK_ID} context_SPREAD60_K3_H4_P12-BINARY 0.05 True
srun python complement_naive_bayes.py ${SLURM_ARRAY_TASK_ID} context_SPREAD60_K3_H4_P12-BINARY 0.1 True
srun python complement_naive_bayes.py ${SLURM_ARRAY_TASK_ID} context_SPREAD60_K3_H4_P12-BINARY 0.15 True
srun python complement_naive_bayes.py ${SLURM_ARRAY_TASK_ID} context_SPREAD60_K3_H4_P12-BINARY 0.2 True
srun python complement_naive_bayes.py ${SLURM_ARRAY_TASK_ID} context_SPREAD60_K3_H4_P12-BINARY 10 True
srun python complement_naive_bayes.py ${SLURM_ARRAY_TASK_ID} context_SPREAD60_K3_H4_P12-BINARY 0 False
srun python complement_naive_bayes.py ${SLURM_ARRAY_TASK_ID} context_SPREAD60_K3_H4_P12-BINARY 0.05 False
srun python complement_naive_bayes.py ${SLURM_ARRAY_TASK_ID} context_SPREAD60_K3_H4_P12-BINARY 0.1 False
srun python complement_naive_bayes.py ${SLURM_ARRAY_TASK_ID} context_SPREAD60_K3_H4_P12-BINARY 0.15 False
srun python complement_naive_bayes.py ${SLURM_ARRAY_TASK_ID} context_SPREAD60_K3_H4_P12-BINARY 0.2 False
srun python complement_naive_bayes.py ${SLURM_ARRAY_TASK_ID} context_SPREAD60_K3_H4_P12-BINARY 10 False
