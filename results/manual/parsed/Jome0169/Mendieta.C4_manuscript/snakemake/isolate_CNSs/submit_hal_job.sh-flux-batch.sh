#!/bin/bash
#FLUX: --job-name=RunHal
#FLUX: -c=5
#FLUX: --queue=batch
#FLUX: -t=432000
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
source /apps/lmod/lmod/init/zsh
ml HAL
hal2maf evolverPlants_all_genomes.18_plants.hal evolverPlants_5_genomes.increased_gap.blocklen1000_maxgap50.V2.maf --refGenome Zm-B73  --noAncestors --noDupes --onlyOrthologs --maxBlockLen 1000 --maxRefGap 50 --targetGenomes Pmiliaceum,Sbicolor,Osativa,Ufusca
