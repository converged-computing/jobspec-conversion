#!/bin/bash
#FLUX: --job-name=outstanding-avocado-4899
#FLUX: -c=8
#FLUX: --queue=seas_gpu
#FLUX: -t=360
#FLUX: --urgency=16

export HOME='/n/holylabs/LABS/idreos_lab/Users/azhao'

module load python/3.10.12-fasrc01
module load cuda/12.0.1-fasrc01
module load cudnn/8.9.2.26_cuda12-fasrc01
module load gcc/9.5.0-fasrc01
export HOME=/n/holylabs/LABS/idreos_lab/Users/azhao
mamba create -p $HOME/env -y python=3.10
mamba activate $HOME/env
module load cmake
mamba install -y astunparse numpy ninja pyyaml setuptools cmake cffi typing_extensions future six requests dataclasses ccache protobuf numba cython expecttest hypothesis psutil sympy mkl mkl-include git-lfs libpng
mamba install -y -c conda-forge tqdm
mamba install -y -c huggingface transformers
mamba install -y -c pytorch magma-cuda121
python -m pip install triton
python -m pip install pyre-extensions
python -m pip install torchrec
python -m pip install --index-url https://download.pytorch.org/whl/test/ pytorch-triton==3.0.0
