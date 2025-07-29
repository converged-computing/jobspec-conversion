#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/bakery-cg2at/bakery/examples/network_backmapping/mf/backmapping/run_simulation.pbs
