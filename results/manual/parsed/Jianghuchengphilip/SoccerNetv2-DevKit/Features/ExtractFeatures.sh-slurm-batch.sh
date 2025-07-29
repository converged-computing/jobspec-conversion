#!/bin/bash
#SBATCH --job-name=SN_feat
#SBATCH --output=log/%x.%3a.%A.out
#SBATCH --error=log/%x.%3a.%A.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu
#SBATCH --mem=45G
#SBATCH --time=03:59:00
#SBATCH --array=0-549

date
echo "Loading anaconda..."
module load anaconda3
module load cuda/10.1.243
module list
source activate SoccerNet
echo "...Anaconda env loaded"
echo "Extracting features..."
python tools/ExtractResNET_TF2.py \
--soccernet_dirpath /ibex/scratch/giancos/SoccerNet/ \
--game_ID $SLURM_ARRAY_TASK_ID \
--back_end=TF2 \
--features=ResNET \
--video LQ \
--transform crop \
--verbose \
"$@"
echo "Features extracted..."
date
