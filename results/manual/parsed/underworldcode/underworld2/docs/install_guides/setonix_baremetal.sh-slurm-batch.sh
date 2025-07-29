#!/bin/bash
#FLUX: --job-name=bobthejob
#FLUX: -n=3
#FLUX: -t=1200
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export OPT_DIR='/software/projects/pawsey0407/setonix/'
export PYTHONPATH='$PETSC_DIR/lib:$PYTHONPATH'
export PETSC_DIR='$OPT_DIR/petsc-3.19.0'
export model='mymod.py'

export OMP_NUM_THREADS=1
module load python/3.9.15 py-mpi4py/3.1.2-py3.9.15 py-numpy/1.20.3 py-h5py/3.4.0 py-cython/0.29.24 cmake/3.21.4
export OPT_DIR=/software/projects/pawsey0407/setonix/
export PYTHONPATH=$OPT_DIR/py39/lib/python3.9/site-packages/:$PYTHONPATH
export PYTHONPATH=$OPT_DIR/underworld/2.14.2/lib/python3.9/site-packages:$PYTHONPATH
export PETSC_DIR=$OPT_DIR/petsc-3.19.0
export PYTHONPATH=$PETSC_DIR/lib:$PYTHONPATH
export model="mymod.py"
srun -n ${SLURM_NTASKS} python3 $model
