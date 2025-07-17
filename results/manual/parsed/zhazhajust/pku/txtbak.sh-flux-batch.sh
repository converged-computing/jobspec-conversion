#!/bin/bash
#FLUX: --job-name=txtbak
#FLUX: --queue=C032M0256G
#FLUX: --urgency=15

module load anaconda/2-4.4.0.1
python  txtbak.py
