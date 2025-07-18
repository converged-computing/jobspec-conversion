#!/bin/bash
#FLUX: --job-name=anxious-lemur-1973
#FLUX: -c=2
#FLUX: -t=604800
#FLUX: --urgency=16

FEATURE_MANIFEST_ROOT=/disk/nfs/ostrom/s2324992/data/yoruba/feature_manifest
MAX_TOKENS=24000 #,30000(transformertts)
NUM_GPUS=4
NUM_WORKERS=2 #,4(transformertts)
UPDATE_FREQ=3 #,8(transformertts)
MODEL_NAME=yor_500_${MAX_TOKENS}_${NUM_GPUS}
USR_DIR=/home/s2324992/fairseq/examples/speech_audio_corrector
fairseq-train ${FEATURE_MANIFEST_ROOT} \
  --user-dir $USR_DIR --save-dir checkpoints/$MODEL_NAME --tensorboard-logdir tb_logs/$MODEL_NAME \
  --config-yaml config.yaml --train-subset train --valid-subset dev \
  --num-workers $NUM_WORKERS --max-tokens $MAX_TOKENS --max-update 500000000 \
  --task speech_audio_corrector --criterion sac_tts --arch sac_transformer \
  --clip-norm 5.0 --n-frames-per-step 4 --bce-pos-weight 5.0 \
  --dropout 0.1 --attention-dropout 0.1 --activation-dropout 0.1 \
  --encoder-normalize-before --decoder-normalize-before --save-interval 10 \
  --optimizer adam --lr 2e-3 --lr-scheduler inverse_sqrt --warmup-updates 4000 \
  --seed 1 --update-freq $UPDATE_FREQ --best-checkpoint-metric loss \
  --recreate-word2speechreps --skip-invalid-size-inputs-valid-test
