#!/bin/bash
#FLUX: --job-name={{jobname}}
#FLUX: -c=2
#FLUX: --queue=priority
#FLUX: -t=604200
#FLUX: --priority=16

export CXX='g++'
export I_MPI_PMI_LIBRARY='/p/system/slurm/lib/libpmi.so'
export OMP_PROC_BIND='true # make sure our threads stick to cores'
export OMP_NUM_THREADS='2  # matches how many cpus-per-task we asked for'
export SUBMITTED='1'
export THEANO_FLAGS='base_compiledir=$compiledir'

module purge
module load compiler/gnu/7.3.0
export CXX=g++
unset I_MPI_DAPL_UD
unset I_MPI_DAPL_UD_PROVIDER
export I_MPI_PMI_LIBRARY=/p/system/slurm/lib/libpmi.so
export OMP_PROC_BIND=true # make sure our threads stick to cores
export OMP_NUM_THREADS=2  # matches how many cpus-per-task we asked for
export SUBMITTED=1
compiledir=/tmp/{{s.user}}/theano/$SLURM_ARRAY_TASK_ID
mkdir -p $compiledir
export THEANO_FLAGS=base_compiledir=$compiledir
cleanup() {
  rm -r $compiledir
  exit
}
trap cleanup SIGTERM
srun -n $SLURM_NTASKS {{s.conda_path}}/bin/python -u run_estimation.py
cleanup
echo "Finished run."
