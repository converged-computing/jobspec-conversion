#!/bin/bash
#SBATCH --job-name=PI
#SBATCH --output=jobLog.%j.%N.out
#SBATCH --nodes=2
#SBATCH --ntasks=56
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --partition=cm2_tiny
#SBATCH --chdir=.

export LANG='C'
export LC_ALL='C'
export OMP_NUM_THREADS='1    #2 on cm2, 2 on mpp3'

module load slurm_setup
source /etc/profile.d/modules.sh
module purge
module load admin lrz tempdir
module load gcc #requirement: tempdir
module load spack
module load intel-parallel-studio   #alternative to "intel" package
module load gsl     #requires intel/19.1.0
module list
echo "Using this mpicc:"
which mpicc
export LANG=C
export LC_ALL=C
export OMP_NUM_THREADS=1    #2 on cm2, 2 on mpp3
echo "In the directory: $PWD"
echo "Running program on $SLURM_NNODES nodes with $SLURM_CPUS_PER_TASK tasks, each with $SLURM_CPUS_PER_TASK cores."
echo "OMP_NUM_THREADS: $OMP_NUM_THREADS"
mpirun -env TORC_WORKERS 1 ./engine_tmcmc
./extractInferenceOutput.sh
