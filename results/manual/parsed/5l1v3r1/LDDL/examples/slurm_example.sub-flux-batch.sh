#!/bin/bash
#FLUX: --job-name=expensive-milkshake-6958
#FLUX: --exclusive
#FLUX: --urgency=16

set -eux
readonly docker_image=${DOCKER_IMAGE:-"lddl:latest"}
mkdir -p data/
readonly wikipedia_path=data/wikipedia
readonly vocab_source_url=https://raw.githubusercontent.com/NVIDIA/DeepLearningExamples/master/PyTorch/LanguageModeling/BERT/vocab/vocab
mkdir -p data/vocab/
readonly vocab_path=data/vocab/bert-en-uncased.txt
wget ${vocab_source_url} -O ${vocab_path}
readonly mounts=$(realpath data/):/workspace/lddl/data
readonly workdir=/workspace/lddl
readonly num_shards=4096
readonly bin_size=64
readonly tasks_per_node=128
readonly pretrain_input_path=data/bert/pretrain/phase2/bin_size_${bin_size}/
srun \
  -l \
  --mpi=pmix \
  --container-image="${docker_image}" \
  --container-mounts="${mounts}" \
  --container-workdir=${workdir} \
  --ntasks-per-node=${tasks_per_node} \
  --export=ALL,LD_PRELOAD=/opt/conda/lib/libjemalloc.so \
    preprocess_bert_pretrain \
      --schedule mpi \
      --vocab-file ${vocab_path} \
      --wikipedia ${wikipedia_path}/source/ \
      --sink ${pretrain_input_path} \
      --target-seq-length 512 \
      --num-blocks ${num_shards} \
      --bin-size ${bin_size} \
      --masking
srun \
  -l \
  --mpi=pmix \
  --container-image="${docker_image}" \
  --container-mounts="${mounts}" \
  --container-workdir=${workdir} \
  --ntasks-per-node=${tasks_per_node} \
    balance_dask_output \
      --indir ${pretrain_input_path} \
      --num-shards ${num_shards}
readonly gpus_per_node=8
srun \
  -l \
  --container-image="${docker_image}" \
  --container-mounts="${mounts}" \
  --container-workdir=${workdir} \
  --ntasks-per-node=${gpus_per_node} \
    python benchmarks/torch_train.py \
      --path ${pretrain_input_path} \
      --vocab-file ${vocab_path} 
