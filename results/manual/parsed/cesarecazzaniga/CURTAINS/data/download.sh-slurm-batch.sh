#!/bin/bash
#FLUX: --job-name=download
#FLUX: --queue=shared-cpu,private-dpnc-cpu,public-cpu
#FLUX: -t=14400
#FLUX: --urgency=16

export XDG_RUNTIME_DIR=''

export XDG_RUNTIME_DIR=""
module load GCCcore/8.2.0 Singularity/3.4.0-Go-1.12
srun singularity exec --nv /srv/beegfs/scratch/groups/dpnc/atlas/BIB/implicitBIBae/container/pytorch.sif\
	python3 /srv/beegfs/scratch/groups/dpnc/atlas/BIB/implicitBIBae/data/data_loaders.py --download 1
