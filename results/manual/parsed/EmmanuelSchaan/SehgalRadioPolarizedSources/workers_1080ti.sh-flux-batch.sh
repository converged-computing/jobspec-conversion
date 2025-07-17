#!/bin/bash
#FLUX: --job-name=salted-kitty-9133
#FLUX: -n=4
#FLUX: -c=2
#FLUX: --queue=savio2_1080ti
#FLUX: -t=28800
#FLUX: --urgency=16

mpiexec -n 4 /global/home/users/mariusmillea/src/julia-1.5.2/bin/julia \
    --project=/global/home/users/mariusmillea/work/ptsrclens/Project.toml \
    -e 'using ClusterManagers; ClusterManagers.elastic_worker("marius          ","10.0.0.24",9312)'
