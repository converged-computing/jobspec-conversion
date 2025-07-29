#!/bin/bash
#FLUX: --job-name=pusheena-ricecake-9400
#FLUX: --queue=bullet
#FLUX: -t=14400
#FLUX: --urgency=16

module load cuda/11.0
python DHIT_CNN_apriori_sgs_TF2.py 
