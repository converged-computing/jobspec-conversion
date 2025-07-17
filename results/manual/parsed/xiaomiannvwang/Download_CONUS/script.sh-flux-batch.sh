#!/bin/bash
#FLUX: --job-name=hello-car-9878
#FLUX: -t=10800
#FLUX: --urgency=16

export KMP_AFFINITY='compact'
export PATH='$PATH:/pfs/work6/workspace/scratch/ov0392-KeShi_Prak-0/cuda90/bin'
export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/pfs/work6/workspace/scratch/ov0392-KeShi_Prak-0/cuda90/cuda90/lib64'

export KMP_AFFINITY=compact
module load ${MODULE}
export PATH=$PATH:/pfs/work6/workspace/scratch/ov0392-KeShi_Prak-0/cuda90/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/pfs/work6/workspace/scratch/ov0392-KeShi_Prak-0/cuda90/cuda90/lib64
cd /pfs/work6/workspace/scratch/ov0392-CONUS2.5-0
source env6/bin/activate
cd /pfs/work6/workspace/scratch/ov0392-CONUS2.5-0/github
python3 RNTN_v2.py download_CONUS_2.5_multiprocessing_v2.1_Unixpath.py
