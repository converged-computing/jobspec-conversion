#!/bin/bash
#FLUX: --job-name=quirky-omelette-1771
#FLUX: -t=172800
#FLUX: --priority=16

export LD_LIBRARY_PATH='/usr/lib64:$LD_LIBRARY_PATH'

module load intel/19.1.1
module load impi/19.0.9
module load mvapich2-gdr/2.3.7
module load mvapich2/2.3.7
module load phdf5/1.10.4
module load python3/3.9.7
export LD_LIBRARY_PATH=/usr/lib64:$LD_LIBRARY_PATH
PARENT="/work/09874/tliangwi/ls6/"
source "${PARENT}/gns/venv/bin/activate"
pip install pandas
cd $PARENT/chrono
python -u chrono_npz.py 197 sph_data
