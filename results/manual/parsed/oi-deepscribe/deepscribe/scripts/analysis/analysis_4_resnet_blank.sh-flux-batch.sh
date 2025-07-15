#!/bin/bash
#FLUX: --job-name=goodbye-pot-4321
#FLUX: --queue=gpu2
#FLUX: --urgency=16

module load cuda/9.1
SIGNS='["na","HAL","iš","MEŠ"]'
luigi --module deepscribe.pipeline.analysis RunAnalysisOnTestDataTask --local-scheduler \
      --imgfolder data/ochre/a_pfa \
      --hdffolder ../deepscribe-data/processed/pfa_new \
      --modelsfolder models \
      --target-size 50 \
      --keep-categories $SIGNS  \
      --fractions '[0.7, 0.1, 0.2]' \
      --model-definition data/model_defs/resnet50_blank.json
