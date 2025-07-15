#!/bin/bash
#FLUX: --job-name=hairy-hobbit-9247
#FLUX: --priority=16

module load python
source ~/.bashrc
conda activate outerhalo
cd /n/home03/vchandra/outerhalo/08_mage/
python -u 00_xmatch_phot.py
