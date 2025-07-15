#!/bin/bash
#FLUX: --job-name=cowy-destiny-3994
#FLUX: --urgency=16

source globals.sh
matlab -nodesktop -nosplash -nodisplay -jvm -r "addpath('scripts/'); preprocess_FIR;"
