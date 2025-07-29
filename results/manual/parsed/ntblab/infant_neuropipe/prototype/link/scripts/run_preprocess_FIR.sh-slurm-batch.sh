#!/bin/bash
#FLUX: --job-name=hello-hope-9826
#FLUX: --queue=short
#FLUX: -t=14400
#FLUX: --urgency=16

source globals.sh
matlab -nodesktop -nosplash -nodisplay -jvm -r "addpath('scripts/'); preprocess_FIR;"
