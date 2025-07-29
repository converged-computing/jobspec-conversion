#!/bin/bash
#SBATCH --job-name=merge
#SBATCH --account=isipedia
#SBATCH --output={{s.log_dir}}/%x.out
#SBATCH --error={{s.log_dir}}/%x.err
#SBATCH --mail-user={{s.user}}@pik-potsdam.de
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=64
#SBATCH --cpus-per-task=1
#SBATCH --time=23:50:00
#SBATCH --qos=priority

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
