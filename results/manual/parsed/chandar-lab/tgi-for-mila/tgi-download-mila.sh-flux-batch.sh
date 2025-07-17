#!/bin/bash
#FLUX: --job-name=tgi-download
#FLUX: -c=2
#FLUX: -t=3600
#FLUX: --urgency=16

export PATH='$(realpath $RELEASE_DIR/bin/)":$PATH'
export LD_LIBRARY_PATH='$TGI_TMP/pyenv/lib:$LD_LIBRARY_PATH'
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
echo "Downloading ${MODEL_ID}"
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
mkdir -p $TGI_DIR/tgi-data
mkdir -p $TGI_DIR/tgi-repos
export HF_HUB_DISABLE_TELEMETRY=1
export HF_HUB_ENABLE_HF_TRANSFER=1
export HUGGINGFACE_HUB_CACHE=$TGI_DIR/tgi-data
if [[ -z "${HF_TOKEN}" ]]; then
  hf_url=https://huggingface.co
else
  hf_url=https://hf_user:${HF_TOKEN}@huggingface.co
fi
set +e  # ensure we reach `git remote rm origin`
if [ ! -d "${TGI_DIR}/tgi-repos/${MODEL_ID}" ] ; then
    GIT_LFS_SKIP_SMUDGE=1 git clone "${hf_url}/${MODEL_ID}" "${TGI_DIR}/tgi-repos/${MODEL_ID}"
    cd "${TGI_DIR}/tgi-repos/${MODEL_ID}"
    git remote rm origin
    git lfs install
fi
cd "${TGI_DIR}/tgi-repos/${MODEL_ID}"
git remote add origin "${hf_url}/${MODEL_ID}"
if ls *.safetensors 1> /dev/null 2>&1; then
  git lfs pull --exclude "*.bin,*.h5,*.msgpack,events.*,/logs,/coreml"
else
  git lfs pull --exclude "*.h5,*.msgpack,events.*,/logs,/coreml"
fi
git remote rm origin  # remove token reference
set -e
text-generation-server download-weights "${TGI_DIR}/tgi-repos/${MODEL_ID}"
echo "****************************"
echo "* DOWNLOAD JOB SUCCESSFULL *"
echo "****************************"
