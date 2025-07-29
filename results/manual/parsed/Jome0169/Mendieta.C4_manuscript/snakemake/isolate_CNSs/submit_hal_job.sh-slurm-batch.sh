#!/bin/bash
#SBATCH --job-name=RunHal
#SBATCH --output=ntr.%j.out
#SBATCH --error=ntr.%j.err
#SBATCH --mail-user=john.mendieta@uga.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --mem=100gb
#SBATCH --time=5-00:00:00

cd $SLURM_SUBMIT_DIR
source /apps/lmod/lmod/init/zsh
ml HAL
hal2maf evolverPlants_all_genomes.18_plants.hal evolverPlants_5_genomes.increased_gap.blocklen1000_maxgap50.V2.maf --refGenome Zm-B73  --noAncestors --noDupes --onlyOrthologs --maxBlockLen 1000 --maxRefGap 50 --targetGenomes Pmiliaceum,Sbicolor,Osativa,Ufusca
