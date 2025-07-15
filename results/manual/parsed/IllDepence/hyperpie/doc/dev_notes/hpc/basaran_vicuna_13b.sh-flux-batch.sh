#!/bin/bash
#FLUX: --job-name=basaran_vicuna13b
#FLUX: -t=36000
#FLUX: --priority=16

module load devel/python/3.8.6_intel_19.1
module load devel/cuda/11.6
source /path/to/venv/bin/activate
MODEL=lmsys/vicuna-13b-v1.3 MODEL_TRUST_REMOTE_CODE=true PORT=10127 python -m basaran
