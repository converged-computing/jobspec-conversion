#!/bin/bash
#SBATCH --job-name=weight_bw
#SBATCH --account=project00672
#SBATCH --output=/home/yy05vipo/git/kb_learning/experiments/sampled_weight/l_%j.stdout
#SBATCH --error=/home/yy05vipo/git/kb_learning/experiments/sampled_weight/l_%j.stderr
#SBATCH --nodes=1
#SBATCH --ntasks=6
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=1000
#SBATCH --time=04:00:00
#SBATCH --constraint=avx2
#SBATCH --chdir=/home/yy05vipo/git/kb_learning/experiments

source /home/yy05vipo/.virtenvs/gym/bin/activate
cd /home/yy05vipo/git/kb_learning/experiments
srun hostname > $SLURM_JOB_ID.hostfile
hostfileconv $SLURM_JOB_ID.hostfile -1
job_stream --hostfile $SLURM_JOB_ID.hostfile.converted -- python sampled_weight/sampled_weight.py -c sampled_weight/sampled_weight.yml --log_level INFO -e weight_bw
rm $SLURM_JOB_ID.hostfile
rm $SLURM_JOB_ID.hostfile.converted
