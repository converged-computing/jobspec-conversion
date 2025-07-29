#!/bin/bash
#FLUX: --job-name=conspicuous-kitty-1753
#FLUX: -n=4
#FLUX: --queue=mlow
#FLUX: --urgency=16

python ../train_synth_bw.py -p mlow
