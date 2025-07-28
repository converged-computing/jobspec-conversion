#!/bin/bash
#FLUX: --job-name=test-hab
#FLUX: -c=24
#FLUX: -t=600
#FLUX: --urgency=16

module purge
module load gcc cuda
nvidia-smi 1>&2
cd /home/an38gezy/thesis/cf-habitat
python main.py --run-type both --exp-config configs/experiments/crazyflie_baseline_rgb.yaml
