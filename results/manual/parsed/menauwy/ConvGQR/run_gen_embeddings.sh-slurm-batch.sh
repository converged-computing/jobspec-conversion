#!/bin/bash
#SBATCH --job-name=gen_topic_adapt_embeddiings
#SBATCH --output=%x_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:4g.40gb:1
#SBATCH --time=7-00:00:00

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
