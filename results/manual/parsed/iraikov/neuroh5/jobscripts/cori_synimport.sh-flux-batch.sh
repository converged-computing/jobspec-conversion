#!/bin/bash
#FLUX: --job-name=synimport
#FLUX: -N=32
#FLUX: --queue=regular
#FLUX: -t=7200
#FLUX: --urgency=16

module swap PrgEnv-intel PrgEnv-gnu
module unload darshan
module load cray-hdf5-parallel/1.8.16
set -x
prefix=$SCRATCH/dentate/Full_Scale_Control/
export prefix
forest_connectivity_path=$prefix/DGC_forest_connectivity_20170508.h5
connectivity_output_path=$prefix/dentate_Full_Scale_GC_20170728.h5
for post in GC; do
for pre in MPP LPP MC BC HC AAC HCC NGFC MOPP; do
srun -n 1024 ./build/neurograph_import -f hdf5:syn -s 128 \
      -d $forest_connectivity_path:/Populations/$post/Connectivity \
      $pre $post $connectivity_output_path
done
done
