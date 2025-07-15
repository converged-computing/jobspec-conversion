#!/bin/bash
#FLUX: --job-name=sbc_cp_ksc_model_cp_dgf_10kmcmc_3000_niter_r1
#FLUX: -c=40
#FLUX: -t=43200
#FLUX: --priority=16

R --vanilla < scripts/sim_ksc_results.r
