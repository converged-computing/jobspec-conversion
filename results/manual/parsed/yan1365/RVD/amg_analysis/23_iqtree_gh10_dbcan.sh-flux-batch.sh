#!/bin/bash
#FLUX: --job-name=iqtree_gh10_%j
#FLUX: -n=48
#FLUX: -t=28800
#FLUX: --priority=16

START=$SECONDS
cd  /fs/scratch/PAS0439/Ming/results/dbcan_res/tree/gh10
module load python/3.6-conda5.2
source activate /fs/ess/PAS0439/MING/conda/iqtree
iqtree -s gh10_mafft_trimal.aln -redo -bb 1000 -m MFP -mset WAG,LG,JTT,Dayhoff -mrate E,I,G,I+G -mfreq FU -wbtl 
DURATION=$(( SECONDS - START ))
echo "Completed in $DURATION seconds."
