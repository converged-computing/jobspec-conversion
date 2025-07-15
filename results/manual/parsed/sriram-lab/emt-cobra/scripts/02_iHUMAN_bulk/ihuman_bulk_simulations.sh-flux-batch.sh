#!/bin/bash
#FLUX: --job-name=ihuman_emt_a549_1
#FLUX: -c=16
#FLUX: --queue=standard
#FLUX: -t=18000
#FLUX: --priority=16

module load matlab/R2020a
module load gurobi
matlab -nodisplay -r "run('/home/scampit/Turbo/scampit/Software/emt/srv/ihuman_simulations.m'); exit"
