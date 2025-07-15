#!/bin/bash
#FLUX: --job-name=gpt_j_prompts_extraction
#FLUX: -c=8
#FLUX: --queue=nodes
#FLUX: -t=259200
#FLUX: --priority=16

echo $(pwd)
nvidia-smi
echo $CUDA_VISIBLE_DEVICES
eval "$(conda shell.bash hook)"
conda activate general
python -m cbr_analyser.augmentations.prompt_gpt_j \
    --task generate \
    --input_file cache/masked_sentences_with_AMR_container_objects.joblib \
    --output_file cache/masked_sentences_with_AMR_container_objects_with_belief_argument.joblib
python -m cbr_analyser.augmentations.prompt_gpt_j \
    --task generate \
    --input_file cache/masked_sentences_with_AMR_container_objects_dev.joblib \
    --output_file cache/masked_sentences_with_AMR_container_objects_dev_with_belief_argument.joblib
python -m cbr_analyser.augmentations.prompt_gpt_j \
    --task generate \
    --input_file cache/masked_sentences_with_AMR_container_objects_test.joblib \
    --output_file cache/masked_sentences_with_AMR_container_objects_test_with_belief_argument.joblib
conda deactivate
