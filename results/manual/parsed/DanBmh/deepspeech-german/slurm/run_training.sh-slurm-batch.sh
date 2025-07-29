#!/bin/bash
#FLUX: --job-name=DSGT
#FLUX: -c=36
#FLUX: --queue=gpu
#FLUX: -t=3600000
#FLUX: --urgency=16

singularity exec \
  --nv \
  --bind ~/checkpoints/:/DeepSpeech/checkpoints/ \
  --bind /cfs/share/cache/db_xds/data_original/:/DeepSpeech/data_original/ \
  --bind /cfs/share/cache/db_xds/data_prepared/:/DeepSpeech/data_prepared/ \
  --bind ~/deepspeech-german/:/DeepSpeech/deepspeech-german/ \
  /cfs/share/cache/db_xds/images/deep_speech_german.sif \
  /bin/bash -c 'chmod +x /DeepSpeech/deepspeech-german/training/train.sh && /DeepSpeech/deepspeech-german/training/train.sh'
