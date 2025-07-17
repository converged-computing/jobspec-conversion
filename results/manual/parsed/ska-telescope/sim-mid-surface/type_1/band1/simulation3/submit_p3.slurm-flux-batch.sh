#!/bin/bash
#FLUX: --job-name=TYPE1
#FLUX: -N=12
#FLUX: -n=29
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
    ssh $host dask-worker --interface ib0  --nprocs 2 --nthreads 4  \
    --memory-limit 50GB    --local-directory /mnt/storage-ssd/tim/dask-workspace/${host} $scheduler:8786   &
        sleep 1
    hostIndex="1"
done
echo "Scheduler and workers now running"
export ARL_DASK_SCHEDULER=${scheduler}:8786
echo "Scheduler is running at ${scheduler}"
CMD="python ../../surface_simulation_elevation.py --context singlesource --rmax 1e5 --flux_limit 0.003 \
 --show True \
--elevation_sampling 1.0 --offset_dir 0.0 1.0 \
--seed 18051955  --band B1 --pbtype MID_FEKO_B1 --memory 32  --integration_time 30 --use_agg True \
--time_chunk 30 --time_range -6 6 --shared_directory /mnt/storage-ssd/tim/Code/sim-mid-surface/shared \
--vp_directory /mnt/storage-ssd/tim/Code/sim-mid-surface/beams/interpolated/ \
| tee surface_simulation.log"
echo "About to execute $CMD"
eval $CMD
