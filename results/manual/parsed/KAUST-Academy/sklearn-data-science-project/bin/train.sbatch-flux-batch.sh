#!/bin/bash
#FLUX: --job-name=hello-puppy-7427
#FLUX: -c=4
#FLUX: --queue=batch
#FLUX: -t=7200
#FLUX: --urgency=16

set -e
module purge
ENV_PREFIX="$PROJECT_DIR"/env
conda activate $ENV_PREFIX
python "$1"
