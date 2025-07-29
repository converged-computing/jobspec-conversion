#!/bin/bash
#SBATCH --job-name=ssp_home
#SBATCH --output=%j_ssp.out
#SBATCH --error=%j_ssp.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=06:00:00
#SBATCH --array=1-299

module add jaspy
cd /home/users/tommatthews/Homeostasis/
source /home/users/tommatthews/Homeostasis/xheat/bin/activate
python compute_ssp.py ${SLURM_ARRAY_TASK_ID}
