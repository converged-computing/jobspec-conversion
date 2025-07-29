#!/bin/bash
#SBATCH --job-name=DSGT
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=36
#SBATCH --gres=gpu:4
#SBATCH --mem=128000
#SBATCH --time=41-16:00:00

singularity exec \
  --nv \
  --bind ~/checkpoints/:/DeepSpeech/checkpoints/ \
  --bind /cfs/share/cache/db_xds/data_original/:/DeepSpeech/data_original/ \
  --bind /cfs/share/cache/db_xds/data_prepared/:/DeepSpeech/data_prepared/ \
  --bind ~/deepspeech-german/:/DeepSpeech/deepspeech-german/ \
  /cfs/share/cache/db_xds/images/deep_speech_german.sif \
  /bin/bash -c 'chmod +x /DeepSpeech/deepspeech-german/training/train.sh && /DeepSpeech/deepspeech-german/training/train.sh'
