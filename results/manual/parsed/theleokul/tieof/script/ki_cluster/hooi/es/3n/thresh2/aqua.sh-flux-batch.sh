#!/bin/bash
#FLUX: --job-name=swampy-bike-4898
#FLUX: -c=48
#FLUX: --queue=hpc4-3d
#FLUX: -t=259199
#FLUX: --urgency=16

export OPENBLAS_NUM_THREADS='2'

module load openmpi intel-compilers
export OPENBLAS_NUM_THREADS=2
$MPIRUN python main3_mp.py -c config/main3_default_ki_cluster.yml \
    --satellite-descriptor '../test/satellite_descriptor_ki_cluster_w3nt2.csv' \
    -S aqua \
    --logs ../test/reconstruction_logs/hooi_es_3neighbours_thresh2_aqua \
    --interpolated-stem interpolated_3neighbours_thresh2 \
    --output-stem Output_3neighbours_thresh2 \
    --decomposition-method hooi \
    --early-stopping 1
