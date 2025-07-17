#!/bin/bash
#FLUX: --job-name=buttery-truffle-8268
#FLUX: -t=60
#FLUX: --urgency=16

module load python/3.6.3
source /home/ahamsala/torch_DPR/bin/activate
source /home/ahamsala/torch_DPR/bin/activate
python --version
python -m torch.distributed.launch \
	--nproc_per_node=1 train_dense_encoder.py \
	--max_grad_norm 2.0 \
	--encoder_model_type hf_bert \
	--pretrained_model_cfg bert-base-uncased \
	--seed 12345 \
	--sequence_length 256 \
	--warmup_steps 1237 \
	--batch_size 2 \
	--do_lower_case \
	--train_file "/home/ahamsala/projects/def-ehyangit/ahamsala/DPR/data/retriever/nq-train-subset.json" \
	--dev_file "/home/ahamsala/projects/def-ehyangit/ahamsala/DPR/data/retriever/nq-dev.json" \
	--output_dir "/home/ahamsala/projects/def-ehyangit/ahamsala/DPR/output" \
	--learning_rate 2e-05 \
	--num_train_epochs 1 \
	--dev_batch_size 16 \
 	--val_av_rank_start_epoch 1
python -m torch.distributed.launch \
	--nproc_per_node=1 train_dense_encoder.py \
	--max_grad_norm 2.0 \
	--encoder_model_type hf_bert \
	--pretrained_model_cfg bert-base-uncased \
	--seed 12345 \
	--sequence_length 256 \
	--warmup_steps 1237 \
	--batch_size 2 \
	--do_lower_case \
	--train_file "/home/ahamsala/projects/def-ehyangit/ahamsala/DPR/data/MSMARCO.dev.json" \
	--dev_file "/home/ahamsala/projects/def-ehyangit/ahamsala/DPR/data/retriever/nq-dev.json" \
	--output_dir "/home/ahamsala/projects/def-ehyangit/ahamsala/DPR/output" \
	--learning_rate 2e-05 \
	--num_train_epochs 1 \
	--dev_batch_size 16 \
 	--val_av_rank_start_epoch 1
python generate_dense_embeddings.py \
	--model_file "/home/ahamsala/projects/def-ehyangit/ahamsala/DPR/output/dpr_biencoder.0.919" \
	--ctx_file "/home/ahamsala/projects/def-ehyangit/ahamsala/DPR/data/wikipedia_split/psgs_w100_subset.tsv" \
	--shard_id 0 \
  --num_shards 1 \
	--out_file "data/inference"
python dense_retriever.py \
	--model_file "/home/ahamsala/projects/def-ehyangit/ahamsala/DPR/output/dpr_biencoder.0.919" \
	--ctx_file "/home/ahamsala/projects/def-ehyangit/ahamsala/DPR/data/wikipedia_split/psgs_w100_subset.tsv" \
	--qa_file "data/retriever/nq-test.qa.csv" \
	--encoded_ctx_file "data/inference_0.pkl" \
	--out_file "data/result" \
	--n-docs 10 \
	--validation_workers 16 \
	--batch_size 32
