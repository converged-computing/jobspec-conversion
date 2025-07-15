#!/bin/bash
#FLUX: --job-name=quirky-eagle-7852
#FLUX: -N=4
#FLUX: -n=64
#FLUX: --exclusive
#FLUX: --queue=serc
#FLUX: -t=1800
#FLUX: --urgency=16

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
