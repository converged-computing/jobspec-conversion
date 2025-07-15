#!/bin/bash
#FLUX: --job-name=jobs_echo
#FLUX: -N=8
#FLUX: --queue=savio2
#FLUX: -t=259200
#FLUX: --priority=16

JOBSJSON=$1
ECHO_DIR=$(pwd)
BRC_DIR=${ECHO_DIR}/brc
if [[ $ECHO_DIR != */echo ]]; then
  echo -e "${RED} Please run this script from the 'echo' directory ${NC}";
  return 0 2> /dev/null || exit 0
fi;
module load python/3.6 gcc openmpi
if [ $SLURM_JOB_NUM_NODES = 1 ]; then
  ipcluster start -n $SLURM_NTASKS &
  sleep 30 # wait until all engines have successfully started
else
  echo running this one
  ipcontroller --ip='*' --nodb &
  sleep 90
  srun ipengine &
  sleep 180
fi
echo begin execution
time ipython $BRC_DIR/run_experiment_ipyparallel.py -- --jobs-json=$JOBSJSON
exit
