#!/bin/bash
#SBATCH --job-name=ppo_eval_num_kilobots
#SBATCH --account=project00672
#SBATCH --output=/home/yy05vipo/git/kb_learning/experiments/npmpi_ppo/l_%j.stdout
#SBATCH --error=/home/yy05vipo/git/kb_learning/experiments/npmpi_ppo/l_%j.stderr
#SBATCH --nodes=1
#SBATCH --ntasks=9
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=1000
#SBATCH --time=06:00:00
#SBATCH --chdir=/home/yy05vipo/git/kb_learning/experiments

module purge
module load gcc/4.9.4 openmpi/gcc/2.1.2 python/3.6.2 intel/2018u1 boost/1.61
source /home/yy05vipo/.virtenvs/dme/bin/activate
cd /home/yy05vipo/git/kb_learning/experiments
srun hostname > $SLURM_JOB_ID.hostfile
hostfileconv $SLURM_JOB_ID.hostfile -1
job_stream --hostfile $SLURM_JOB_ID.hostfile.converted -- python ppo/ppo.py -c ppo/ppo.yml -e eval_num_kilobots
rm $SLURM_JOB_ID.hostfile
rm $SLURM_JOB_ID.hostfile.converted
