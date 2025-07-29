#!/bin/bash
#SBATCH --job-name=DRO_compas_seed_avg
#SBATCH --output=outputs/DRO_COMPAS_avg_%a_%A.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:0
#SBATCH --mem=32000M
#SBATCH --time=04:30:00
#SBATCH --partition=gpu_shared_course
#SBATCH --array=1-10%1

module purge
module load 2019
module load Python/3.7.5-foss-2019b
module load CUDA/10.1.243
module load cuDNN/7.6.5.32-CUDA-10.1.243
module load NCCL/2.5.6-CUDA-10.1.243
module load Anaconda3/2018.12
cd $HOME/fact-ai/
source activate fact-ai-lisa
HPARAMS_FILE=./job_scripts/hparams/DRO_COMPAS.txt
srun python -u main.py $(head -$SLURM_ARRAY_TASK_ID $HPARAMS_FILE | tail -1)
