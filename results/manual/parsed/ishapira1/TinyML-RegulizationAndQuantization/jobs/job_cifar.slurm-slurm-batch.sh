#!/bin/bash
#SBATCH --output=/n/home12/ishapira/git_connection/TinyML-RegulizationAndQuantization/jobs/cifar_slurm_logs/cifar0005_{TYPE}_{PARAM}_%j.out
#SBATCH --error=/n/home12/ishapira/git_connection/TinyML-RegulizationAndQuantization/jobs/cifar_slurm_logs/cifar0005_{TYPE}_{PARAM}_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=80000
#SBATCH --time=10:00:00

module load Anaconda2/2019.10-fasrc01
source activate itai_ml_env
cd /n/home12/ishapira/git_connection/TinyML-RegulizationAndQuantization/jobs
python3 CIFAR_job.py --regularization_type {TYPE} --regularization_param {PARAM}
nvidia-smi > /n/home12/ishapira/git_connection/TinyML-RegulizationAndQuantization/jobs/gpu.txt
conda deactivate
