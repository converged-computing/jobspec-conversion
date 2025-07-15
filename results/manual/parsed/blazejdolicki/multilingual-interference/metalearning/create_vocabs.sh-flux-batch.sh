#!/bin/bash
#FLUX: --job-name=ConcatTreebanks
#FLUX: --queue=gpu_shared_course
#FLUX: -t=3600
#FLUX: --priority=16

module purge
module load 2019
module load Python/3.7.5-foss-2019b
module load Python/3.7.5-foss-2019b
module load CUDA/10.1.243
module load cuDNN/7.6.5.32-CUDA-10.1.243
module load NCCL/2.5.6-CUDA-10.1.243
module load Anaconda3/2018.12
source activate atcs-project
DATA_DIR="data"
TREEBANK="concat-exp-mix"
OUTPUT_DIR="data/concat-exp-mix/vocab"
srun python create_vocabs.py --dataset_dir ${DATA_DIR} --output_dir ${OUTPUT_DIR} --treebanks ${TREEBANK}
