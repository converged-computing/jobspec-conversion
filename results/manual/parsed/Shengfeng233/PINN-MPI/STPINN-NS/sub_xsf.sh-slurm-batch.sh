#!/bin/bash
#FLUX: --job-name=xsf_mpi
#FLUX: --exclusive
#FLUX: --queue=wzhcnormal
#FLUX: -t=2160000
#FLUX: --urgency=16

export PATH='~/soft/miniconda/bin:$PATH'

export PATH="~/soft/miniconda/bin:$PATH"
source activate pytorch
python pre_train.py
mpiexec -n 40 python main.py
