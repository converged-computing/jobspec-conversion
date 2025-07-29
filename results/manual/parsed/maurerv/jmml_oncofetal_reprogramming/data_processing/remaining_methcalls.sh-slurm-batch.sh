#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/maurerv/jmml_oncofetal_reprogramming/data_processing/remaining_methcalls.sh
