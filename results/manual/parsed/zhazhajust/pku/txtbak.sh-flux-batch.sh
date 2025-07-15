#!/bin/bash
#FLUX: --job-name=pusheena-general-1063
#FLUX: --queue=C032M0256G
#FLUX: --priority=16

module load anaconda/2-4.4.0.1
python  txtbak.py
