#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/asaxton/ncsa-bluewaters-tensorflow/datasets/imagenet/extract_data_from_archive.pbs
