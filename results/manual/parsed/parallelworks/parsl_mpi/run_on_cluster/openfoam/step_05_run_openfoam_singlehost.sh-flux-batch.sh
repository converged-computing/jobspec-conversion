#!/bin/bash
#FLUX: --job-name=red-general-8685
#FLUX: --urgency=16

source /contrib/alvaro/ompi/env.sh
RUN_DIR="$HOME/cyclone"
cd $RUN_DIR
SIF_PATH="$HOME/openfoam.sif"
num_mpi_proc=12
singularity exec ${SIF_PATH} /bin/bash -c "source /opt/openfoam11/etc/bashrc; blockMesh"
singularity exec ${SIF_PATH} /bin/bash -c "source /opt/openfoam11/etc/bashrc; snappyHexMesh -overwrite"
singularity exec ${SIF_PATH} /bin/bash -c "source /opt/openfoam11/etc/bashrc; decomposePar"
mpiexec -np ${num_mpi_proc} singularity exec ${SIF_PATH} /bin/bash -c "source /opt/openfoam11/etc/bashrc; foamRun -parallel"
touch out.foam
