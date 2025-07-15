#!/bin/bash
#FLUX: --job-name=my_cpl_demo
#FLUX: -N=2
#FLUX: --exclusive
#FLUX: --queue=standard
#FLUX: -t=1800
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
module load other-software
module load cpl-openfoam
source $FOAM_CPL_APP/SOURCEME.sh
module load cpl-lammps
cd openfoam
python clean.py -f
blockMesh
decomposePar
cd ..
SHARED_ARGS="--distribution=block:block --hint=nomultithread"
srun ${SHARED_ARGS} --het-group=0 --nodes=1 --tasks-per-node=2  CPLIcoFoam -case ./openfoam -parallel : --het-group=1 --nodes=1 --tasks-per-node=2 lmp_cpl -i lammps.in
