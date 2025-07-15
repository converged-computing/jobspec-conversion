#!/bin/bash
#FLUX: --job-name=strawberry-parrot-7689
#FLUX: -c=4
#FLUX: --queue=batch
#FLUX: -t=7200
#FLUX: --priority=16

set -e
module purge
ENV_PREFIX="$PROJECT_DIR"/env
conda activate $ENV_PREFIX
python "$1"
