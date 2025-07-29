#!/bin/bash
#SBATCH --job-name=rjx_job
#SBATCH --output=./rjx_job_ouput.txt
#SBATCH --error=./rjx_job_error.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --time=3-00:00:00
#SBATCH --partition=trustlab

bash auto_sum.sh
