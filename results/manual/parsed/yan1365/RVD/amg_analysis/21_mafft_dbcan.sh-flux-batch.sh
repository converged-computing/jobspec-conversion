#!/bin/bash
#FLUX: --job-name=cd_hit_dcd_%j
#FLUX: -n=48
#FLUX: -t=600
#FLUX: --priority=16

START=$SECONDS
cd  /fs/scratch/PAS0439/Ming/results/dbcan_res/tree/
module load python/3.6-conda5.2
source activate /fs/ess/PAS0439/MING/conda/mafft
mafft  gh10/gh10_combined.fasta > gh10/gh10_mafft.aln
mafft  gh16/gh16_combined.fasta > gh16/gh16_mafft.aln
DURATION=$(( SECONDS - START ))
echo "Completed in $DURATION seconds."
