#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/saforem2/sdl_workshop/distributedDeepLearning/DDP/qsub_cifar10.qsub
