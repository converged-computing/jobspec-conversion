#!/bin/bash
#SBATCH --job-name=wmt-en2de
#SBATCH --output=./logfiles/logfile_wmt_s2s.out
#SBATCH --error=./logfiles/logfile_wmt_s2s.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --gres=gpu:4
#SBATCH --time=2-00:00:00
#SBATCH --qos=qos_gpu-t4
#SBATCH --constraint=v100-32g

module purge
module load anaconda-py3/2019.03
conda activate modelcomparisontranslation
set -x
nvidia-smi
srun accelerate launch --multi_gpu train_mp_transformer.py
