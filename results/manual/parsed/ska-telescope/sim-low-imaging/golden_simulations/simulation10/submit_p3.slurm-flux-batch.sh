#!/bin/bash
#FLUX: --job-name=IMAGING
#FLUX: -N=16
#FLUX: -n=16
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
dask-ssh --nthreads 4 --memory-limit 100GB --nprocs 1 --hostfile hostfile.$JOBID --log-directory $SLURM_SUBMIT_DIR &
sleep 5
echo "Scheduler and workers now running"
export ARL_DASK_SCHEDULER=${scheduler}:8786
echo "Scheduler is running at ${scheduler}"
cp ../../clean_ms.py .
CMD="python ./clean_ms.py --ngroup 1 --nworkers 0 --weighting natural --context wprojection \
--mode invert --amplitude_loss 0.25 --channels 131 147 \
--msname /alaska/tim/Code/sim-low-imaging/data/GLEAM_A-team_EoR0_no_errors.ms \
--use_serial_invert True --use_serial_predict True --plot False --fov 2.0 --single False | tee clean_ms.log"
echo "About to execute $CMD"
eval $CMD
