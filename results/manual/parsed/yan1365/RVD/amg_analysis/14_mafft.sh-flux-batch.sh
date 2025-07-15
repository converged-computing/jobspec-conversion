#!/bin/bash
#FLUX: --job-name=cd_hit_dcd_%j
#FLUX: -n=48
#FLUX: -t=600
#FLUX: --urgency=16

START=$SECONDS
cd  /fs/ess/PAS0439/MING/virome/amg_analysis/comparative_genomics_analysis/dcd
module load python/3.6-conda5.2
source activate /fs/ess/PAS0439/MING/conda/mafft
mafft dcd_for_msa.fasta > dcd_mafft.aln
DURATION=$(( SECONDS - START ))
echo "Completed in $DURATION seconds."
