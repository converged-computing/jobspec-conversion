#!/bin/bash
#FLUX: --job-name=dask-cluster
#FLUX: --exclusive
#FLUX: --queue=cpu_med
#FLUX: -t=3600
#FLUX: --urgency=16

NPROC=4                          # Total number of processes
NPROCPNODE=4                     # Number of processes per node
NWORKERPNODE=4                  # Number of Dask workers per node
SCHEFILE=scheduler.json
echo launching Scheduler 
srun --cpu-bind=verbose --ntasks=1 --nodes=1 -l \
    --output=scheduler.log \
    dask-scheduler \
    --interface ib0 \
    --scheduler-file=$SCHEFILE   &
while ! [ -f $SCHEFILE ]; do
    sleep 1
    echo -n .
done
echo Connect Master Client  
`which python` client.py &
client_pid=$!
echo Scheduler booted, Client connected, launching workers 
srun  --cpu-bind=verbose  -l \
     --output=worker-%t.log \
     dask-worker \
     --interface ib0 \
     --local-directory /tmp \
     --nprocs $NWORKERPNODE \
     --scheduler-file=${SCHEFILE} &
echo Running Simulation 
srun  --ntasks=$NPROC --ntasks-per-node=$NPROCPNODE  -l ./simulation  &
wait $client_pid
