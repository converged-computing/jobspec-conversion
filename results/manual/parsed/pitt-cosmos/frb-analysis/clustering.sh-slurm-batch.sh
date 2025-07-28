#!/bin/bash
#FLUX: --job-name=REPROCESS_CUTS
#FLUX: --queue=act
#FLUX: -t=324000
#FLUX: --urgency=16

python clustering.py 800 1000
