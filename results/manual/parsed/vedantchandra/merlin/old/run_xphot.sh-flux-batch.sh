#!/bin/bash
#FLUX: --job-name=scruptious-malarkey-9334
#FLUX: --urgency=16

module load python
source ~/.bashrc
conda activate outerhalo
cd /n/home03/vchandra/outerhalo/08_mage/
python -u 00_xmatch_phot.py
