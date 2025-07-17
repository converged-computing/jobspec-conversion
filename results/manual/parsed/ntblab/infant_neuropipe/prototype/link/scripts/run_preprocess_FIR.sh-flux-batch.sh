#!/bin/bash
#FLUX: --job-name=expressive-poodle-9053
#FLUX: --queue=short
#FLUX: -t=14400
#FLUX: --urgency=16

source globals.sh
matlab -nodesktop -nosplash -nodisplay -jvm -r "addpath('scripts/'); preprocess_FIR;"
