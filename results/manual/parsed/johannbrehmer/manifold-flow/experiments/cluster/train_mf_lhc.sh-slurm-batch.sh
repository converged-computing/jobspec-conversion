#!/bin/bash
#SBATCH --job-name=t-mf-l
#SBATCH --output=log_train_mf_lhc_%a.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=32GB
#SBATCH --time=7-00:00:00

export OMP_NUM_THREADS='1'

source activate ml
export OMP_NUM_THREADS=1
cd /scratch/jb6504/manifold-flow/experiments
python -u train.py -c configs/train_mf_lhc_june.config -i ${SLURM_ARRAY_TASK_ID}
