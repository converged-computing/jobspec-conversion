#!/bin/bash
#FLUX: --job-name=PMDA_BM
#FLUX: -N=6
#FLUX: --queue=compute
#FLUX: -t=28800
#FLUX: --urgency=16

bash /home/sfan19/.bashrc
echo $SLURM_JOB_ID
echo $USER
SCHEDULER=`hostname`
echo SCHEDULER: $SCHEDULER
dask-scheduler --port=8786 &
sleep 5
hostnodes=`scontrol show hostnames $SLURM_NODELIST`
echo $hostnodes
for host in $hostnodes; do
    echo "Working on $host ...."
    ssh $host dask-worker --nprocs 12 --nthreads 1 $SCHEDULER:8786 &
    sleep 1
done
python benchmark_rms_distr.py /scratch/$USER/$SLURM_JOB_ID $SCHEDULER:8786
