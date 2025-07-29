#!/bin/bash
#FLUX: --job-name=prototex_explanations
#FLUX: -c=8
#FLUX: --queue=nodes
#FLUX: -t=259200
#FLUX: --urgency=16

echo $(pwd)
nvidia-smi
echo $CUDA_VISIBLE_DEVICES
eval "$(conda shell.bash hook)"
conda activate prototex
dataset="data/finegrained_with_none"
echo "dataset: ${dataset}"
modelname="curr_lf_fine_updated_aug_with_none_nli_prototex"
python inference_and_explanations.py --num_prototypes 50 --num_pos_prototypes 49 --data_dir ${dataset} --modelname ${modelname} --project "curriculum-learning" --experiment "lf_fine_updated_classification_1" --none_class "Yes" --augmentation "Yes" --nli_intialization "Yes" --curriculum "Yes" --architecture "BART"
conda deactivate
