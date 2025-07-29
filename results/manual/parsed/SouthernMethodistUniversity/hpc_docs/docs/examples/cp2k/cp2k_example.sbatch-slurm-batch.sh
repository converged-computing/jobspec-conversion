#!/bin/bash
#FLUX: --job-name=example
#FLUX: -N=2
#FLUX: --exclusive
#FLUX: --queue=development
#FLUX: --urgency=16

export OMPI_MCA_btl='self,sm,openib'
export CP2K_DATA_DIR='/hpc/examples/cp2k/data'

module purge
source /hpc/spack/share/spack/setup-env.sh
spack load --dependencies cp2k
module list
export OMPI_MCA_btl="self,sm,openib"
export CP2K_DATA_DIR=/hpc/examples/cp2k/data
srun cp2k.popt water_pbed3.inp
