#!/bin/bash
#FLUX: --job-name=basaran_galactica
#FLUX: -t=25200
#FLUX: --urgency=16

module load devel/python/3.8.6_intel_19.1
module load devel/cuda/11.6
source /path/to/venv/bin/activate
MODEL=facebook/galactica-120b MODEL_HALF_PRECISION=true MODEL_TRUST_REMOTE_CODE=true PORT=10127 python -m basaran
