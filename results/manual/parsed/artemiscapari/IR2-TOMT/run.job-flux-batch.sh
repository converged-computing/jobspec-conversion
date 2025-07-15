#!/bin/bash
#FLUX: --job-name=TrainVAE
#FLUX: -c=3
#FLUX: --queue=gpu_shared_course
#FLUX: -t=162000
#FLUX: --priority=16

export CUDA_HOME='/usr/local/cuda-10.0'
export PATH='${CUDA_HOME}/bin:${PATH}'
export LIBRARY_PATH='${CUDA_HOME}/lib64:${LIBRARY_PATH}'
export LD_LIBRARY_PATH='${CUDA_HOME}/lib64:${LD_LIBRARY_PATH}'

source ${HOME}/.bashrc
export CUDA_HOME="/usr/local/cuda-10.0"
export PATH="${CUDA_HOME}/bin:${PATH}"
export LIBRARY_PATH="${CUDA_HOME}/lib64:${LIBRARY_PATH}"
export LD_LIBRARY_PATH="${CUDA_HOME}/lib64:${LD_LIBRARY_PATH}"
module load 2021
module load Java/11.0.2
conda activate tomt2
python train.py --model_name sentence-transformers/all-MiniLM-L6-v2 --train_size 1000 --eval_size 1300 --test_size 1300 --train_eval_size 1000 --bm25_topk 100 --eval_batch_size 200 --evals_per_epoch 5 --loss_fn multi-neg
python train.py --model_name sentence-transformers/all-MiniLM-L6-v2 --train_size 5000 --eval_size 1300 --test_size 1300 --train_eval_size 5000 --bm25_topk 100 --eval_batch_size 200 --evals_per_epoch 5 --loss_fn multi-neg
python train.py --model_name sentence-transformers/all-MiniLM-L6-v2 --train_size 10000 --eval_size 1300 --test_size 1300 --train_eval_size 10000 --bm25_topk 100 --eval_batch_size 200 --evals_per_epoch 5 --loss_fn multi-neg
python train.py --model_name sentence-transformers/all-MiniLM-L6-v2 --train_size 5000 --eval_size 1300 --test_size 1300 --train_eval_size 5000 --bm25_topk 1000 --eval_batch_size 200 --evals_per_epoch 5 --loss_fn multi-neg
python train.py --model_name sentence-transformers/all-MiniLM-L6-v2 --train_size 1000 --eval_size 1300 --test_size 1300 --train_eval_size 1000 --bm25_topk 100 --eval_batch_size 200 --evals_per_epoch 5 --loss_fn cos-sim
python train.py --model_name sentence-transformers/all-mpnet-base-v2 --train_size 1000 --eval_size 1300 --test_size 1300 --train_eval_size 1000 --bm25_topk 100 --eval_batch_size 200 --evals_per_epoch 5 --loss_fn multi-neg
python train.py --model_name sentence-transformers/all-mpnet-base-v2 --train_size 5000 --eval_size 1300 --test_size 1300 --train_eval_size 5000 --bm25_topk 100 --eval_batch_size 200 --evals_per_epoch 5 --loss_fn multi-neg
python train.py --model_name sentence-transformers/all-mpnet-base-v2 --train_size 10000 --eval_size 1300 --test_size 1300 --train_eval_size 10000 --bm25_topk 100 --eval_batch_size 200 --evals_per_epoch 5 --loss_fn multi-neg
python train.py --model_name sentence-transformers/all-mpnet-base-v2 --train_size 5000 --eval_size 1300 --test_size 1300 --train_eval_size 5000 --bm25_topk 1000 --eval_batch_size 200 --evals_per_epoch 5 --loss_fn multi-neg
python train.py --model_name sentence-transformers/all-mpnet-base-v2 --train_size 1000 --eval_size 1300 --test_size 1300 --train_eval_size 1000 --bm25_topk 100 --eval_batch_size 200 --evals_per_epoch 5 --loss_fn cos-sim
python train.py --model_name cross-encoder/ms-marco-TinyBERT-L-2-v2 --train_size 1000 --eval_size 100 --test_size 100 --train_eval_size 100 --bm25_topk 100 --eval_batch_size 200 --evals_per_epoch 5
python train.py --model_name cross-encoder/ms-marco-TinyBERT-L-2-v2 --train_size 5000 --eval_size 100 --test_size 100 --train_eval_size 100 --bm25_topk 100 --eval_batch_size 200 --evals_per_epoch 5
python train.py --model_name cross-encoder/ms-marco-TinyBERT-L-2-v2 --train_size 10000 --eval_size 100 --test_size 100 --train_eval_size 100 --bm25_topk 100 --eval_batch_size 200 --evals_per_epoch 5
python train.py --model_name cross-encoder/ms-marco-MiniLM-L-6-v2 --train_size 1000 --eval_size 100 --test_size 100 --train_eval_size 100 --bm25_topk 100 --eval_batch_size 200 --evals_per_epoch 5
python train.py --model_name cross-encoder/ms-marco-MiniLM-L-6-v2 --train_size 5000 --eval_size 100 --test_size 100 --train_eval_size 100 --bm25_topk 100 --eval_batch_size 200 --evals_per_epoch 5
python train.py --model_name cross-encoder/ms-marco-MiniLM-L-6-v2 --train_size 10000 --eval_size 100 --test_size 100 --train_eval_size 100 --bm25_topk 100 --eval_batch_size 200 --evals_per_epoch 5
python plot.py
