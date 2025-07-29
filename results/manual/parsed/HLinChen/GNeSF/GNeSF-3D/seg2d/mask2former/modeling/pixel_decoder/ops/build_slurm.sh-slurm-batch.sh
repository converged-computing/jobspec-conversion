#!/bin/bash
#SBATCH --job-name=train_atlas
#SBATCH --output=/home/h/hanlin/output/slurm_log/%j.log
#SBATCH --error=/home/h/hanlin/output/slurm_log/%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=64000
#SBATCH --time=03:00:00
#SBATCH --nodelist=xgpc7

export CUDA_HOME='/usr/local/cuda # /usr/local/cuda-10.2'

echo "$state Start"
echo Time is `date`
echo "Directory is ${PWD}"
echo "This job runs on the following nodes: ${SLURM_JOB_NODELIST}"
nvidia-smi
export CUDA_HOME=/usr/local/cuda # /usr/local/cuda-10.2
sh make.sh
