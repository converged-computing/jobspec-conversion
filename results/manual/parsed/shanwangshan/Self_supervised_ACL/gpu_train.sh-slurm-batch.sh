#!/bin/bash
#SBATCH --job-name=ACL
#SBATCH --account=asignal
#SBATCH --output=./err_out/out_task_number_%A_%a.txt
#SBATCH --error=./err_out/err_task_number_%A_%a.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --gres=gpu:a100:1
#SBATCH --time=1-12:00:00
#SBATCH --partition=gpusmall
#SBATCH --array=1-10

module load pytorch/1.11
echo $SLURM_ARRAY_TASK_ID
python main_train.py -p config/params_unsupervised_cl.yaml #&> logs/output_unsup.out
