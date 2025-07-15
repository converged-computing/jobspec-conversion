#!/bin/bash
#FLUX: --job-name=blue-nunchucks-2772
#FLUX: --queue=stf-gpu
#FLUX: -t=324000
#FLUX: --urgency=16

source ~/.login
module load icc_17-impi_2017
module load cuda/10.1.105_418.39
mpiexec -np 2 python model_analysis.py --model SE3ResNet34Small --data-filename cath_3class_ca.npz --training-epochs 100 --batch-size 8 --restore-checkpoint-filename trial_8_latest.ckpt
