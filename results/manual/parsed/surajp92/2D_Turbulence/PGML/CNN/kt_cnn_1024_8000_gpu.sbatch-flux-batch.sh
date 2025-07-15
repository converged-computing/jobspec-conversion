#!/bin/bash
#FLUX: --job-name=crusty-butter-1266
#FLUX: --priority=16

module load cuda/11.0
python DHIT_CNN_apriori_sgs_TF2.py 
