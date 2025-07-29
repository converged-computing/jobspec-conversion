#!/bin/bash
#FLUX: --job-name=example
#FLUX: --queue=alpha
#FLUX: -t=300
#FLUX: --urgency=16

module load modenv/hiera GCC/10.2.0 CUDA/11.1.1 OpenMPI/4.0.5 PyTorch/1.10.0 tqdm/4.56.2
myworkspace="$(ws_find myworkspace)"
python "$myworkspace"/src/myscript.py
