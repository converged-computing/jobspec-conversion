#!/bin/bash
#FLUX: --job-name=SAAGmcs
#FLUX: --exclusive
#FLUX: --queue=debug
#FLUX: -t=300
#FLUX: --urgency=16

date
module load python
source activate /global/common/software/m1867/python/pyflex
cd /global/homes/f/feng045/program/PyFLEXTRKR-dev/runscripts
python run_mcs_tbpf_saag.py /global/homes/f/feng045/program/PyFLEXTRKR-dev/config/config_mcs_saag_example.yml
date
