#!/bin/bash
#FLUX: --job-name=gwecc-search
#FLUX: --urgency=16

/home/susobhan/Data/susobhan/miniconda/envs/gwecc/bin/activate
PYTHON=$CONDA_PREFIX/bin/python
JULIA=$CONDA_PREFIX/bin/julia
source print_info.sh
echo
$PYTHON run_1psr_analysis.py fix-wn_vary-rn_no-ecw.json
