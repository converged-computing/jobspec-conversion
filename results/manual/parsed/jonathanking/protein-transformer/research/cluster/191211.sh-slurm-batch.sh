#!/bin/bash
#SBATCH --job-name=name=pt-sweep
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=10g
#SBATCH --constraint=ntasks-per-node=2
#SBATCH --array=1-4

work_dir=$(pwd)
user=$(whoami)
job_dir="${user}_${SLURM_JOB_ID}.dcb.private.net"
mkdir /scr/$job_dir
cd /scr/$job_dir
rsync -a ${work_dir}/* .
date>date-$SLURM_ARRAY_TASK_ID.txt
nvidia-smi
hostname>hostname-$SLURM_ARRAY_TASK_ID.txt
date>>date-$SLURM_ARRAY_TASK_ID.txt
rsync -ra *.log *.txt ${work_dir}
