#!/bin/bash
#FLUX: --job-name=blokus_benchmark
#FLUX: -c=128
#FLUX: --queue=medium
#FLUX: -t=14400
#FLUX: --urgency=16

module purge
module load tensorflow/2.15
RLF_BLOCKUS_SCRATCH="/scratch/project_2010270/BlockusGreedy"
PIP_EXE=./venv/bin/pip3
PYTHON_EXE=./venv/bin/python3
if [ ! -d ./venv ]; then
    python3 -m venv venv
    source ./venv/bin/activate
    $PIP_EXE install --upgrade pip
    $PIP_EXE install --extra-index-url https://pypi.nvidia.com tensorrt-bindings==8.6.1 tensorrt-libs==8.6.1 tensorflow[and-cuda]==2.15
    $PIP_EXE install -e ./RLFramework
fi
source ./venv/bin/activate
which python3
which pip3
nvidia-smi
PYTHON_EXE=./venv/bin/python3
$PYTHON_EXE -c "import tensorflow as tf; print(tf.__version__)"
$PYTHON_EXE -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU'))"
$PYTHON_EXE --version
$PYTHON_EXE ./Blockus/benchmark_all.py --folder=$RLF_BLOCKUS_SCRATCH/Models/ \
--num_games=800 \
--num_cpus=100
