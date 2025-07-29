#!/bin/bash
#SBATCH --job-name=amm_01
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=64G
#SBATCH --time=2-00:00:00
#SBATCH --partition=ccei_biomass

. /opt/shared/slurm/templates/libexec/openmp.sh
vpkg_require matlab/r2020b
srun matlab -nodisplay -nosplash -nodesktop -singleCompThread -r 'amm_main4(593)'
