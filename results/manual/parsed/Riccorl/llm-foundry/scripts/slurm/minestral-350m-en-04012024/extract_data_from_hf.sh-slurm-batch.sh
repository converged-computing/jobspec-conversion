#!/bin/bash
#SBATCH --job-name=extract_data_from_hf
#SBATCH --account=IscrB_medit
#SBATCH --output=logs/minestral-350m-en-04012024/extract_data_from_hf-job.out
#SBATCH --error=logs/minestral-350m-en-04012024/extract_data_from_hf-job.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=00:50:00
#SBATCH --constraint=ntasks-per-node=1

export HF_DATASETS_CACHE='$WORK/hf_cache'

module load profile/deeplrn culturax/2309
export HF_DATASETS_CACHE=$WORK/hf_cache
source ~/llmfoundry-cuda-flash-attn2-env/bin/activate
~/llmfoundry-cuda-flash-attn2-env/bin/python scripts/data_prep/extract_hf_to_jsonl.py \
    --dataset_path /leonardo/prod/data/ai/culturax/2309/en \
    --path_to_save /leonardo_work/IscrB_medit/culturax/extracted/350M-model/en-v2/ \
    --max_samples 10_000_000 --streaming --split_size 500_000 
