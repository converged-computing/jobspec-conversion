#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/UO-OACISS/tau2/examples/plugin/adios2_trace/summit_tau_only.sh
