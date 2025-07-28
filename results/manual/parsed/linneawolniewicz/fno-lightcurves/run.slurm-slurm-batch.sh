#!/bin/bash
#FLUX: --job-name=fno
#FLUX: -c=6
#FLUX: --queue=koa
#FLUX: -t=2592000
#FLUX: --urgency=16

source ~/profiles/auto.profile
source activate fno
python scripts/fno_signal_classification.py
