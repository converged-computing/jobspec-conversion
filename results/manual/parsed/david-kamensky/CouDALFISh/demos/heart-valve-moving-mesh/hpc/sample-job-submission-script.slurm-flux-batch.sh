#!/bin/bash
#FLUX: --job-name=16
#FLUX: -N=2
#FLUX: -n=40
#FLUX: --queue=skx-dev
#FLUX: -t=7200
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export PYTHONPATH='$PYTHONPATH":"$SW"/ShNAPr'

module load intel/19.1.1
module load tacc-singularity
module load mvapich2
mv ~/.local ~/.local-temp-rename
SW=$STOCKYARD"/stampede2/fenics-container"
FENICS=$SW"/fenics.sif"
export OMP_NUM_THREADS=1
export PYTHONPATH=$PYTHONPATH":"$SW"/COFFEE"
export PYTHONPATH=$PYTHONPATH":"$SW"/FInAT"
export PYTHONPATH=$PYTHONPATH":"$SW"/networkx"
export PYTHONPATH=$PYTHONPATH":"$SW"/pulp"
export PYTHONPATH=$PYTHONPATH":"$SW"/tsfc"
export PYTHONPATH=$PYTHONPATH":"$SW"/singledispatch"
export PYTHONPATH=$PYTHONPATH":"$SW"/tIGAr"
export PYTHONPATH=$PYTHONPATH":"$SW"/ShNAPr"
ibrun singularity exec $FENICS python3 heart-valve-moving-mesh.py \
--mesh-folder           ./mesh/                         \
--results-folder        ./results/                      \
--restarts-folder       ./restarts/	                    \
--valve-folder          ./valve/fine/                   \
--num-patches           10                              \
--stent-patches         4 5 6 7 8 9 10                  \
--valve-smesh-suffix    .txt                            \
--delta-t               1e-4                            \
--num-steps             20000                           \
--block-max-iters       3                               \
--block-tol             1e-3                            \
--ksp-max-iters         300                             \
--leaflet-material      isotropic-lee-sacks             \
--leaflet-c0            676080                          \
--leaflet-c1            132848                          \
--leaflet-c2            38.1878                         \
--leaflet-thickness     0.0386                          \
--r-self                0.0308                          \
--r-max                 0.0237                          \
> log
