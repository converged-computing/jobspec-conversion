#!/bin/bash
#FLUX: --job-name=dannce2npmp
#FLUX: --priority=16

set -e
source ~/.bashrc
setup_mujoco200_3.7
mkdir -p npmp
mkdir -p npmp/model_3_no_noise
dispatch-npmp-embed ./npmp_preprocessing/total.hdf5 ./npmp/model_3_no_noise_segmented $1 --stac-params=./stac_params/params.yaml --offset-path=./stac/offset.p
