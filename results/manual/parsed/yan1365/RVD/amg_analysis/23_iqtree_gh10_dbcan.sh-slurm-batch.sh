#!/bin/bash
#SBATCH --job-name=iqtree_gh10_%j
#SBATCH --account=PAS0439
#SBATCH --output=iqtree_gh10_%j.out
#SBATCH --mail-user=yan1365,yan.1365@osu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=48
#SBATCH --cpus-per-task=1
#SBATCH --time=08:00:00

START=$SECONDS
cd  /fs/scratch/PAS0439/Ming/results/dbcan_res/tree/gh10
module load python/3.6-conda5.2
source activate /fs/ess/PAS0439/MING/conda/iqtree
iqtree -s gh10_mafft_trimal.aln -redo -bb 1000 -m MFP -mset WAG,LG,JTT,Dayhoff -mrate E,I,G,I+G -mfreq FU -wbtl 
DURATION=$(( SECONDS - START ))
echo "Completed in $DURATION seconds."
