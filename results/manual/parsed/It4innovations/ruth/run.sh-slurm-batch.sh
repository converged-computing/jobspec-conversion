#!/bin/bash
#FLUX: --job-name=Ruth_Bench
#FLUX: -N=2
#FLUX: --queue=qcpu
#FLUX: -t=172800
#FLUX: --urgency=16

ml purge
ml Python/3.10.8-GCCcore-12.2.0
ml GCC/12.2.0
ml SQLite/3.39.4-GCCcore-12.2.0
ml HDF5/1.14.0-gompi-2022b
ml CMake/3.24.3-GCCcore-12.2.0
ml Boost/1.81.0-GCC-12.2.0
source venv/bin/activate
python3 ruth/zeromq/bench.py workers_1_nodes_250k_full
