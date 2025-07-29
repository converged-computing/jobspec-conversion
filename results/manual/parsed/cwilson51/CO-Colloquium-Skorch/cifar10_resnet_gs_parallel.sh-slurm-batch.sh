#!/bin/bash
#SBATCH --account=def-someuser
#SBATCH --output=parallel-multigpu-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5000M
#SBATCH --time=00:01:30
#SBATCH --constraint=ntasks-per-node=4

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
