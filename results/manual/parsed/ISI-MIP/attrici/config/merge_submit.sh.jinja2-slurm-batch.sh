#!/bin/bash
#FLUX: --job-name=merge
#FLUX: -n=64
#FLUX: --queue=priority
#FLUX: -t=85800
#FLUX: --urgency=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:{{s.conda_path}}/lib/libfabric/libfabric.so'
export FI_PROVIDER_PATH='{{s.conda_path}}/lib/libfabric/prov'
export I_MPI_FABRICS='shm:ofi # shm:dapl not applicable for libfabric'
export I_MPI_PMI_LIBRARY='/p/system/slurm/lib/libpmi.so'
export SUBMITTED='1'

module purge
module load brotli/1.0.2
module load anaconda/5.0.0_py3
module load compiler/gnu/7.3.0
module load intel/2019.4
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:{{s.conda_path}}/lib/libfabric/libfabric.so
export FI_PROVIDER_PATH={{s.conda_path}}/lib/libfabric/prov
export I_MPI_FABRICS=shm:ofi # shm:dapl not applicable for libfabric
unset I_MPI_DAPL_UD
unset I_MPI_DAPL_UD_PROVIDER
export I_MPI_PMI_LIBRARY=/p/system/slurm/lib/libpmi.so
export SUBMITTED=1
error_note() {
  echo "Ups. Something went wrong."
  exit
}
trap error_note SIGTERM
srun -n $SLURM_NTASKS {{s.conda_path}}/bin/python -u merge_parallel.py
