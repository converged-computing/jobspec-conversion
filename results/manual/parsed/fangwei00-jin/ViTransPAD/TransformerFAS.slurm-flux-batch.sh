#!/bin/bash
#FLUX: --job-name=arid-leopard-4907
#FLUX: -c=4
#FLUX: --queue=guests
#FLUX: -t=86400
#FLUX: --urgency=16

echo "Just checking!
Starting job on execution node : $(hostname)
Date: $(date)
Waiting ..."
echo "... Running"
python ~/code/Transfomer_FAS/train.py --config configs/OuluNPU.json -i tcp://localhost:12346
