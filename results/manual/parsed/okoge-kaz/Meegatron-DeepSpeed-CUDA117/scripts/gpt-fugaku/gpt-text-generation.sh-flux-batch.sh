#!/bin/bash
#FLUX: --job-name=gpt
#FLUX: -t=86400
#FLUX: --urgency=16

. /etc/profile.d/modules.sh
module load cuda/11.7
module load cudnn/cuda-11.x/8.9.0
module load nccl/cuda-11.7/2.14.3
module load openmpi/4.0.5
source .env/bin/activate
CHECKPOINT_PATH=checkpoints/gpt-fugaku/350m_dp512
VOCAB_FILE=gpt2-vocab.json
MERGE_FILE=gpt2-merges.txt
MAX_OUTPUT_SEQUENCE_LENGTH=1024
TEMPERATURE=1.0
TOP_P=0.9
NUMBER_OF_SAMPLES=2
OUTPUT_FILE=text-generation.json
INPUT_PREFIX=dataset
python tools/generate_samples_gpt.py \
  --num-layers 24 \
  --hidden-size 1024 \
  --num-attention-heads 16 \
  --micro-batch-size 64 \
  --global-batch-size 512 \
  --seq-length 1024 \
  --max-position-embeddings 1024 \
  --vocab-file $INPUT_PREFIX/$VOCAB_FILE \
  --merge-file $INPUT_PREFIX/$MERGE_FILE \
  --data-impl mmap \
  --split 949,50,1 \
  --load $CHECKPOINT_PATH \
  --out-seq-length $MAX_OUTPUT_SEQUENCE_LENGTH \
  --temperature $TEMPERATURE \
  --genfile $OUTPUT_FILE \
  --num-samples $NUMBER_OF_SAMPLES \
  --top_p $TOP_P \
  --recompute
