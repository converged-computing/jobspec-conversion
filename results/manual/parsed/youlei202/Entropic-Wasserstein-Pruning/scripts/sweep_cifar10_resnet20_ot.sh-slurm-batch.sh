#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/youlei202/Entropic-Wasserstein-Pruning/scripts/sweep_cifar10_resnet20_ot.sh
