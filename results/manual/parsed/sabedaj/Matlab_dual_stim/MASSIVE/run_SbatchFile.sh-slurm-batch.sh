#!/bin/bash
#SBATCH --job-name=test_dataAnalysis
#SBATCH --mail-user=sabrina.meikle@monash.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=33000
#SBATCH --time=02:00:00

module load matlab
matlab -nodisplay -nojvm -nosplash < MASSIVE_ANALYSIS_SM.m
