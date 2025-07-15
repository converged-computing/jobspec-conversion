#!/bin/bash
#FLUX: --job-name=project
#FLUX: -t=7200
#FLUX: --priority=16

module load intel/2019u4
module load cmake/3.21.4
module load python/3.11.5
pip install matplotlib
./build.sh
./run.sh
