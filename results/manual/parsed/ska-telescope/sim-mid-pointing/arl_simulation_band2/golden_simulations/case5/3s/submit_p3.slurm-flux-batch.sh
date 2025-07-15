#!/bin/bash
#FLUX: --job-name=fat-avocado-2059
#FLUX: -N=8
#FLUX: -n=129
#FLUX: -t=43200
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
cp ibhostfile hostfile.$JOBID
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
    ssh $host dask-worker --host ${host} --nprocs 16 --nthreads 1  \
    --memory-limit 16GB --local-directory /mnt/storage-ssd/tim/dask-workspace/${host} $scheduler:8786  &
        sleep 1
    hostIndex="1"
done
echo "Scheduler and workers now running"
export ARL_DASK_SCHEDULER=${scheduler}:8786
echo "Scheduler is running at ${scheduler}"
CMD="python  ../../../../pointing_simulation_distributed.py --context s3sky --rmax 1e5 --flux_limit 0.3
--show True \
--seed 18051955  --pbtype MID_GRASP --memory 32  --integration_time 3 --use_agg True --time_series wind --time_chunk \
1800 --reference_pointing True --shared_directory ../../../../shared | tee pointing_simulation.log"
echo "About to execute $CMD"
eval $CMD
