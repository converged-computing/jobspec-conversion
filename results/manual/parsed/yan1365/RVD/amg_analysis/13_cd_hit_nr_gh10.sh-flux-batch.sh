#!/bin/bash
#FLUX: --job-name=cd_hit_dcd_%j
#FLUX: -n=48
#FLUX: -t=60
#FLUX: --priority=16

START=$SECONDS
cd  /fs/ess/PAS0439/MING/virome/amg_analysis/comparative_genomics_analysis/cazy/GH2_8_10_16/tree/GH10
module load python/3.6-conda5.2
source activate /fs/ess/PAS0439/MING/conda/cd-hit
cd-hit -i GH10_for_cd_hit.fasta -o GH10_nr_50.fasta -c 0.5 -n 3  -M 1600000 -d 0 -T 48 
DURATION=$(( SECONDS - START ))
echo "Completed in $DURATION seconds."
