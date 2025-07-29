#!/bin/bash
#SBATCH --job-name=assemblyTrack
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=64GB
#SBATCH --time=03:59:00

file=$1
module load matlab
matlab -singleCompThread -nodisplay  -nodesktop  -nojvm -r "runAssembly_trackVrev_condTrack('$file'); exit;"
