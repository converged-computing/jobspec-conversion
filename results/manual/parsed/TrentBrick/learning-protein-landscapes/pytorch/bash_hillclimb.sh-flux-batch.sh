#!/bin/bash
#FLUX: --job-name=placid-bits-1165
#FLUX: -c=20
#FLUX: --queue=short
#FLUX: -t=719
#FLUX: --urgency=16

                                           # -N 1 means all cores will be on th$
hostname
pwd
srun stdbuf -oL -eL ~/anaconda3/bin/python run.py --exp_base_name test_tenSteps \
--run_model main_climb.py --protein_len 0 --nwalkers 64 --nsteps 10 --ncores 20 --print_every 200
