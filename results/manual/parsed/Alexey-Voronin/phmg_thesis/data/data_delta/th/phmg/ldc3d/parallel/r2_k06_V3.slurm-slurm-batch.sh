#!/bin/bash
#SBATCH --job-name=th_new/hmg_ldc3d
#SBATCH --account=bcfx-delta-cpu
#SBATCH --nodes=32
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=246G
#SBATCH --time=02:00:00
#SBATCH --partition=cpu
#SBATCH --constraint=ntasks-per-node=6,scratch

export OMP_NUM_THREADS='1'
export GCC_PATH='/sw/spack/deltas11-2023-03/apps/linux-rhel8-x86_64/gcc-8.5.0/gcc-11.4.0-yycklku'
export OMPI_PATH='/sw/spack/deltas11-2023-03/apps/linux-rhel8-zen3/gcc-11.4.0/openmpi-4.1.6-lranp74'
export LIBSTDC='/sw/spack/deltas11-2023-03/apps/linux-rhel8-x86_64/gcc-8.5.0/gcc-11.4.0-yycklku/lib64'
export PATH='${GCC_PATH}/bin:${OMPI_PATH}/bin:${PATH}'
export LD_LIBRARY_PATH='${LIBSTDC}:${GCC_PATH}/lib:${OMPI_PATH}/lib:$LD_LIBRARY_PATH'
export FI_CXI_RX_MATCH_MODE='software '

export OMP_NUM_THREADS=1
module purge
module load gcc/11.4.0
module load openmpi/4.1.6 
source /u/avoronin1/firedrake_metis/firedrake/bin/activate
export GCC_PATH=/sw/spack/deltas11-2023-03/apps/linux-rhel8-x86_64/gcc-8.5.0/gcc-11.4.0-yycklku
export OMPI_PATH=/sw/spack/deltas11-2023-03/apps/linux-rhel8-zen3/gcc-11.4.0/openmpi-4.1.6-lranp74
export LIBSTDC=/sw/spack/deltas11-2023-03/apps/linux-rhel8-x86_64/gcc-8.5.0/gcc-11.4.0-yycklku/lib64
export PATH=${GCC_PATH}/bin:${OMPI_PATH}/bin:${PATH}
export LD_LIBRARY_PATH=${LIBSTDC}:${GCC_PATH}/lib:${OMPI_PATH}/lib:$LD_LIBRARY_PATH
export FI_CXI_RX_MATCH_MODE=software 
srun python ../solver.py 6 2 3 3 1 
