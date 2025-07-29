#!/bin/bash
#FLUX: --job-name=explagraph_dev_file_generation
#FLUX: -c=8
#FLUX: --queue=nodes
#FLUX: -t=259200
#FLUX: --urgency=16

echo $(pwd)
nvidia-smi
echo $CUDA_VISIBLE_DEVICES
eval "$(conda shell.bash hook)"
conda activate general
python -m cbr_analyser.augmentations.prompt_gpt_j \
    --task output_explagraph \
    --input_file cache/masked_sentences_with_AMR_container_objects_with_belief_argument.joblib \
    --output_file cache/explagraph/train.tsv
conda deactivate
