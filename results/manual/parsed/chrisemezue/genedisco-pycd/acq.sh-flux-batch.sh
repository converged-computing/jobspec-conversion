#!/bin/bash
#FLUX: --job-name=genedisco_special_acquisition
#FLUX: --queue=long
#FLUX: -t=172800
#FLUX: --urgency=16

export CUBLAS_WORKSPACE_CONFIG=':4096:8'
export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/home/mila/c/chris.emezue/genedisco/genv/lib'

module load python/3.8
module load cuda/11.1/cudnn/8.0
source /home/mila/c/chris.emezue/genedisco/genv/bin/activate
export CUBLAS_WORKSPACE_CONFIG=:4096:8
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/home/mila/c/chris.emezue/genedisco/genv/lib"
CACHE_NAME=cache_test
OUTPUT_NAME=output_test
CACHE_DIR=/home/mila/c/chris.emezue/genedisco/${CACHE_NAME}
OUTPUT_DIR=/home/mila/c/chris.emezue/genedisco/${OUTPUT_NAME}
mkdir -p $CACHE_DIR
mkdir -p $OUTPUT_DIR
active_learning_loop  \
    --cache_directory=$CACHE_DIR  \
    --output_directory=$OUTPUT_DIR  \
    --model_name="bayesian_mlp" \
    --acquisition_function_name="custom" \
    --acquisition_function_path=/home/mila/c/chris.emezue/genedisco/genedisco/active_learning_methods/acquisition_functions/rnd.py \
    --acquisition_batch_size=64 \
    --num_active_learning_cycles=8 \
    --feature_set_name="achilles" \
    --dataset_name="schmidt_2021_ifng" 
 #   --model_name="bayesian_mlp" \
 #   --acquisition_function_name="coreset" \
 #   --acquisition_batch_size=64 \
 #   --num_active_learning_cycles=8 \
 #   --feature_set_name="achilles" \
 #   --dataset_name="schmidt_2021_ifng" 
