#!/bin/bash
#FLUX: --job-name=isobutane_matlab
#FLUX: --queue=evanreed
#FLUX: -t=604800
#FLUX: --urgency=16

ml load matlab
matlab -r main_train_isobutane_new
