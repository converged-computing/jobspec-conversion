#!/bin/bash
#SBATCH --job-name=mpi4py_pybind11
#SBATCH --account=b171
#SBATCH --output=./%N.%j.%a.out
#SBATCH --error=./%N.%j.%a.err
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --time=00:05:00
#SBATCH --partition=skylake
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=2

export OMP_PLACES='cores'
export OMP_PROC_BIND='true'
export OMP_DISPLAY_ENV='true'
export OMP_SCHEDULE='static'

module purge
module load userspace/all 
module load gcc/7.2.0
spack load -r py-mpi4py
spack load -r py-numpy
module load openmpi/gcc72/ofed/3.1.3
echo “Running on: $SLURM_NODELIST”
cd /home/glatu/test_pybind_mpi/build
ulimit -a
export OMP_PLACES=cores
export OMP_PROC_BIND=true
export OMP_DISPLAY_ENV=true
export OMP_SCHEDULE=static
mpirun -report-bindings --map-by socket:PE=1 -bind-to core python3 -m mpi4py helloWorld.py
