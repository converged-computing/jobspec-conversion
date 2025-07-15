#!/bin/bash
#FLUX: --job-name=expressive-chair-2464
#FLUX: -N=9
#FLUX: --priority=16

export MKLROOT='/opt/intel/compilers_and_libraries_2019.3.199/linux/mkl'
export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/opt/intel/compilers_and_libraries_2019.3.199/linux/mkl/lib/intel64'
export PYTHONPATH='$PYTHONPATH:$PWD/GPTune/'
export PYTHONWARNINGS='ignore'
export PATH='/global/homes/h/hrluo/.local/cori/3.7-anaconda-2019.10/bin:$PATH" '

salloc -N 9 -C haswell -q interactive -t 04:00:00
module load python/3.7-anaconda-2019.10
module unload cray-mpich
module unload cmake
module load cmake/3.14.4
module unload PrgEnv-intel
module load PrgEnv-gnu
export MKLROOT=/opt/intel/compilers_and_libraries_2019.3.199/linux/mkl
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/intel/compilers_and_libraries_2019.3.199/linux/mkl/lib/intel64
BLAS_LIB="${MKLROOT}/lib/intel64/libmkl_gf_lp64.so;${MKLROOT}/lib/intel64/libmkl_gnu_thread.so;${MKLROOT}/lib/intel64/libmkl_core.so;-lgomp"
LAPACK_LIB="${MKLROOT}/lib/intel64/libmkl_gf_lp64.so;${MKLROOT}/lib/intel64/libmkl_gnu_thread.so;${MKLROOT}/lib/intel64/libmkl_core.so;-lgomp"
module load openmpi/4.0.1
export PYTHONPATH=~/.local/cori/3.7-anaconda-2019.10/lib/python3.7/site-packages
export PYTHONPATH=$PYTHONPATH:$PWD/autotune/
export PYTHONPATH=$PYTHONPATH:$PWD/scikit-optimize/
export PYTHONPATH=$PYTHONPATH:$PWD/mpi4py/
export PYTHONPATH=$PYTHONPATH:$PWD/GPTune/
export PYTHONWARNINGS=ignore
CCC=mpicc
CCCPP=mpicxx
FTN=mpif90
cd ~/GPTune/examples/minimalcGP/
pip install -r requirements.txt --user
export PATH="/global/homes/h/hrluo/.local/cori/3.7-anaconda-2019.10/bin:$PATH" 
echo 'cGP superLU experiment environment setup finished...'
sh run_matrix.sh SiNa
.bin
echo 'cGP superLU experiment done!'
