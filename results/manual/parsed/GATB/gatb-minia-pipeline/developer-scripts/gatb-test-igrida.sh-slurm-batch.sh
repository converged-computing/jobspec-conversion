#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/GATB/gatb-minia-pipeline/developer-scripts/gatb-test-igrida.sh
