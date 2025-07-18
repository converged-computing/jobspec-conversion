#!/bin/bash
#FLUX: --job-name=astute-pedo-0710
#FLUX: --queue=debug
#FLUX: -t=600
#FLUX: --urgency=16

export SHIFTER_IMAGETYPE='docker'
export SHIFTER_IMAGE='ulissigroup/catlas:latest'
export SLURM_CPU_BIND='cores'

export SHIFTER_IMAGETYPE=docker
export SHIFTER_IMAGE=ulissigroup/catlas:latest
export SLURM_CPU_BIND="cores"
cd $SCRATCH/catlas
scheduler_file=$SCRATCH/scheduler_file.json
rm -f $scheduler_file
DASK_DISTRIBUTED__COMM__TIMEOUTS__CONNECT=3600s \
DASK_DISTRIBUTED__COMM__TIMEOUTS__TCP=3600s \
shifter python -m distributed.cli.dask_scheduler \
    --scheduler-file $scheduler_file &
dask_pid=$!
sleep 5
until [ -f $scheduler_file ]
do
     sleep 5
done
DASK_DISTRIBUTED__COMM__TIMEOUTS__CONNECT=3600s \
DASK_DISTRIBUTED__COMM__TIMEOUTS__TCP=3600s \
srun --overlap --gpus-per-task=1 \
     --ntasks-per-node=4 \
     -c 2 \
     --mem-per-gpu=10gb \
     --exact \
     shifter --env=PYTHONPATH=/opt/mods/lib/python3.6/site-packages:/home/jovyan/ocp/:$SCRATCH/catlas/ \
     dask-worker \
     --nthreads 1 \
     --nprocs 1 \
     --no-dashboard \
     --memory-limit 10Gib \
     --death-timeout 600 \
     --resources 'GPU=1' \
     --local-directory /tmp \
     --scheduler-file $scheduler_file & 
DASK_DISTRIBUTED__COMM__TIMEOUTS__CONNECT=3600s \
DASK_DISTRIBUTED__COMM__TIMEOUTS__TCP=3600s \
srun --overlap \
     --ntasks-per-node=10 \
     -c 4 \
     --mem-per-cpu=2gb \
     --exact \
     --gpus=0 \
     shifter --env=PYTHONPATH=/opt/mods/lib/python3.6/site-packages:/home/jovyan/ocp/:$SCRATCH/catlas/ \
     dask-worker \
     --nthreads 4 \
     --nprocs 1 \
     --no-dashboard \
     --memory-limit 8Gib \
     --death-timeout 600 \
     --local-directory /tmp \
     --scheduler-file $scheduler_file &
shifter --env=PYTHONPATH=/opt/mods/lib/python3.6/site-packages:/home/jovyan/ocp/:$SCRATCH/catlas/ \
        --env=scheduler_file=$scheduler_file \
        python bin/predictions.py \
        configs/dask_cluster/perlmutter/test_gpu_relax.yml \
        configs/dask_cluster/perlmutter/slurm_scheduler.yml
echo "Killing scheduler"
kill -9 $dask_pid
