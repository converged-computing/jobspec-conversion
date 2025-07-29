#!/bin/bash
#SBATCH --job-name=my_cpl_demo
#SBATCH --account=y23
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --qos=standard
#SBATCH --exclusive

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
