#!/bin/bash
#FLUX: --job-name=mcstracking
#FLUX: -N=5
#FLUX: -c=2
#FLUX: --exclusive
#FLUX: --queue=debug
#FLUX: -t=1800
#FLUX: --urgency=16

export DASK_DISTRIBUTED__COMM__TIMEOUTS__CONNECT='360s'
export DASK_DISTRIBUTED__COMM__TIMEOUTS__TCP='360s'

date 
conda activate /global/common/software/m1867/python/flextrkr
ulimit -n 32000
export DASK_DISTRIBUTED__COMM__TIMEOUTS__CONNECT=360s
export DASK_DISTRIBUTED__COMM__TIMEOUTS__TCP=360s
random_str=`echo $RANDOM | md5sum | head -c 10`
scheduler_file=$SCRATCH/scheduler_${random_str}.json
dask-scheduler --scheduler-file=$scheduler_file &
srun -N 5 --ntasks-per-node=16 dask-worker \
--scheduler-file=$scheduler_file \
--memory-limit='8GB' \
--worker-class distributed.Worker \
--local-directory=/tmp &
sleep 10
cd /global/homes/f/feng045/program/PyFLEXTRKR
python ./runscripts/run_mcs_tbpf.py ./config/config_imerg_mcs_tbpf_example.yml $scheduler_file
date
