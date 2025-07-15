#!/bin/bash
#FLUX: --job-name=lovable-parsnip-1230
#FLUX: --urgency=16

export MPICC='mpicc'
export MPICXX='mpicxx'

cd ~
mkdir -p .envs
module purge
module use ~/environment-modules-lisa
module load 2020
module load Python/3.7.4-GCCcore-8.3.0
module unload 2019
module unload GCC
module unload GCCcore
module unload binutils
module unload zlib
module unload compilerwrappers
module load OpenMPI/3.1.4-GCC-8.3.0
module load libyaml/0.2.2-GCCcore-8.3.0
export MPICC=mpicc
export MPICXX=mpicxx
python3 -m venv ~/.envs/env_recdistr
source ~/.envs/env_recdistr/bin/activate
pip3 install pyyaml
pip3 install torch==1.5.0+cu101 torchvision==0.6.0+cu101 -f https://download.pytorch.org/whl/torch_stable.html
cd ~/dnn-benchmark-suite/run
pip3 install -r requirements.txt
cd ~
module list
pip3 freeze
cd ~/dnn-benchmark-suite/benchmark
python3 network_summary.py
