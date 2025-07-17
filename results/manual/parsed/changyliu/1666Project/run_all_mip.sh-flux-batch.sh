#!/bin/bash
#FLUX: --job-name=lovely-leopard-5687
#FLUX: -t=57540
#FLUX: --urgency=16

echo "Running on Graham cluster"
module load python/3.8
source /home/liucha90/chang_pytorch/bin/activate
python3.8 runMIPall.py --dataset_name "${dataset_name:="1PDPTW_generated_d21_i1000_tmin300_tmax500_sd2022_test"}"
