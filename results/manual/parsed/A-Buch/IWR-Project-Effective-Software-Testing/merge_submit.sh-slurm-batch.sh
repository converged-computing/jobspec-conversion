#!/bin/bash
#SBATCH --job-name=merge
#SBATCH --account=isipedia
#SBATCH --output=./log/%x.out
#SBATCH --error=./log/%x.err
#SBATCH --mail-user=annabu@pik-potsdam.de
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=64
#SBATCH --cpus-per-task=1
#SBATCH --time=23:50:00
#SBATCH --qos=priority

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/lib/libfabric/libfabric.so'
export FI_PROVIDER_PATH='/lib/libfabric/prov'
export I_MPI_FABRICS='shm:ofi # shm:dapl not applicable for libfabric'
export I_MPI_PMI_LIBRARY='/p/system/slurm/lib/libpmi.so'
export SUBMITTED='1'

module purge
module load brotli/1.0.2
module load anaconda/5.0.0_py3
module load compiler/gnu/7.3.0
module load intel/2019.4
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/lib/libfabric/libfabric.so
export FI_PROVIDER_PATH=/lib/libfabric/prov
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
srun -n $SLURM_NTASKS /bin/python -u merge_parallel.py
