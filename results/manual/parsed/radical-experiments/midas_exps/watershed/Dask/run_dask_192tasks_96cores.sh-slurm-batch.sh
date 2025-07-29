#!/bin/bash
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --partition=compute

cd $SLURM_SUBMIT_DIR
rm -rf /home/willc97/dask-worker-space/*
source activate watershed_Dask
SCHEDULER=`hostname`
hostnodes=`scontrol show hostnames $SLURM_NODELIST`
iteration=$iteration
scheduler="$SCHEDULER:8786"
tasks=192
images=4096
path='/oasis/projects/nsf/unc100/willc97'
output="dask_192tasks_96cores_${iteration}"
echo iteration  : $iteration
echo scheduler  : $scheduler 
echo tasks      : $tasks
echo nodes      : 4
echo images     : $images
echo path       : $path
echo output     : $output
echo SCHEDULER  : $SCHEDULER
echo hostnodes  : $hostnodes
dask-ssh --nprocs 24 --nthreads 1 --log-directory /oasis/projects/nsf/unc100/willc97/midas/watershed/Dask/dask_logs $hostnodes &
sleep 10
python /oasis/projects/nsf/unc100/willc97/midas/watershed/Dask/watershed_dask.py $scheduler $tasks $images $path -o $output -r $output
