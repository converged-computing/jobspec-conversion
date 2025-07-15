#!/bin/bash
#FLUX: --job-name=hairy-general-7236
#FLUX: -n=4
#FLUX: --queue=maxwell
#FLUX: -t=432000
#FLUX: --priority=16

setpkgs -a tensorflow_0.12
source activate FCN
cd /scratch/yaoy4/BodySegmentation 
python run.py norandom test1
