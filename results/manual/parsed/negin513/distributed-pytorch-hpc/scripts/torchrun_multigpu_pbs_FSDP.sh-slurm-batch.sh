#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/negin513/distributed-pytorch-hpc/scripts/torchrun_multigpu_pbs_FSDP.sh
