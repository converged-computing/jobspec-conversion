#!/bin/bash
#FLUX: --job-name=job
#FLUX: -c=128
#FLUX: --exclusive
#FLUX: --queue=ju-standard
#FLUX: -t=86400
#FLUX: --urgency=16

cd /users/panastas/partially-strided-codelet
> lcm_d.csv
> lcm_d.err
module load gcc/12.2.0 2>&1
make clean; make -j
./run.sh
