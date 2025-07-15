#!/bin/bash
#FLUX: --job-name=reranker
#FLUX: -t=1800
#FLUX: --priority=16

module load cuda
module load tensorflow/2.5.0-py39-cuda112
source venv/bin/activate
srun python bert_reranker.py \
	--run_file examples/agask/runs/run-bm25-agask-query-test50.res \
	--collection_file examples/agask/collection/agask_collection-test50.tsv \
	--query_file /home/koo01a/scratch/agvaluate/data/queries/agask_questions-test50.csv \
	--model_name_or_path examples/agask/models/agask_model_custom_params_queries \
	--tokenizer_name_or_path examples/agask/models/agask_model_custom_params_queries \
	--batch_size 32 \
	--cut_off 500
