#!/bin/bash
#FLUX: --job-name=reformer-clipping-dropout
#FLUX: --queue=common
#FLUX: -t=241200
#FLUX: --priority=16

export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'

export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
__conda_setup="$('/home/kk385830/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/kk385830/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/kk385830/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/kk385830/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
cd /home/kk385830/reformer-tts || exit 1
conda activate reformer-tts
conda env update -f environment.yml
pip install -e .
echo "Visible devices: $CUDA_VISIBLE_DEVICES"
echo "Device load:"
/usr/bin/nvidia-smi
python -O -m reformer_tts.cli \
  --config /home/kk385830/reformer-tts/config/entropy-reformer-lj-dropout-clipping.yml \
  train-tts
