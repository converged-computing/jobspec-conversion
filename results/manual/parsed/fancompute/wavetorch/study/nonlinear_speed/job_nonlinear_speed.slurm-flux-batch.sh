#!/bin/bash
#FLUX: --job-name=nonlinear_speed
#FLUX: -c=8
#FLUX: --queue=normal
#FLUX: -t=129600
#FLUX: --urgency=16

export MKL_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export NUMEXPR_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export PYTHONPATH='$(pwd)'

export MKL_NUM_THREADS=$SLURM_CPUS_PER_TASK
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export NUMEXPR_NUM_THREADS=$SLURM_CPUS_PER_TASK
export PYTHONPATH=$(pwd)
echo "Job started at: $(date +'%d/%m/%y - %H:%m')"
echo ""
srun python -u ./study/vowel_train.py ./study/nonlinear_speed/nonlinear_speed.yml \
    --num_threads $SLURM_CPUS_PER_TASK \
    --name $SLURM_JOB_ID \
    --savedir ./study/nonlinear_speed/
