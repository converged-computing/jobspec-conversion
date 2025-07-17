#!/bin/bash
#FLUX: --job-name=CASE3
#FLUX: -N=16
#FLUX: -n=33
#FLUX: --queue=compute
#FLUX: -t=86399
#FLUX: --urgency=16

export PYTHONPATH='$PYTHONPATH:$ARL'
export ARL_DASK_SCHEDULER='${scheduler}:8786'

module purge                               # Removes all modules still loaded
export PYTHONPATH=$PYTHONPATH:$ARL
echo "PYTHONPATH is ${PYTHONPATH}"
echo -e "Running python: `which python`"
echo -e "Running dask-scheduler: `which dask-scheduler`"
cd $SLURM_SUBMIT_DIR
echo -e "Changed directory to `pwd`.\n"
JOBID=${SLURM_JOB_ID}
echo ${SLURM_JOB_NODELIST}
scontrol show hostnames $SLURM_JOB_NODELIST | uniq > hostfile.$JOBID
scheduler=$(head -1 hostfile.$JOBID)
hostIndex=0
for host in `cat hostfile.$JOBID`; do
    echo "Working on $host ...."
    if [ "$hostIndex" = "0" ]; then
        echo "run dask-scheduler"
        ssh $host dask-scheduler --port=8786 &
        sleep 5
    fi
    echo "run dask-worker"
    ssh $host dask-worker --host ${host} --nprocs 2 --nthreads 1  \
    --memory-limit 16GB --local-directory /mnt/storage-ssd/tim/dask-workspace/${host} $scheduler:8786  &
        sleep 1
    hostIndex="1"
done
echo "Scheduler and workers now running"
export ARL_DASK_SCHEDULER=${scheduler}:8786
echo "Scheduler is running at ${scheduler}"
CMD="python ../../../pointing_simulation_distributed.py --context s3sky --frequency 12.179e9 --rmax 1e5 --flux_limit 0.003 \
 --show True \
--seed 18051955  --pbtype MID_FEKO_Ku --memory 32  --integration_time 10 --use_agg True --time_series wind --time_chunk \
180 --time_range -0.05 0.05 --shared_directory ../../../../shared | tee pointing_simulation.log"
echo "About to execute $CMD"
eval $CMD
