#!/bin/bash
#SBATCH --account=jkimball
#SBATCH --output=run_AMOVA.out
#SBATCH --error=run_AMOVA.err
#SBATCH --mail-user=haasx092@umn.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=60g
#SBATCH --time=1-00:00:00
#SBATCH --partition=amdsmall

cd /home/jkimball/haasx092/AMOVA
module load gcc/8.1.0
module load udunits/2.2.26_gcc8.1.0
module load proj/4.9.3
module load gdal/2.3.2
module load geos/3.7.1
module load R/3.6.0
Rscript AMOVA.R filtered_to_match_STRUCTURE_input.recode.vcf
