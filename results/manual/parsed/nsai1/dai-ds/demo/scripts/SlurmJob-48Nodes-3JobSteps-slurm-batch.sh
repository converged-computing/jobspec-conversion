#!/bin/bash
#SBATCH --nodes=48
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

srun /opt/ucs/demo/workloads/MILC 1
srun /opt/ucs/demo/workloads/NEKbone 2
srun /opt/ucs/demo/workloads/AMG 3
