#!/bin/bash
#FLUX: --job-name=dinosaur-knife-7161
#FLUX: --queue=bullet
#FLUX: -t=14400
#FLUX: --urgency=16

module load cuda/11.0
python DHIT_CNN_apriori_sgs_TF2.py 
