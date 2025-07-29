#!/bin/bash
#FLUX: --job-name=iqtree_gh10_%j
#FLUX: -n=48
#FLUX: -t=28800
#FLUX: --urgency=16

START=$SECONDS
cd  /fs/ess/PAS0439/MING/virome/amg_analysis/comparative_genomics_analysis/cazy/GH2_8_10_16/tree/GH10
module load python/3.6-conda5.2
source activate /fs/ess/PAS0439/MING/conda/iqtree
iqtree -s GH10_mafft_trimal.aln -redo -bb 1000 -m MFP -mset WAG,LG,JTT,Dayhoff -mrate E,I,G,I+G -mfreq FU -wbtl 
DURATION=$(( SECONDS - START ))
echo "Completed in $DURATION seconds."
