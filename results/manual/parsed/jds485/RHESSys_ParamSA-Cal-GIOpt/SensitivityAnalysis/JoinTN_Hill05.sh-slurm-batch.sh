#!/bin/bash
#SBATCH --account=quinnlab
#SBATCH --output=/scratch/js4yd/MorrisSA/TNprocessing/JoinTNHill05Run_All.out
#SBATCH --mail-user=js4yd@virginia.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --partition=largemem
#SBATCH --chdir=/scratch/js4yd/MorrisSA/TNprocessing/

module load gcc/7.1.0 openmpi/3.1.4 R/3.5.3
Rscript TNFileJoining_Hill05.R "/scratch/js4yd/MorrisSA/TNprocessing/" 'DateColumnNames.txt' 'SAResults_HillStreamflow_p6_t.txt' '/scratch/js4yd/MorrisSA/TNprocessing/TNdata/' "TNSAreps_Hill05_All.RData" 'SAResults_HillTN05_p3_All.txt'
