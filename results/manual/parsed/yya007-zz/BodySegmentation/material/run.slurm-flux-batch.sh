#!/bin/bash
#FLUX: --job-name=eccentric-leg-1707
#FLUX: -n=4
#FLUX: --queue=maxwell
#FLUX: -t=432000
#FLUX: --urgency=16

setpkgs -a tensorflow_0.12
source activate FCN
cd /scratch/yaoy4/BodySegmentation 
python run.py norandom test1
