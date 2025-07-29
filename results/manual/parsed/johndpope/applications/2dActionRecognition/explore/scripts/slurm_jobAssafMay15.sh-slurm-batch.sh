#!/bin/bash
#SBATCH --job-name=serialJob
#SBATCH --output=serialJob.%j.out
#SBATCH --error=serialJob.%j.time
#SBATCH --mail-user=andrew.jamieson@utsouthwestern.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=03:00:00
#SBATCH --partition=super

module add matlab/2017a                                  # load software package
matlab -nodisplay -nodesktop -nosplash -r "run('/home2/s170480/matlab/applications/2dActionRecognition/explore/scripts/script_CellMD_OMETIFF_Gen2n3May15_arj.m'), exit"
