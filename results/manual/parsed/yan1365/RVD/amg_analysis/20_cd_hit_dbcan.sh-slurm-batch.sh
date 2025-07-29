#!/bin/bash
#FLUX: --job-name=cd_hit_%j
#FLUX: -n=48
#FLUX: -t=60
#FLUX: --urgency=16

START=$SECONDS
cd  /fs/scratch/PAS0439/Ming/results/dbcan_res/tree/
module load python/3.6-conda5.2
source activate /fs/ess/PAS0439/MING/conda/cd-hit
cd-hit -i gh10/rumen_nr_combined_gh10_for_cdhit.fasta -o gh10/nr_gh10_clus70.fasta -c 0.70 -n 5  -M 1600000 -d 0 -T 48 
cd-hit -i gh16/rumen_nr_combined_gh16_for_cdhit.fasta -o gh16/nr_gh16_clus70.fasta -c 0.70 -n 5  -M 1600000 -d 0 -T 48
DURATION=$(( SECONDS - START ))
echo "Completed in $DURATION seconds."
