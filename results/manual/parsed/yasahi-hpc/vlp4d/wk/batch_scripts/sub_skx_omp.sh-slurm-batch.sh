#!/bin/bash
#SBATCH --job-name=omp
#SBATCH --account=TBTOK
#SBATCH --output=%j.out
#SBATCH --error=%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --time=00:30:00
#SBATCH --partition=dev
#SBATCH --constraint=ntasks-per-node=1

export OMP_NUM_THREADS='40'
export OMP_PROC_BIND='true'

source /opt/modules/default/init/bash
module switch PrgEnv-intel PrgEnv-gnu
module unload cray-libsci/18.04.1
module load intel
module load cray-fftw
export OMP_NUM_THREADS=40
export OMP_PROC_BIND=true
srun ./vlp4d.skx_omp SLD10.dat
