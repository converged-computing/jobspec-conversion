#!/bin/bash
#FLUX: --job-name=lovable-mango-2205
#FLUX: -c=2
#FLUX: -t=28800
#FLUX: --urgency=16

date;hostname;pwd
mkdir -p /blue/vendor-nvidia/hju/single_cell_data
wget -P /blue/vendor-nvidia/hju/single_cell_data https://rapids-single-cell-examples.s3.us-east-2.amazonaws.com/krasnow_hlca_10x.sparse.h5ad
