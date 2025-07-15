#!/bin/bash
#FLUX: --job-name=r1
#FLUX: -N=8
#FLUX: --queue=regular
#FLUX: -t=14400
#FLUX: --priority=16

prefix='relax'
currindex=1
source $MODULESHOME/init/bash
module load lammps/
lmp=lmp_edison
echo "LAMMPS executable is $lmp"
cd $PBS_O_WORKDIR
srun -np 196  $lmp -in $prefix.$currindex.in # Do not use "<" in place of "-in"
