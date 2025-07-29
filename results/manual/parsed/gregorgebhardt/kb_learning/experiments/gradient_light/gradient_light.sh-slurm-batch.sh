#!/bin/bash
#SBATCH --job-name=gl_eval_height
#SBATCH --account=project00672
#SBATCH --output=/home/yy05vipo/git/kb_learning/experiments/gradient_light/l_%j.stdout
#SBATCH --error=/home/yy05vipo/git/kb_learning/experiments/gradient_light/l_%j.stderr
#SBATCH --nodes=1
#SBATCH --ntasks=24
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=1000
#SBATCH --time=05:00:00
#SBATCH --constraint=avx2
#SBATCH --chdir=/home/yy05vipo/git/kb_learning/experiments

source /home/yy05vipo/.virtenvs/gym/bin/activate
cd /home/yy05vipo/git/kb_learning/experiments
srun hostname > $SLURM_JOB_ID.hostfile
hostfileconv $SLURM_JOB_ID.hostfile -1
job_stream --hostfile $SLURM_JOB_ID.hostfile.converted -- python gradient_light/gradient_light.py -c gradient_light/gradient_light.yml --log_level INFO -e eval_height
rm $SLURM_JOB_ID.hostfile
rm $SLURM_JOB_ID.hostfile.converted
