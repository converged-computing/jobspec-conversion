#!/bin/bash
#SBATCH --job-name=hist_home
#SBATCH --output=%j_hist.out
#SBATCH --error=%j_hist.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=06:00:00
#SBATCH --partition=short-serial
#SBATCH --array=1-101

module add jaspy
cd /home/users/tommatthews/Homeostasis/
source /home/users/tommatthews/Homeostasis/xheat/bin/activate
python compute_hist.py ${SLURM_ARRAY_TASK_ID}
