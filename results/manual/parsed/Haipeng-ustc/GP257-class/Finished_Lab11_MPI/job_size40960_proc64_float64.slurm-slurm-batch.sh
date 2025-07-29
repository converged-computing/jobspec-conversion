#!/bin/bash
#SBATCH --output=job_size40960_proc64_float64.%N.%j.out
#SBATCH --error=job_size40960_proc64_float64.%N.%j.err
#SBATCH --nodes=4
#SBATCH --ntasks=64
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --partition=serc
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=16

MATSIZE=40960
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
