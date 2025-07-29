#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/axionyx/axionyx_1.0/Util/SUNDIALS_cuda_cpu_compute/summitdev.sh
