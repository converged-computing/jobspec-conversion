#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/mingzhew/character_naming_vision/facenet/facenet/src/align/pbs_template.sh
