#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/LLNL/magpie/submission-scripts/script-msub-torque-pdsh/magpie.msub-torque-pdsh-hadoop-and-hive
