#!/bin/bash
#FLUX: --job-name=dinosaur-noodle-8172
#FLUX: -n=4
#FLUX: --queue=mlow
#FLUX: --urgency=16

python ../train_synth_bw.py -p mlow
