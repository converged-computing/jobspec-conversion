#!/bin/bash
#FLUX: --job-name=testing
#FLUX: -c=4
#FLUX: --queue=mtech
#FLUX: --urgency=16

module load python/3.10.pytorch
python3 cGANS.py &> cGAN_run_wcgan_aux.txt &
nvidia-smi &
wait
