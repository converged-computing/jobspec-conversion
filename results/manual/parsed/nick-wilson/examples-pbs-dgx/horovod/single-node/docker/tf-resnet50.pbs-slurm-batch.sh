#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/nick-wilson/examples-pbs-dgx/horovod/single-node/docker/tf-resnet50.pbs
