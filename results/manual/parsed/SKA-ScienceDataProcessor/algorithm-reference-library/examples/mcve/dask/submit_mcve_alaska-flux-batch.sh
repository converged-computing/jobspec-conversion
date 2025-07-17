#!/bin/bash
#FLUX: --job-name=SDP_ARL
#FLUX: -N=3
#FLUX: -n=3
#FLUX: --queue=compute
#FLUX: -t=600
#FLUX: --urgency=16

export PYTHONPATH='$PYTHONPATH:$ARL'

module purge                               # Removes all modules still loaded
. $HOME/arlenv/bin/activate
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
    ssh $host dask-worker --host ${host} --nprocs 1 --nthreads 1  \
    --memory-limit 0.1 --local-directory /tmp $scheduler:8786 &
        sleep 1
    hostIndex="1"
done
echo "Scheduler and workers now running"
CMD="python ./losing_workers-loop.py ${scheduler}:8786 > losing_workers_${JOBID}.out"
echo "About to execute $CMD"
eval $CMD
archive="output_${JOBID}"
echo "Moving results to ${archive}"
mkdir ${archive}
mv "slurm-${JOBID}".out ${archive}
mv hostfile.${JOBID} ${archive}
mv dask-ssh* ${archive}
cp *.py ${archive}
cp ${0}  ${archive}
mv losing_workers_${JOBID}.out  ${archive}
