#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/jasonjnie/Distributed-Tensorflow-Blue-Waters/datasets/imagenet/build_imagenet_data.pbs
