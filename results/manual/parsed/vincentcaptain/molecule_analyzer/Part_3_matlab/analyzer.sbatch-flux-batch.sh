#!/bin/bash
#FLUX: --job-name=isobutane_matlab
#FLUX: -t=604800
#FLUX: --priority=16

ml load matlab
matlab -r main_train_isobutane_new
