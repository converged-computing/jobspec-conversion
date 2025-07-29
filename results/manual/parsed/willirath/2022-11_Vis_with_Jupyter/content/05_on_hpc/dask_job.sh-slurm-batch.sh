#!/bin/bash
#FLUX: --job-name=dask_job
#FLUX: -n=102
#FLUX: -c=10
#FLUX: --queue=cluster
#FLUX: -t=7200
#FLUX: --urgency=16

module load singularity/3.5.2
CONTAINER_FILE="pangeo-notebook_2022.07.27.sif"
srun --ntasks=1 -N1 --exclusive singularity run -B /sfs -B /gxfs_work1 -B $PWD:/work --pwd /work $CONTAINER_FILE bash -c \
        ". /srv/conda/etc/profile.d/conda.sh && conda activate base \
        && jupyter-lab --ip='0.0.0.0'" &
srun --ntasks=1 -N1 --exclusive singularity run -B /sfs -B /gxfs_work1 -B $PWD:/work --pwd /work $CONTAINER_FILE bash -c \
        ". /srv/conda/etc/profile.d/conda.sh && conda activate base \
        && dask-scheduler --scheduler-file scheduler.json" &
sleep 15  # allow for the scheduler to come up
srun --ntasks=100 --exclusive singularity run -B /sfs -B /gxfs_work1 -B $PWD:/work --pwd /work $CONTAINER_FILE bash -c \
        ". /srv/conda/etc/profile.d/conda.sh && conda activate base \
        && dask-worker --scheduler-file scheduler.json --nthreads=10" &
wait
jobinfo
