#!/bin/bash
#FLUX: --job-name=strawberry-egg-0482
#FLUX: --priority=16

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
for samples in 50 100 250 500 1000 2500 5000
do
    python -m downstream.resnet.train -c pathmnist -epochs 500 -samples $samples -fout baseline-pathmnist-$samples-samples
    python -m downstream.resnet.train -c dermamnist -epochs 500 -samples $samples -fout baseline-dermamnist-$samples-samples
    python -m downstream.resnet.train -c bloodmnist -epochs 500 -samples $samples -fout baseline-bloodmnist-$samples-samples
done
python -m downstream.resnet.train -c pathmnist -epochs 500 -fout baseline-pathmnist
python -m downstream.resnet.train -c dermamnist -epochs 500 -fout baseline-dermamnist
python -m downstream.resnet.train -c bloodmnist -epochs 500 -fout baseline-bloodmnist
