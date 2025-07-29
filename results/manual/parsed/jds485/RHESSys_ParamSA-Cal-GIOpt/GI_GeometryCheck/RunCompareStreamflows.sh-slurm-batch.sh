#!/bin/bash
#SBATCH --account=quinnlab
#SBATCH --output=/scratch/js4yd/GI_RandomSeedEval_Mid/Compareb_Mid.out
#SBATCH --mail-user=js4yd@virginia.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --partition=standard
#SBATCH --chdir=/scratch/js4yd/GI_RandomSeedEval_Mid/

module purge
module load gcc/7.1.0 openmpi/3.1.4 R/3.5.3
Rscript /sfs/lustre/bahamut/scratch/js4yd/GI_RandomSeedEval_Mid/CompareGIStreamflows.R '30' '/scratch/js4yd/GI_RandomSeedEval_Mid/' 'RHESSys_Baisman30m_g74' '100' '2004-10-01' '1' ''
