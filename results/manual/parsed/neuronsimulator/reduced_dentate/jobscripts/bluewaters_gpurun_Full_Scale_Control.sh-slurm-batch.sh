#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/neuronsimulator/reduced_dentate/jobscripts/bluewaters_gpurun_Full_Scale_Control.sh
