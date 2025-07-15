#!/bin/bash
#FLUX: --job-name=expensive-cattywampus-4269
#FLUX: -c=32
#FLUX: --exclusive
#FLUX: --urgency=16

export OMP_NUM_THREADS='32'

export OMP_NUM_THREADS=32
srun  --cpu_bind=cores  --mpi=pmix  ../builds/singleNodeImproved_path -f delaunay_n16 -k 8 -direct false -weight false
