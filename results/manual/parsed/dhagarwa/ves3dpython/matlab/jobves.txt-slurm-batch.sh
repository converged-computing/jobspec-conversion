#!/bin/bash
#SBATCH --job-name=gpuvesjob
#SBATCH --account=ASC21002
#SBATCH --output=jobresults/gpuvesjob_poi.out
#SBATCH --error=jobresults/gpuvesjob_poi.err
#SBATCH --mail-user=dhwanit@oden.utexas.edu
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00

module load matlab
matlab -nodesktop -nodisplay -nosplash < testRun.m
