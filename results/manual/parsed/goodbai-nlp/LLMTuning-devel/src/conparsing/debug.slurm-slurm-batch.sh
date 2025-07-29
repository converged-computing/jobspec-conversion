#!/bin/bash
#SBATCH --job-name=xfbai-Conparsing
#SBATCH --output=logs/run-job%j.out
#SBATCH --error=logs/run-job%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --constraint=ntasks-per-node=64
#SBATCH --nodelist=wxhd10

hostname
echo $CUDA_VISIBLE_DEVICES
nvidia-smi
module load Anaconda cuda-11.7 gcc-9.3.0
source activate py3.10torch2.0
cd $SLURM_SUBMIT_DIR
echo ${SLURM_SUBMIT_DIR}
bash xxx.sh				#执行用户程序
