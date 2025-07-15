#!/bin/bash
#FLUX: --job-name=gloopy-leader-1460
#FLUX: --urgency=16

source activate nlp
python hlt.py
