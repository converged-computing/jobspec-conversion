#!/bin/bash
#SBATCH --account=hpc2n2024-052
#SBATCH --output=output_%j.out
#SBATCH --error=error_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00

MYPATH=/proj/nobackup/python-hpc/<mydir-name>/HPC-python/Exercises/examples/programs/
ml purge > /dev/null 2>&1
ml GCC/12.3.0 Python/3.11.3
ml OpenMPI/4.1.5
ml SciPy-bundle/2023.07 mpi4py/3.1.4 
mpirun -np 4 python $MYPATH/integration2d_mpi.py
