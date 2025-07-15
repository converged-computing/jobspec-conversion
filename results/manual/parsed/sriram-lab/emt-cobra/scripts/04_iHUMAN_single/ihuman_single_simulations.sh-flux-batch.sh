#!/bin/bash
#FLUX: --job-name=ihuman_emt_a549_1
#FLUX: --queue=standard
#FLUX: -t=259200
#FLUX: --priority=16

module load matlab/R2020a
module load gurobi
matlab -nodisplay -r "run('/home/scampit/Turbo/scampit/Software/emt/srv/ihuman_scCOBRA.m'); exit"
