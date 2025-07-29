#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/jaytlennon/Task2/LTDE/bin/assembly/cutadapt_reference.sh
