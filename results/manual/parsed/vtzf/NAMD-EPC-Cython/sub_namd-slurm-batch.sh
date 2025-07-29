#!/bin/bash
#SBATCH --job-name=namd-tyy
#SBATCH --output=namd_%j.log
#SBATCH --error=namd_%j.err
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-06:00:00
#SBATCH --partition=sugon
#SBATCH --constraint=ntasks-per-node=16

export HDF5_USE_FILE_LOCKING='FALSE'
export OMP_NUM_THREADS='1'

ulimit -s unlimited
export HDF5_USE_FILE_LOCKING="FALSE"
export OMP_NUM_THREADS=1
echo "============================================================"
module list
env | grep "MKLROOT="
echo "============================================================"
echo "Job ID: $SLURM_JOB_NAME"
echo "Job name: $SLURM_JOB_NAME"
echo "Number of nodes: $SLURM_JOB_NUM_NODES"
echo "Number of processors: $SLURM_NTASKS"
echo "Task is running on the following nodes:"
echo $SLURM_JOB_NODELIST
echo "OMP_NUM_THREADS = $SLURM_CPUS_PER_TASK"
echo "============================================================"
echo
srun --mpi=pmi2 namd-epc
