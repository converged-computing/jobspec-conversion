#!/bin/bash
#SBATCH --account=quinnlab
#SBATCH --output=/scratch/js4yd/GI_RandomSeedEval910/Compareb40.out
#SBATCH --mail-user=js4yd@virginia.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --chdir=/scratch/js4yd/GI_RandomSeedEval910/

module purge
module load gcc/7.1.0 openmpi/3.1.4 R/3.5.3
Rscript /sfs/lustre/bahamut/scratch/js4yd/GI_RandomSeedEval910/CompareGIStreamflows.R '30' '/scratch/js4yd/GI_RandomSeedEval910/' 'RHESSys_Baisman30m_g74' '100' '2004-10-01' '101' '40'
