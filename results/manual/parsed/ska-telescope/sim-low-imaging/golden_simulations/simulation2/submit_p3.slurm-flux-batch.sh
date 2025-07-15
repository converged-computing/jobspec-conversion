#!/bin/bash
#FLUX: --job-name=scruptious-bicycle-0814
#FLUX: -N=16
#FLUX: -n=32
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
        ssh $host dask-scheduler --port=8786 --local-directory /mnt/storage-ssd/tim/dask-workspace &
        sleep 5
    fi
    echo "run dask-worker"
    ssh $host dask-worker --nprocs 1 --nthreads 1 --memory-limit 100GB \
        --interface ib0 --local-directory /mnt/storage-ssd/tim/dask-workspace $scheduler:8786  &
        sleep 1
    hostIndex="1"
done
echo "Scheduler and workers now running"
export ARL_DASK_SCHEDULER=${scheduler}:8786
echo "Scheduler is running at ${scheduler}"
cp ../../clean_ms.py .
CMD="python ../../clean_ms.py --ngroup 1 --nworkers 0 --weighting uniform --context wprojection \
--mode pipeline --niter 1000 --nmajor 3 --fractional_threshold 0.2 --threshold 0.01 --nmoment 1 \
--amplitude_loss 0.25 --deconvolve_facets 8 --deconvolve_overlap 32 \
--msname /mnt/storage-ssd/tim/Code/sim-low-imaging/data/EoR0_20deg_24.MS \
--time_coal 0.0 --frequency_coal 0.0 --memory 128 --channels 131 138 --window_shape no_edge --window_edge 16 \
--use_serial_invert False --use_serial_predict False --plot False --fov 1.4 --single False | tee clean_ms.log"
echo "About to execute $CMD"
eval $CMD
