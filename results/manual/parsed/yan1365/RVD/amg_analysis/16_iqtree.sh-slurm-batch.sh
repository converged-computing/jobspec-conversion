#!/bin/bash
#SBATCH --job-name=iqtree_dcd_%j
#SBATCH --account=PAS0439
#SBATCH --output=iqtree_dcd_%j.out
#SBATCH --mail-user=yan1365,yan.1365@osu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=48
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00

START=$SECONDS
cd  /fs/ess/PAS0439/MING/virome/amg_analysis/comparative_genomics_analysis/dcd
module load python/3.6-conda5.2
source activate /fs/ess/PAS0439/MING/conda/iqtree
iqtree -s dcd_mafft_trimal.aln -redo -bb 1000 -m MFP -mset WAG,LG,JTT,Dayhoff -mrate E,I,G,I+G -mfreq FU -wbtl 
DURATION=$(( SECONDS - START ))
echo "Completed in $DURATION seconds."
