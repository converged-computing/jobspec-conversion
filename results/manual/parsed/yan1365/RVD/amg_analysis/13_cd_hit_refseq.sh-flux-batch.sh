#!/bin/bash
#FLUX: --job-name=cd_hit_dcd_%j
#FLUX: -n=48
#FLUX: -t=60
#FLUX: --priority=16

START=$SECONDS
cd  /fs/ess/PAS0439/MING/virome/amg_analysis/comparative_genomics_analysis/dcd
module load python/3.6-conda5.2
source activate /fs/ess/PAS0439/MING/conda/cd-hit
cd-hit -i dcd_refseq.fasta -o cd-hit-cls-50/dcd_refseq_50 -c 0.5 -n 3  -M 1600000 -d 0 -T 48 
DURATION=$(( SECONDS - START ))
echo "Completed in $DURATION seconds."
