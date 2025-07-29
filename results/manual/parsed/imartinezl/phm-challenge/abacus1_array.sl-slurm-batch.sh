#!/bin/bash
#SBATCH --job-name=main
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=12GB
#SBATCH --time=14-00:00:00
#SBATCH --array=1-384
#SBATCH --nodelist=abacus001

module load Miniconda3/4.9.2
module load CUDA/10.2.89-GCC-8.3.0 # for CPAB
source activate .venv
CASE_NUM=`printf %03d $SLURM_ARRAY_TASK_ID`
cd runs
srun bash run$CASE_NUM.sh
