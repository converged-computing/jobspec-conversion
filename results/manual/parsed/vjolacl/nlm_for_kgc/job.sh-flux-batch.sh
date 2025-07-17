#!/bin/bash
#FLUX: --job-name=placid-car-5012
#FLUX: -n=40
#FLUX: --queue=gpu_4
#FLUX: -t=21600
#FLUX: --urgency=16

export PATH='/opt/intel/intelpython3/bin:$PATH'

export PATH="/opt/intel/intelpython3/bin:$PATH"
cd /pfs/data5/home/kit/aifb/ho8030/
nvidia-smi
source activate testenv
which python3
wandb login 5412702c3ad751442cbd9ac96d56a4ccbca97f1e
python3 04_py_files/run_kg_nlm.py
