#!/bin/bash
#FLUX: --job-name=chunky-lemur-9689
#FLUX: -c=20
#FLUX: -t=14400
#FLUX: --urgency=16

set -e -o pipefail
source config_cgpu.sh $@
./build_env.sh 2>&1 | tee log.env
conda activate $INSTALL_DIR
./build_pytorch.sh 2>&1 | tee log.pytorch
./build_apex.sh 2>&1 | tee log.apex
./build_geometric.sh 2>&1 | tee log.geometric
./build_mpi4py.sh 2>&1 | tee log.mpi4py
