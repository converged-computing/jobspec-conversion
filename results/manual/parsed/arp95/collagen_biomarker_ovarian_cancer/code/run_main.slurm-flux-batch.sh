#!/bin/bash
#FLUX: --job-name="features9"
#FLUX: -t=313200
#FLUX: --priority=16

module swap intel gcc
module load python/3.7.0
module load matlab
cd /mnt/rstor/CSE_BME_AXM788/home/axa1399/collagen_biomarker_ovarian_cancer/code/
time matlab -nodisplay -r main_2
