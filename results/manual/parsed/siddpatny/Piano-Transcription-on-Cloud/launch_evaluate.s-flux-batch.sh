#!/bin/bash
#FLUX: --job-name=evalonsets1
#FLUX: -c=10
#FLUX: -t=18000
#FLUX: --urgency=16

module load python3/intel/3.6.3 cuda/9.0.176 nccl/cuda9.0/2.4.2
python evaluate.py runs/model/model-21000.pt --save-path output/
