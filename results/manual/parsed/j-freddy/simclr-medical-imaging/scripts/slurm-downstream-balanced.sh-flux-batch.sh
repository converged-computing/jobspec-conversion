#!/bin/bash
#FLUX: --job-name=delicious-dog-8879
#FLUX: --urgency=16

export LD_LIBRARY_PATH='/vol/bitbucket/${USER}/individual-project-refined/venv/lib/python3.10/site-packages/nvidia/cublas/lib:${LD_LIBRARY_PATH}'
export PATH='/vol/bitbucket/${USER}/individual-project-refined/venv/bin/:$PATH'

. /vol/cuda/11.7.1/setup.sh
export LD_LIBRARY_PATH=/vol/bitbucket/${USER}/individual-project-refined/venv/lib/python3.10/site-packages/nvidia/cublas/lib:${LD_LIBRARY_PATH}
TERM=vt100                # or TERM=xterm
/usr/bin/nvidia-smi
uptime
cd individual-project-refined
export PATH=/vol/bitbucket/${USER}/individual-project-refined/venv/bin/:$PATH
source activate
for spc in 10 25 100
do
    # LR: pathmnist & path-dermamnist
    python -m downstream.logistic_regression.train -c dermamnist -epochs 1000 -spc $spc -fin pretrain-pathmnist -fout downstream-dermamnist-$spc-spc-path
    python -m downstream.logistic_regression.train -c dermamnist -epochs 1000 -spc $spc -fin pretrain-path-dermamnist -fout downstream-dermamnist-$spc-spc-path-derma
    # Resnet: pathmnist & path-dermamnist
    python -m downstream.resnet.train -c dermamnist -epochs 1000 -spc $spc -fin pretrain-pathmnist -fout downstream-dermamnist-$spc-spc-path
    python -m downstream.resnet.train -c dermamnist -epochs 1000 -spc $spc -fin pretrain-path-dermamnist -fout downstream-dermamnist-$spc-spc-path-derma
done
