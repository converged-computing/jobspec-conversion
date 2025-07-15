#!/bin/bash
#FLUX: --job-name=moolicious-nalgas-2808
#FLUX: --urgency=16

module load cuda/11.0
python DHIT_CNN_apriori_sgs_TF2.py 
