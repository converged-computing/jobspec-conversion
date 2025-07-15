#!/bin/bash
#FLUX: --job-name=hello-hobbit-6674
#FLUX: --priority=16

                                           # -N 1 means all cores will be on th$
hostname
pwd
srun stdbuf -oL -eL ~/anaconda3/bin/python run.py --exp_base_name test_tenSteps \
--run_model main_climb.py --protein_len 0 --nwalkers 64 --nsteps 10 --ncores 20 --print_every 200
