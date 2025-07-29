#!/bin/bash
#FLUX: --job-name=fomes_sim_varyparams
#FLUX: -n=256
#FLUX: -t=432000
#FLUX: --urgency=16

R CMD BATCH 01-run_fomes_on_maestro.R
