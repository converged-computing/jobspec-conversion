#!/bin/bash
#SBATCH --job-name=ppo_relative_w
#SBATCH --account=project00720
#SBATCH --output=/home/yy05vipo/git/kb_learning/experiments/npmpi_ppo/l_%j.stdout
#SBATCH --error=/home/yy05vipo/git/kb_learning/experiments/npmpi_ppo/l_%j.stderr
#SBATCH --nodes=1
#SBATCH --ntasks=9
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=1000
#SBATCH --time=06:00:00
#SBATCH --chdir=/home/yy05vipo/git/kb_learning/experiments

export OMP_NUM_THREADS='8'

module purge
module load gcc openmpi/gcc/2.1
export OMP_NUM_THREADS=8
. /home/yy05vipo/bin/miniconda3/etc/profile.d/conda.sh
conda activate dme
cd /home/yy05vipo/git/kb_learning/experiments
srun hostname > $SLURM_JOB_ID.hostfile
hostfileconv $SLURM_JOB_ID.hostfile -1
job_stream --hostfile $SLURM_JOB_ID.hostfile.converted -- python ppo/ppo.py -c ppo/ppo.yml -e eval_relative_env
rm $SLURM_JOB_ID.hostfile
rm $SLURM_JOB_ID.hostfile.converted
