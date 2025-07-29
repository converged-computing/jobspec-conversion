#!/bin/bash
#SBATCH --job-name=TF1
#SBATCH --account=molbio
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=24G
#SBATCH --time=01:59:00

module purge
module load matlab/R2023a
matlab -nodisplay -nosplash -r  "align_long_short('/scratch/gpfs/ddenberg/231231/231231_st7/Ch0long_nanog', '/scratch/gpfs/ddenberg/231231/231231_st7/Ch0long_nanog_centers', '/scratch/gpfs/ddenberg/231231/231231_st7/Ch0short_gata6', '/scratch/gpfs/ddenberg/231231/231231_st7/Ch0short_gata6_centers', '/scratch/gpfs/ddenberg/231231/231231_st7/LS_align', [80:150], 16)"
