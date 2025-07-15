#!/bin/bash
#FLUX: --job-name=fugly-malarkey-0672
#FLUX: --queue=C032M0256G
#FLUX: --urgency=16

module load anaconda/2-4.4.0.1
python  txtbak.py
