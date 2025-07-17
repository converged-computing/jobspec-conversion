#!/bin/bash
#FLUX: --job-name=trainExample
#FLUX: --queue=common
#FLUX: -t=255600
#FLUX: --urgency=16

export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'
export PATH='/scidatalg/reformer-tts/miniconda3/bin:$PATH'

export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
__conda_setup="$('/scidatalg/reformer-tts/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
eval "$__conda_setup"
else
if [ -f "/scidatalg/reformer-tts/miniconda3/etc/profile.d/conda.sh" ]; then
. "/scidatalg/reformer-tts/miniconda3/etc/profile.d/conda.sh"
else
export PATH="/scidatalg/reformer-tts/miniconda3/bin:$PATH"
fi
fi
unset __conda_setup
cd /scidatalg/reformer-tts/reformer-tts || exit 1
conda activate reformer-tts
conda env update -f environment.yml
pip install -e .
echo "Visible devices: $CUDA_VISIBLE_DEVICES"
echo "Device load:"
/usr/bin/nvidia-smi
python -O -m reformer_tts.cli \
  --config /scidatalg/reformer-tts/reformer-tts/config/entrpy-reformer-lj.yml \
  train-tts \
  --resume '/results/reformer-tts/reformer-tts_ljtc2_double-loss_entropy/epoch=10-val_loss=0.32.ckpt'
