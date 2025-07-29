#!/bin/bash
#SBATCH --output=%j.out
#SBATCH --error=%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=64G
#SBATCH --time=01:30:00
#SBATCH --partition=priority

                                # Or use HH:MM:SS or D-HH:MM:SS, instead of just number of minutes
module load matlab/2017a
matlab -nodisplay -r "spkParse96well; quit"
