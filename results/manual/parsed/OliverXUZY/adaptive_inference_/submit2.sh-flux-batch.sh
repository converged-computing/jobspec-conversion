#!/bin/bash
#FLUX: --job-name=gloopy-noodle-3386
#FLUX: -c=16
#FLUX: --urgency=16

source ~/.bashrc
echo "======== testing CUDA available ========"
echo "running on machine: " $(hostname -s)
python - << EOF
import torch
print(torch.cuda.is_available())
print(torch.cuda.device_count())
print(torch.cuda.current_device())
print(torch.cuda.device(0))
print(torch.cuda.get_device_name(0))
EOF
echo "======== run with different inputs ========"
python eval_baseline2.py
