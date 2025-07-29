#!/bin/bash
#SBATCH --job-name={{jobname}}
#SBATCH --account=isipedia
#SBATCH --output={{s.log_dir}}/%x_%a.out
#SBATCH --error={{s.log_dir}}/%x_%a.err
#SBATCH --mail-user={{s.user}}@pik-potsdam.de
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --time=6-23:50:00
#SBATCH --qos=priority
#SBATCH --array=0-{{s.njobarray-1}}

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
