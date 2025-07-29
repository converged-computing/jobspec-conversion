#!/bin/bash
#SBATCH --output=Errors/job.%J.out
#SBATCH --error=Errors/job.%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:2
#SBATCH --time=2-00:00:00

export TF_CPP_MIN_LOG_LEVEL='2'

module purge 
source /share/apps/NYUAD/miniconda/3-4.11.0/bin/activate
conda activate tf-env2
export TF_CPP_MIN_LOG_LEVEL="2"
python main.py "../DatabaseV2/TrainSet" "../DatabaseV2/TestSet"
