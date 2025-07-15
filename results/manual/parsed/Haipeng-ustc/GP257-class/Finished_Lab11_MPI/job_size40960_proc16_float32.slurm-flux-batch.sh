#!/bin/bash
#FLUX: --job-name=goodbye-plant-0994
#FLUX: -N=2
#FLUX: -n=16
#FLUX: --exclusive
#FLUX: --queue=serc
#FLUX: -t=1800
#FLUX: --priority=16

MATSIZE=40960
echo;
echo "Starting sbatch script";
echo "DATE: $(date), NTASKS: $SLURM_NTASKS, NNODES: $SLURM_NNODES";
echo;
echo "module load py-mpi4py/3.1.3_py39";
module load py-mpi4py/3.1.3_py39;
echo "python --version";
python --version 2>&1;
MY_MPI_MATMUL="matmult_mpi_float32.py"
echo;
echo "Running MatMul";
echo;
echo "mpiexec -n $SLURM_NTASKS python $MY_MPI_MATMUL $MATSIZE";
mpiexec -n $SLURM_NTASKS python $MY_MPI_MATMUL $MATSIZE;
echo;
echo;
echo "Done...";
echo "DATE: $(date), NTASKS: $SLURM_NTASKS, NNODES: $SLURM_NNODES";
