#!/bin/bash
#FLUX: --job-name=blank-car-4097
#FLUX: -N=8
#FLUX: --queue=mpp3_batch
#FLUX: -t=10800
#FLUX: --urgency=16

export LANG='C'
export LC_ALL='C'
export OMP_NUM_THREADS='$SLURM_NTASKS_PER_NODE'

module load slurm_setup
source /etc/profile.d/modules.sh
module purge
module load admin lrz tempdir
module load gcc #requirement: tempdir
module load spack
module load intel       #requirement: spack
module load mpi.intel   #requirement: intel
module load mkl
module load gsl     #requires intel/19.1.0
module load matlab   #extracting the Inference output needs this!
module list
echo "Using this mpicc:"
which mpicc
export LANG=C
export LC_ALL=C
export OMP_NUM_THREADS=$SLURM_NTASKS_PER_NODE
echo "In the directory: $PWD"
echo "Running program on $SLURM_NNODES nodes with $SLURM_CPUS_PER_TASK tasks, each with $SLURM_CPUS_PER_TASK cores."
echo "OMP_NUM_THREADS: $OMP_NUM_THREADS"
mpirun -env TORC_WORKERS 1 ./engine_tmcmc
./extractInferenceOutput.sh
