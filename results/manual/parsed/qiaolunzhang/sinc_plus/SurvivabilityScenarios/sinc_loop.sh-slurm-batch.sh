#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/qiaolunzhang/sinc_plus/SurvivabilityScenarios/sinc_loop.sh
