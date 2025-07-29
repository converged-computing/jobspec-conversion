#!/bin/bash
#SBATCH --output=//data/scratch/avanhilten/GenNet_logs/out_%j.log
#SBATCH --error=//data/scratch/avanhilten/GenNet_logs/error_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=6
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=40G
#SBATCH --time=2-00:00:00
#SBATCH --partition=short

module purge
module load Python/3.7.4-GCCcore-8.3.0
module load libs/cuda/10.1.243
module load libs/cudnn/7.6.5.32-CUDA-10.1.243
module load TensorFlow/2.2.0-fosscuda-2019b-Python-3.7.4
source $HOME/venv_GenNet_37/bin/activate
python ./GenNet_utils/Convert.py -job_begins $1 -job_tills $2 -job_n $3 -study_name $4 -outfolder $5 -tcm $6
