#!/bin/bash
#FLUX: --job-name=dask_cluster
#FLUX: -c=36
#FLUX: -t=18000
#FLUX: --urgency=16

export OMP_NUM_THREADS='$CPUS_ON_NODE'
export MPLBACKEND='agg'
export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'

export OMP_NUM_THREADS=$CPUS_ON_NODE
export MPLBACKEND="agg"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
echo $SLURM_PROCID
srun -N 1 -n1 dask-scheduler --scheduler-file $HOME/scheduler.json &
sleep 4
for((i=2; i<=$SLURM_NNODES; i++))
do 
   echo "Starting worker..." $i
   srun -N1 -n1 dask-worker --scheduler-file $HOME/scheduler.json --nthreads 1 --nprocs 36 &
done
python crsim_multidop_testing.py /home/rjackson/scheduler.json
