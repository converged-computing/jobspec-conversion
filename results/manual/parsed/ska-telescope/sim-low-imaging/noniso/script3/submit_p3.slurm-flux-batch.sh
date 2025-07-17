#!/bin/bash
#FLUX: --job-name=IMAGING
#FLUX: -N=8
#FLUX: -n=8
#FLUX: --exclusive
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
    ssh $host dask-worker --nprocs 1 --nthreads 8 --interface ib0 \
    --memory-limit 256GB --local-directory /mnt/storage-ssd/tim/dask-workspace/${host} $scheduler:8786  &
        sleep 1
    hostIndex="1"
done
echo "Scheduler and workers now running"
export ARL_DASK_SCHEDULER=${scheduler}:8786
echo "Scheduler is running at ${scheduler}"
CMD="python ../clean_ms_noniso.py --ngroup 1 --nworkers 0 --weighting uniform --context wprojectwstack --nwslabs 9 \
--mode ical --niter 1000 --nmajor 5 --fractional_threshold 0.2 --threshold 0.01 \
--amplitude_loss 0.25 --deconvolve_facets 8 --deconvolve_overlap 16 --restore_facets 4 \
--msname /mnt/storage-ssd/tim/Code/sim-low-imaging/data/noniso/GLEAM_A-team_EoR1_160_MHz_iono.ms \
--time_coal 0.0 --frequency_coal 0.0 --channels 0 1 \
--use_serial_invert True --use_serial_predict True --plot False --fov 2.5 --single False | tee clean_ms.log"
eval $CMD
