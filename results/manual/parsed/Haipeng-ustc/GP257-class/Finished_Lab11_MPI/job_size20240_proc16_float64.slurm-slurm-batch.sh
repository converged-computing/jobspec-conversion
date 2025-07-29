#!/bin/bash
#SBATCH --output=job_size20240_proc16_float64.%N.%j.out
#SBATCH --error=job_size20240_proc16_float64.%N.%j.err
#SBATCH --nodes=2
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --exclusive
#SBATCH --constraint=ntasks-per-node=8

MATSIZE=20240
echo;
echo "Starting sbatch script";
echo "DATE: $(date), NTASKS: $SLURM_NTASKS, NNODES: $SLURM_NNODES";
echo;
echo "module load py-mpi4py/3.1.3_py39";
module load py-mpi4py/3.1.3_py39;
echo "python --version";
python --version 2>&1;
MY_MPI_MATMUL="matmult_mpi_float64.py"
echo;
echo "Running MatMul";
echo;
echo "mpiexec -n $SLURM_NTASKS python $MY_MPI_MATMUL $MATSIZE";
mpiexec -n $SLURM_NTASKS python $MY_MPI_MATMUL $MATSIZE;
echo;
echo;
echo "Done...";
echo "DATE: $(date), NTASKS: $SLURM_NTASKS, NNODES: $SLURM_NNODES";
