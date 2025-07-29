#!/bin/bash
#SBATCH --output=./slurm_out/slurm_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --mem=4G
#SBATCH --partition=p100

JOB_ID=${SLURM_JOB_ID}
echo $JOB_ID
python main.py --method $1 --job_id $JOB_ID --pgd_eps $2 --pgd_itr $3 --lambbda $4
