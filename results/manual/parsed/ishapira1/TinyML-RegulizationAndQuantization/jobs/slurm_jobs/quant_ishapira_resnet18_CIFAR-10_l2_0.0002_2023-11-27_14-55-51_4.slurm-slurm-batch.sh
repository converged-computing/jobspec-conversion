#!/bin/bash
#SBATCH --output=/n/home12/ishapira/git_connection/TinyML-RegulizationAndQuantization/jobs/slurm_logs/quant_ishapira_resnet18_CIFAR-10_l2_0.0002_2023-11-27_14-55-51_4_%j.out
#SBATCH --error=/n/home12/ishapira/git_connection/TinyML-RegulizationAndQuantization/jobs/slurm_logs/quant_ishapira_resnet18_CIFAR-10_l2_0.0002_2023-11-27_14-55-51_4_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=80000
#SBATCH --time=10:00:00

module load Anaconda2/2019.10-fasrc01
source activate itai_ml_env
cd /n/home12/ishapira/git_connection/TinyML-RegulizationAndQuantization/jobs
python3 quantizer_job.py --path ../results/ishapira_resnet18_CIFAR-10_l2_0.0002_2023-11-27_14-55-51 --bit_width 4
nvidia-smi > /n/home12/ishapira/git_connection/TinyML-RegulizationAndQuantization/jobs/gpu.txt
conda deactivate
