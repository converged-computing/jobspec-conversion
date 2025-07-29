#!/bin/bash
#SBATCH --job-name=fw_dual_light
#SBATCH --account=project00720
#SBATCH --output=/home/yy05vipo/git/kb_learning/experiments/fixed_weight/l_%j.stdout
#SBATCH --error=/home/yy05vipo/git/kb_learning/experiments/fixed_weight/l_%j.stderr
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=1000
#SBATCH --time=05:00:00
#SBATCH --constraint=avx2
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
job_stream --hostfile $SLURM_JOB_ID.hostfile.converted -- python fixed_weight/fixed_weight.py -c fixed_weight/fixed_weight.yml -e eval_dual_light -o
rm $SLURM_JOB_ID.hostfile
rm $SLURM_JOB_ID.hostfile.converted
