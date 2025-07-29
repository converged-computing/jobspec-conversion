#!/bin/bash
#SBATCH --job-name=PlotBERBaseline
#SBATCH --output=test.%j.out
#SBATCH --error=test.%j.err
#SBATCH --mail-user=$USER@stanford.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G
#SBATCH --time=05:00:00
#SBATCH --partition=normal

echo "Start test"
module load matlab 
matlab -nodesktop -r "run('PlotPerfectBaseline.m'); run('PlotEstimateBaseline.m'); exit(0);"
echo "End test"
