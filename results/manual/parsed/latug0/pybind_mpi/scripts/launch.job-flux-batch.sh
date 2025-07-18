#!/bin/bash
#FLUX: --job-name=mpi4py_pybind11
#FLUX: -N=4
#FLUX: -c=16
#FLUX: --exclusive
#FLUX: --queue=skylake
#FLUX: -t=300
#FLUX: --urgency=16

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
