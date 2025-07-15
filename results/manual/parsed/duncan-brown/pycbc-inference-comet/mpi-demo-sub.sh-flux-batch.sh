#!/bin/bash
#FLUX: --job-name="singularity_python_test"
#FLUX: -N=2
#FLUX: --queue=debug
#FLUX: -t=300
#FLUX: --priority=16

module load mvapich2_ib singularity
CONTAINER=/cvmfs/singularity.opensciencegrid.org/sugwg/dbrown\:latest
mpirun singularity exec --home /home/dabrown/pycbc_test:/srv --pwd /srv --bind /cvmfs --bind /tmp ${CONTAINER} /srv/mpi-demo-wrapper.sh
