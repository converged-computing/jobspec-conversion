#!/bin/bash
#FLUX: --job-name=gloopy-leopard-6582
#FLUX: --queue=conroy_priority,test,shared,itc_cluster
#FLUX: -t=120
#FLUX: --urgency=16

module load python
source ~/.bashrc
conda activate outerhalo
cd /n/home03/vchandra/outerhalo/08_mage/
python -u 00_xmatch_phot.py
