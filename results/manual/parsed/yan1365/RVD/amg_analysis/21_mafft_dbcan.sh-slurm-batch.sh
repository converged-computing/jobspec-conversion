#!/bin/bash
#SBATCH --job-name=cd_hit_dcd_%j
#SBATCH --account=PAS0439
#SBATCH --output=cd_hit_dcd_%j.out
#SBATCH --mail-user=yan1365,yan.1365@osu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=48
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00

START=$SECONDS
cd  /fs/scratch/PAS0439/Ming/results/dbcan_res/tree/
module load python/3.6-conda5.2
source activate /fs/ess/PAS0439/MING/conda/mafft
mafft  gh10/gh10_combined.fasta > gh10/gh10_mafft.aln
mafft  gh16/gh16_combined.fasta > gh16/gh16_mafft.aln
DURATION=$(( SECONDS - START ))
echo "Completed in $DURATION seconds."
