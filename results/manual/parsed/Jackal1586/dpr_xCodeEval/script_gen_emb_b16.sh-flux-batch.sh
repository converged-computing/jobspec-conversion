#!/bin/bash
#FLUX: --job-name=astute-peanut-butter-1415
#FLUX: --urgency=16

export CUDA_VISIBLE_DEVICES='0,1,2'

module add cuda11.2/toolkit/11.2.0
source /home/sbmaruf/anaconda3/bin/activate xcodeeval
export CUDA_VISIBLE_DEVICES='0,1,2'
python generate_dense_embeddings.py     model_file="/home/sbmaruf/dpr_xcode_eval/outputs/2023-04-28/16-39-28/dumped_ret_xcodeeval/dpr_biencoder.35"     ctx_src=XCL_retrieval_C     shard_id=0 num_shards=1     out_file="/home/sbmaruf/dpr_xcode_eval/outputs/2023-04-28/16-39-28/emb_XCL_retrieval_C"
python generate_dense_embeddings.py     model_file="/home/sbmaruf/dpr_xcode_eval/outputs/2023-04-28/16-39-28/dumped_ret_xcodeeval/dpr_biencoder.35"     ctx_src=XCL_retrieval_CS     shard_id=0 num_shards=1     out_file="/home/sbmaruf/dpr_xcode_eval/outputs/2023-04-28/16-39-28/emb_XCL_retrieval_CS"
export -n CUDA_VISIBLE_DEVICES
cd /export/home2/sbmaruf/prompt-tuning/prompt-tuning/
sbatch scripts/train/t0_t5-3b/01.mem_prompt_2.sh
