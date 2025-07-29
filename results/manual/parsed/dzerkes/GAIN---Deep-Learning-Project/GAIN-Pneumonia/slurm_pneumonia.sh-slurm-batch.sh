#!/bin/bash
#FLUX: --job-name=Team 1 - imputation on pneumonia dataset with GAIN
#FLUX: --queue=gpu
#FLUX: -t=172800
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export NUM_THREADS=$SLURM_CPUS_PER_TASK
module purge
module load  gnu/8 intel/18 intelmpi/2018 cuda/10.1.168 pytorch/1.4.0
source /users/pa19/gealexdl/team1/venv/bin/activate
srun python3 /users/pa19/gealexdl/team1/GAIN_pneumonia.py
deactivate  
