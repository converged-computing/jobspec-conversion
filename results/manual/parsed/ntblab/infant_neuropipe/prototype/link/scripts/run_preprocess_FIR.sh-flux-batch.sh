#!/bin/bash
#FLUX: --job-name=joyous-signal-3278
#FLUX: --priority=16

source globals.sh
matlab -nodesktop -nosplash -nodisplay -jvm -r "addpath('scripts/'); preprocess_FIR;"
