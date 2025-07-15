#!/bin/bash
#FLUX: --job-name=tjpcov-clusters-run
#FLUX: -N=8
#FLUX: -n=16
#FLUX: -c=16
#FLUX: -t=7200
#FLUX: --priority=16

input=your_config.yaml
output=your_output.sacc
source /global/common/software/lsst/common/miniconda/setup_current_python.sh
python3 run_tjpcov.py $input -o $output
