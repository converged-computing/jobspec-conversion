#!/bin/bash
#SBATCH --job-name=IMAGING
#SBATCH --account=SKA-SDP
#SBATCH --mail-user=realtimcornwell@gmail.com
#SBATCH --mail-type=FAIL,END
#SBATCH --nodes=16
#SBATCH --ntasks=32
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=50000
#SBATCH --time=23:59:59
#SBATCH --partition=compute

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
scheduler=10.60.253.22
echo "run dask-scheduler"
ssh $host dask-scheduler --port=8786 --local-directory /mnt/storage-ssd/tim/dask-workspace &
sleep 5
hostIndex=0
for host in `cat hostfile.$JOBID`; do
    echo "Working on $host ...."
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
CMD="python ../../clean_ms.py --ngroup 2 --nworkers 0 --weighting uniform --context wprojection \
--mode invert --niter 1000 --nmajor 3 --fractional_threshold 0.2 --threshold 0.01 --nmoment 1 \
--amplitude_loss 0.25 --deconvolve_facets 8 --deconvolve_overlap 32 \
--msname /mnt/storage-ssd/tim/Code/sim-low-imaging/data/EoR0_20deg_24.MS \
--time_coal 0.0 --frequency_coal 0.0 --channels 131 146 --window_shape no_edge --window_edge 16 \
--use_serial_invert True --use_serial_predict True --plot False --fov 2.0 --single False | tee clean_ms.log"
echo "About to execute $CMD"
eval $CMD
