#!/bin/bash
#FLUX: --job-name=purple-punk-3712
#FLUX: --priority=16

export OMP_NUM_THREADS='1'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'

export OMP_NUM_THREADS=1
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
module load conda
conda activate jon
python <<EOF
import platform
print(platform.python_version())
import desi
desi.desi_legacy_xcounts()
EOF
