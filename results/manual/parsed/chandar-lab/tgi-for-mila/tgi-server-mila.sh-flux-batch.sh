#!/bin/bash
#FLUX: --job-name=tgi-server
#FLUX: -c=4
#FLUX: --gpus-per-task=1
#FLUX: -t=10740
#FLUX: --urgency=16

export PATH='$(realpath $RELEASE_DIR/bin/)":$PATH'
export LD_LIBRARY_PATH='$TGI_TMP/pyenv/lib:$LD_LIBRARY_PATH'
export HF_HUB_OFFLINE='1'
export HF_DATASETS_OFFLINE='1'
export TRANSFORMERS_OFFLINE='1'
export HF_HUB_DISABLE_TELEMETRY='1'
export HF_HUB_ENABLE_HF_TRANSFER='1'
export HUGGINGFACE_HUB_CACHE='$TGI_DIR/tgi-data'

set -e
TGI_VERSION='1.4.4'
FLASH_ATTN_VERSION='2.3.2'
if [ -z "${RELEASE_DIR}" ]; then
    RELEASE_DIR=$HOME/tgi-release
fi
if [ -z "${TGI_DIR}" ]; then
    TGI_DIR=$SCRATCH/tgi
fi
if [ -z "${TGI_TMP}" ]; then
    TGI_TMP=$SLURM_TMPDIR/tgi
fi
eval "$(~/bin/micromamba shell hook -s posix)"
micromamba create -y -p $TGI_TMP/pyenv -c pytorch -c "nvidia/label/cuda-12.1.1" -c "nvidia/label/cuda-12.1.0" -c conda-forge --channel-priority flexible 'python=3.11' 'git-lfs=3.3' 'pyarrow=14.0.2' 'pytorch==2.1.1' 'pytorch-cuda=12.1' cuda-nvcc cuda-toolkit cuda-libraries-dev 'cudnn=8.8' 'openssl=3' 'ninja=1'
micromamba activate $TGI_TMP/pyenv
pip install --no-index --find-links $RELEASE_DIR/python_deps \
  $RELEASE_DIR/python_ins/flash_attn-*.whl $RELEASE_DIR/python_ins/vllm-*.whl \
  $RELEASE_DIR/python_ins/rotary_emb-*.whl $RELEASE_DIR/python_ins/dropout_layer_norm-*.whl \
  $RELEASE_DIR/python_ins/awq_inference_engine-*.whl $RELEASE_DIR/python_ins/EETQ-*.whl \
  $RELEASE_DIR/python_ins/exllama_kernels-*.whl $RELEASE_DIR/python_ins/exllamav2_kernels-*.whl \
  $RELEASE_DIR/python_ins/custom_kernels-*.whl $RELEASE_DIR/python_ins/megablocks-*.whl \
  $RELEASE_DIR/python_ins/causal_conv1d-*.whl $RELEASE_DIR/python_ins/mamba_ssm-*.whl \
  "$RELEASE_DIR/python_ins/text_generation_server-$TGI_VERSION-py3-none-any.whl[bnb, accelerate, quantize, peft, outlines]"
export PATH="$(realpath $RELEASE_DIR/bin/)":$PATH
export LD_LIBRARY_PATH=$TGI_TMP/pyenv/lib:$LD_LIBRARY_PATH
export HF_HUB_OFFLINE=1
export HF_DATASETS_OFFLINE=1
export TRANSFORMERS_OFFLINE=1
export HF_HUB_DISABLE_TELEMETRY=1
export HF_HUB_ENABLE_HF_TRANSFER=1
export HUGGINGFACE_HUB_CACHE=$TGI_DIR/tgi-data
default_num_shard=$(python -c 'import torch; print(torch.cuda.device_count())')
default_port=$(expr 10000 + $(echo -n $SLURM_JOBID | tail -c 4))
default_master_port=$(expr 20000 + $(echo -n $SLURM_JOBID | tail -c 4))
default_shard_usd_path=$TGI_TMP/socket
default_model_path=$TGI_DIR/tgi-repos/$MODEL_ID
rsync --archive --exclude='.git/' --update --delete --verbose --human-readable --whole-file --inplace --no-compress --progress ${MODEL_PATH:-$default_model_path}/ $TGI_TMP/model
text-generation-launcher \
  --model-id $TGI_TMP/model --num-shard "${NUM_SHARD:-$default_num_shard}" \
  --port "${PORT:-$default_port}" \
  --master-port "${MASTER_PORT:-$default_master_port}" \
  --shard-uds-path "${SHARD_UDS_PATH:-$default_shard_usd_path}"
  # --max-best-of $MAX_BEST_OF --max-total-tokens $MAX_STOP_SEQUENCES
  # --max-input-length $MAX_INPUT_LENGTH --max-stop-sequences $MAX_TOTAL_TOKENS --quantize $QUANTIZE
