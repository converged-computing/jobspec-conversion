#!/bin/bash
#SBATCH --job-name=nonlinear_speed
#SBATCH --output=./study/nonlinear_speed/%A.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=4500mb
#SBATCH --time=1-12:00:00

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
