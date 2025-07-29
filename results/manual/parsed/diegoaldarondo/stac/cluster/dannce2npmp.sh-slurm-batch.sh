#!/bin/bash
#SBATCH --job-name=dannce2npmp
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20000
#SBATCH --time=2-00:00:00

set -e
source ~/.bashrc
setup_mujoco200_3.7
mkdir -p npmp
mkdir -p npmp/model_3_no_noise
dispatch-npmp-embed ./npmp_preprocessing/total.hdf5 ./npmp/model_3_no_noise_segmented $1 --stac-params=./stac_params/params.yaml --offset-path=./stac/offset.p
