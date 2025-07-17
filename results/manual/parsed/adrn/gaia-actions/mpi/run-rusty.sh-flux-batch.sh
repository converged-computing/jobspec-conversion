#!/bin/bash
#FLUX: --job-name=actions
#FLUX: -N=12
#FLUX: --queue=cca
#FLUX: -t=129600
#FLUX: --urgency=16

source ~/.bash_profile
cd /mnt/ceph/users/apricewhelan/projects/gaia-actions/scripts
init_env
date
mpirun python compute_actions.py -v --mpi --staeckel \
    -f ../data/a23_tab2_bjcoords.h5 \
    --id-col=source_id \
    -p ../potentials/MilkyWayPotential2022.yml \
    --dist-col=r_med_geo_kpc
date
