#!/bin/bash
#FLUX: --job-name=extract_data_from_hf
#FLUX: -c=4
#FLUX: -t=3000
#FLUX: --urgency=16

export HF_DATASETS_CACHE='$WORK/hf_cache'

module load profile/deeplrn culturax/2309
export HF_DATASETS_CACHE=$WORK/hf_cache
source ~/llmfoundry-cuda-flash-attn2-env/bin/activate
~/llmfoundry-cuda-flash-attn2-env/bin/python scripts/data_prep/extract_hf_to_jsonl.py \
    --dataset_path /leonardo/prod/data/ai/culturax/2309/en \
    --path_to_save /leonardo_work/IscrB_medit/culturax/extracted/350M-model/en-v2/ \
    --max_samples 10_000_000 --streaming --split_size 500_000 
