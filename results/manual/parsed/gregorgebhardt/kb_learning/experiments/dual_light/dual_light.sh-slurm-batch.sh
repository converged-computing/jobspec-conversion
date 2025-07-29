#!/bin/bash
#SBATCH --job-name=dual_light
#SBATCH --account=project00672
#SBATCH --output=/home/yy05vipo/git/kb_learning/experiments/fixed_weight_complex/l_%j.stdout
#SBATCH --error=/home/yy05vipo/git/kb_learning/experiments/fixed_weight_complex/l_%j.stderr
#SBATCH --nodes=1
#SBATCH --ntasks=3
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=1000
#SBATCH --time=03:00:00
#SBATCH --constraint=avx2
#SBATCH --chdir=/home/yy05vipo/git/kb_learning/experiments

source /home/yy05vipo/.virtenvs/gym/bin/activate
cd /home/yy05vipo/git/kb_learning/experiments
srun hostname > $SLURM_JOB_ID.hostfile
hostfileconv $SLURM_JOB_ID.hostfile -1
job_stream --hostfile $SLURM_JOB_ID.hostfile.converted -- python dual_light/dual_light.py -c dual_light/dual_light.yml --log_level INFO -e test -o
