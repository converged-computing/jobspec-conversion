#!/bin/bash
#FLUX: --job-name=confused-lentil-0691
#FLUX: -t=600
#FLUX: --urgency=16

export PYTHONPATH='/home/jmansour/underworld2:/home/jmansour/underworld2/glucifer:$PYTHONPATH'
export PREFIXSTRING='`head /dev/urandom | tr -dc A-Za-z0-9 | head -c 13 ; echo ''`'
export TIME_LAUNCH_SRUN='`date +%s%N | cut -b1-13`'

scontrol show job ${SLURM_JOBID} -ddd
env
module swap PrgEnv-cray PrgEnv-gnu
module load /home/jmansour/software/cle60up05/modulefiles/petsc/3.9.4
module load python/3.6.3
module load numpy mpi4py
export PYTHONPATH=/home/jmansour/underworld2:/home/jmansour/underworld2/glucifer:$PYTHONPATH
export PREFIXSTRING=`head /dev/urandom | tr -dc A-Za-z0-9 | head -c 13 ; echo ''`
export TIME_LAUNCH_SRUN=`date +%s%N | cut -b1-13`
srun -n ${SLURM_NTASKS} bash -c "TIME_LAUNCH_PYTHON=\`date +%s%N | cut -b1-13\` python3 rt_timed.py"
