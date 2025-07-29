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
cd  /fs/ess/PAS0439/MING/virome/amg_analysis/comparative_genomics_analysis/cazy/GH2_8_10_16/tree/GH16
module load python/3.6-conda5.2
source activate /fs/ess/PAS0439/MING/conda/trimal
trimal -in GH16_mafft.aln -out GH16_mafft_trimal.aln -gappyout
DURATION=$(( SECONDS - START ))
echo "Completed in $DURATION seconds."
