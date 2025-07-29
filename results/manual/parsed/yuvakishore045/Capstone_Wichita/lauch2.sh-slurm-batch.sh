#!/bin/bash
#SBATCH --job-name=test
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=50G
#SBATCH --time=2-12:00:00
#SBATCH --partition=wsu_gen_gpu.q

module load Python/3.9.6-GCCcore-11.2.0
source /home/p793x363/Documents/test/bin/activate
python Wav2vec2.py  #run python script
