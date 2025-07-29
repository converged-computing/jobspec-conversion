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
source activate /fs/ess/PAS0439/MING/conda/trimal
trimal -in gh16/gh16_mafft.aln -out gh16/gh16_mafft_trimal.aln -gappyout
DURATION=$(( SECONDS - START ))
echo "Completed in $DURATION seconds."
