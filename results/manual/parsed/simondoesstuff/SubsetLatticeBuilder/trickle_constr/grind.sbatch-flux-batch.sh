#!/bin/bash
#FLUX: --job-name=trickle_constr
#FLUX: -c=64
#FLUX: -t=600
#FLUX: --urgency=16

pwd; hostname; date
echo "You've requested $SLURM_CPUS_ON_NODE core(s)."
singularity exec --writable-tmpfs docker://rust:latest /bin/bash ./build_ancestral_net.sh ../data/dirty/79867.txt ../data/soln/79867.txt
