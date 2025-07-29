#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/trevor-vincent/disco4est/src/Problems/TwoPunctures/create_param_study_scinet.sh
