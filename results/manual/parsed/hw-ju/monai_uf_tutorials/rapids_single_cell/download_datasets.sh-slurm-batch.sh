#!/bin/bash
#SBATCH --output=%x.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=64G
#SBATCH --time=08:00:00

date;hostname;pwd
mkdir -p /blue/vendor-nvidia/hju/single_cell_data
wget -P /blue/vendor-nvidia/hju/single_cell_data https://rapids-single-cell-examples.s3.us-east-2.amazonaws.com/krasnow_hlca_10x.sparse.h5ad
