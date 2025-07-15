#!/bin/bash
#FLUX: --job-name=enkf_4
#FLUX: --queue=guest_gpu
#FLUX: -t=174600
#FLUX: --priority=16

pwd
source activate tensorflow-gpu-2.9-custom
python simplecdr_gcn.py
