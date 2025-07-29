#!/bin/bash
#SBATCH --job-name=Python
#SBATCH --account=fc_cosi
#SBATCH --mail-user=harrisoncostantino@berkeley.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --time=3-00:00:00
#SBATCH --qos=savio_normal

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
echo "Starting analysis on host ${HOSTNAME} with job ID ${SLURM_JOB_ID}..."
echo "Loading modules..."
module purge
module load gcc/4.8.5 cmake python/3.6 tensorflow/1.12.0-py36-pip-gpu blas
echo "Starting execution..."
python3 -u PairIdentification.py -f PairIdentification.p1.sim.gz -m 1300
echo "Waiting for all processes to end..."
wait
