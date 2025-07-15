#!/bin/bash
#FLUX: --job-name=placid-arm-7743
#FLUX: -c=6
#FLUX: --queue=batch
#FLUX: -t=21600
#FLUX: --priority=16

conda activate faclab
python train_conditional_doors.py --tuples 3 --dec_layer=12 --dim=264 --enc_layer=16 --lr 0.00015 --lifull True
