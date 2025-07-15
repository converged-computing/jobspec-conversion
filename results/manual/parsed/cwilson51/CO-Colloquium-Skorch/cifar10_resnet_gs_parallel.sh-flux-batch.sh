#!/bin/bash
#FLUX: --job-name=lovable-caramel-3393
#FLUX: -t=90
#FLUX: --priority=16

module load python
module list
source /path/to/your/env/bin/activate
echo 'Starting scheduler'
dask scheduler &
sleep 10
echo 'Scheduler booted, launching workers'
CUDA_VISIBLE_DEVICES=0 dask worker 127.0.0.1:8786 --nthreads 1 &
sleep 10
CUDA_VISIBLE_DEVICES=1 dask worker 127.0.0.1:8786 --nthreads 1 &
python cifar10_resnet_parallel.py --max_epochs 50 --batch_size 2000
