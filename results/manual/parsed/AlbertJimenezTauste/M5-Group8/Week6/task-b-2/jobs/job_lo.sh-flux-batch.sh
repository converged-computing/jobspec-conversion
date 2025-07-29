#!/bin/bash
#FLUX --job-name=peachy-mango-2422
#FLUX -n=4
#FLUX --queue=mlow
#FLUX --urgency=16

python ../train_synth_bw.py -p mlow
