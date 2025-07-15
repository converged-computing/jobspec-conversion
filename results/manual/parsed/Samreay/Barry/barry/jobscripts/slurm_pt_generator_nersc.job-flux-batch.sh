#!/bin/bash
#FLUX: --job-name=quirky-bike-7247
#FLUX: -n=20
#FLUX: --urgency=16

source ~/.bashrc.ext
source /global/common/software/desi/users/adematti/cosmodesi_environment.sh main
echo "Activated python"
echo `which python`
cd {path}
mpirun python precompute_mpi.py --model {model} --reconsmoothscale {reconsmoothscale} --redshift {z} --om {om} --h0 {h0} --ob {ob} --ns {ns} --mnu {mnu}
