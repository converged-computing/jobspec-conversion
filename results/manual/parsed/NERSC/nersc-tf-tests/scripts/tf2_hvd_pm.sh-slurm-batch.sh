#!/bin/bash
#SBATCH --job-name=tf2-benchmark-pm
#SBATCH --output=logs/%x-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --time=00:05:00
#SBATCH --constraint=gpu,ntasks-per-node=4

module list
set -x
srun -l -u python horovod/examples/tensorflow2/tensorflow2_synthetic_benchmark.py
