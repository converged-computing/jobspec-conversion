#!/bin/bash
#FLUX: --job-name=strawberry-poo-5497
#FLUX: --priority=16

export CUDA_VISIBLE_DEVICES='0,1,2'

module add cuda11.2/toolkit/11.2.0
source /home/sbmaruf/anaconda3/bin/activate xcodeeval
export CUDA_VISIBLE_DEVICES='0,1,2'
python generate_dense_embeddings.py     model_file="/home/sbmaruf/dpr_xcode_eval/outputs/2023-04-28/16-39-51/dumped_ret_xcodeeval/dpr_biencoder.35"     ctx_src=XCL_retrieval_Scala     shard_id=0 num_shards=1     out_file="/home/sbmaruf/dpr_xcode_eval/outputs/2023-04-28/16-39-51/emb_XCL_retrieval_Scala"
python generate_dense_embeddings.py     model_file="/home/sbmaruf/dpr_xcode_eval/outputs/2023-04-28/16-39-51/dumped_ret_xcodeeval/dpr_biencoder.35"     ctx_src=XCL_retrieval_D     shard_id=0 num_shards=1     out_file="/home/sbmaruf/dpr_xcode_eval/outputs/2023-04-28/16-39-51/emb_XCL_retrieval_D"
python generate_dense_embeddings.py     model_file="/home/sbmaruf/dpr_xcode_eval/outputs/2023-04-28/16-39-51/dumped_ret_xcodeeval/dpr_biencoder.35"     ctx_src=XCL_retrieval_Rust     shard_id=0 num_shards=1     out_file="/home/sbmaruf/dpr_xcode_eval/outputs/2023-04-28/16-39-51/emb_XCL_retrieval_Rust"
python generate_dense_embeddings.py     model_file="/home/sbmaruf/dpr_xcode_eval/outputs/2023-04-28/16-39-51/dumped_ret_xcodeeval/dpr_biencoder.35"     ctx_src=XCL_retrieval_PHP     shard_id=0 num_shards=1     out_file="/home/sbmaruf/dpr_xcode_eval/outputs/2023-04-28/16-39-51/emb_XCL_retrieval_PHP"
python generate_dense_embeddings.py     model_file="/home/sbmaruf/dpr_xcode_eval/outputs/2023-04-28/16-39-51/dumped_ret_xcodeeval/dpr_biencoder.35"     ctx_src=XCL_retrieval_Kotlin     shard_id=0 num_shards=1     out_file="/home/sbmaruf/dpr_xcode_eval/outputs/2023-04-28/16-39-51/emb_XCL_retrieval_Kotlin"
python generate_dense_embeddings.py     model_file="/home/sbmaruf/dpr_xcode_eval/outputs/2023-04-28/16-39-51/dumped_ret_xcodeeval/dpr_biencoder.35"     ctx_src=XCL_retrieval_Ruby     shard_id=0 num_shards=1     out_file="/home/sbmaruf/dpr_xcode_eval/outputs/2023-04-28/16-39-51/emb_XCL_retrieval_Ruby"
python generate_dense_embeddings.py     model_file="/home/sbmaruf/dpr_xcode_eval/outputs/2023-04-28/16-39-51/dumped_ret_xcodeeval/dpr_biencoder.35"     ctx_src=XCL_retrieval_Java     shard_id=0 num_shards=1     out_file="/home/sbmaruf/dpr_xcode_eval/outputs/2023-04-28/16-39-51/emb_XCL_retrieval_Java"
python generate_dense_embeddings.py     model_file="/home/sbmaruf/dpr_xcode_eval/outputs/2023-04-28/16-39-51/dumped_ret_xcodeeval/dpr_biencoder.35"     ctx_src=XCL_retrieval_Ocaml     shard_id=0 num_shards=1     out_file="/home/sbmaruf/dpr_xcode_eval/outputs/2023-04-28/16-39-51/emb_XCL_retrieval_Ocaml"
export -n CUDA_VISIBLE_DEVICES
cd /export/home2/sbmaruf/prompt-tuning/prompt-tuning/
sbatch scripts/train/t0_t5-3b/01.mem_prompt_2.sh
