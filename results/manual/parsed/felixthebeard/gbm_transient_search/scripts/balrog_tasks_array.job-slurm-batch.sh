#!/bin/bash
#FLUX: --job-name=balrog_loc
#FLUX: -t=14400
#FLUX: --urgency=16

export GBMDATA='/ptmp/fkunzwei/gbm_data'
export LD_LIBRARY_PATH='$HOME/sw/MultiNest/lib'
export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

module purge
export GBMDATA=/ptmp/fkunzwei/gbm_data
export LD_LIBRARY_PATH=$HOME/sw/MultiNest/lib
module load intel/19.1.3 impi/2019.9 anaconda/3/2020.02 mpi4py/3.0.3
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
TRIGGER_INFO_FILE=$1
srun python ${HOME}/scripts/bkg_pipe/run_balrog.py --multi_trigger_info ${TRIGGER_INFO_FILE} --subtasks 9 --index $SLURM_ARRAY_TASK_ID
wait
exit 0
