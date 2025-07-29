#!/bin/bash
#SBATCH --job-name=Python
#SBATCH --account=fc_cosi
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --time=06:00:00
#SBATCH --qos=savio_normal

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

echo "Starting submit on host ${HOST}..."
echo "Loading modules..."
module load gcc/6.3.0 cmake python/3.6 blas cuda tensorflow/1.10.0-py36-pip-cpu
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
echo "Starting script"
python3 -u ToyModel2DGauss.py
echo "Done with script"
wait
