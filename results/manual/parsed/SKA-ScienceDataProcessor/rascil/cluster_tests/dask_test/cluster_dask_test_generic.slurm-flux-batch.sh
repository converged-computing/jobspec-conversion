#!/bin/bash
#FLUX: --job-name=CLUSTER_TEST
#FLUX: -N=8
#FLUX: -n=16
#FLUX: --exclusive
#FLUX: --queue=hpc
#FLUX: -t=3600
#FLUX: --urgency=16

export RASCIL='$rascildir '
export PYTHONPATH='${arldir}'
export RASCIL_DASK_SCHEDULER='${scheduler}:${port}'

module purge                               # Removes all modules still loaded
module load miniconda3-4.6.14-gcc-8.3.0-wv6owry
source /home/${USER}/.bashrc
conda activate /mnt/storage-ssd/${USER}/anaconda
echo -e "Running python: `which python`"
echo -e "Running dask-scheduler: `which dask-scheduler`"
cd $SLURM_SUBMIT_DIR
echo -e "Changed directory to `pwd`.\n"
JOBID=${SLURM_JOB_ID}
echo ${SLURM_JOB_NODELIST}
mkdir local
scheduler=$(hostname)
port=8786
outfile=${SLURM_JOB_NAME}_${SLURM_JOB_ID}_scheduler.out
dask-scheduler --host $scheduler --port $port &
echo dask-scheduler started on ${scheduler}:${port}
sleep 5
srun -o %x_%j_worker_%n.out dask-worker --nprocs 16 --nthreads 1 --interface ib0 --memory-limit 100GB --local-directory ${SLURM_SUBMIT_DIR}/local ${scheduler}:${port} &
echo dask-worker started on all nodes
sleep 5
rascildir=/mnt/storage-ssd/${USER}/work/rascil
export RASCIL=$rascildir 
export PYTHONPATH=${arldir}
export RASCIL_DASK_SCHEDULER=${scheduler}:${port}
sleep 1
echo "Scheduler and workers now running"
echo "Scheduler is running at ${scheduler}"
echo "run dask-worker"
python cluster_dask_test.py ${scheduler}:8786 | tee cluster_dask_test.log
