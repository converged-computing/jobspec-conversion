#!/bin/bash
#FLUX: --job-name=basaran_wizardlm
#FLUX: -t=36000
#FLUX: --priority=16

module load devel/python/3.8.6_intel_19.1
module load devel/cuda/11.6
source /path/to/venv/bin/activate
MODEL=WizardLM/WizardLM-13B-V1.1 MODEL_TRUST_REMOTE_CODE=true PORT=10127 python -m basaran
