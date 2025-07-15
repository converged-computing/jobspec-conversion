#!/bin/bash
#FLUX: --job-name=gen_topic_adapt_embeddiings
#FLUX: -c=10
#FLUX: --queue=amd-gpu-long
#FLUX: -t=604800
#FLUX: --priority=16

conda init bash
source ~/.bashrc
conda activate convgqr
echo $CONDA_DEFAULT_ENV
echo $PYTHONPATH
TEST_DIR=$(pwd)
echo "## Current dircectory $TEST_DIR"
echo "## Number of available CUDA devices: $CUDA_VISIBLE_DEVICES"
echo "## Checking status of CUDA device with nvidia-smi"
nvidia-smi
echo "## Generating passages embeddings for topiocqa dataset!"
/data1/wangym/conda/envs/convgqr/bin/python gen_doc_embeddings_adapted.py \
    --config Config/gen_doc_embeddings.toml \
    --saved_block_id=7
