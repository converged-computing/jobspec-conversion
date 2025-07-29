#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/JustinFletcher/hpc-tensorflow/resnet_cifar_study/resnet_cifar_cluster_experiment_launcher.pbs
