#!/bin/bash
#SBATCH --job-name=clipping1
#SBATCH --output=/results/reformer-tts/clipping1.out
#SBATCH --error=/results/reformer-tts/clipping1.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=2-23:00:00
#SBATCH --qos=2gpu3d
#SBATCH --constraint=homedir

export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'

export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
__conda_setup="$('/home/mo382777/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/mo382777/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/mo382777/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/mo382777/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
cd /home/mo382777/reformer-tts || exit 1
conda activate reformer-tts
conda env update -f environment.yml
pip install -e .
echo "Visible devices: $CUDA_VISIBLE_DEVICES"
echo "Device load:"
/usr/bin/nvidia-smi
python -O -m reformer_tts.cli \
  --config /home/mo382777/reformer-tts/config/regularization-exp2.yml \
  train-tts
