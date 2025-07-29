#!/bin/bash
#SBATCH --job-name=main
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=12GB
#SBATCH --time=14-00:00:00
#SBATCH --partition=gpu
#SBATCH --array=1-96
#SBATCH --nodelist=abacus002

export CXX='g++'

module load Miniconda3/4.9.2
module load CUDA/11.1.1-GCC-10.2.0
source activate .venv2
export CXX=g++
CASE_NUM=`printf %03d $SLURM_ARRAY_TASK_ID`
cd runs
srun bash run$CASE_NUM.sh
