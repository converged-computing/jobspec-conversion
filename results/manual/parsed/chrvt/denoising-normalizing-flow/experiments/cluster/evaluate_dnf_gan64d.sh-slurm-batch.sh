#!/bin/bash
#SBATCH --job-name=dnf_gan64d_eval
#SBATCH --mail-user=<horvat@pyl.unibe.ch>
#SBATCH --mail-type=fail,end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:gtx1080ti:1
#SBATCH --mem=32G
#SBATCH --time=01:00:00
#SBATCH --qos=job_gpu
#SBATCH --array=1-3

cd /storage/homefs/ch19g182/Python/Denoising-Normalizing-Flow-master/experiments
nvcc --version
nvidia-smi
python evaluate.py -c configs/evaluate_dnf_gan64d.config -i ${SLURM_ARRAY_TASK_ID}
