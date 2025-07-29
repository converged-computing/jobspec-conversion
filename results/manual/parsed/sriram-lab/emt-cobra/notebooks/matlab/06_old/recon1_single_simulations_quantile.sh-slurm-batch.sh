#!/bin/bash
#FLUX: --job-name=recon1_emt_a549_quantile
#FLUX: --queue=standard
#FLUX: -t=86400
#FLUX: --urgency=16

module load matlab/R2018b
module load gurobi/9.1.1
matlab -nodisplay -r "run('/home/scampit/Turbo/scampit/Software/emt-cobra/notebooks/matlab/06_old/quantile_cobra_simulations.m'); exit"
