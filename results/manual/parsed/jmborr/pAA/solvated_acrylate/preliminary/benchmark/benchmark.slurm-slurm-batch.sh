#!/bin/bash
#FLUX: --job-name=benchmark
#FLUX: -N=32
#FLUX: --queue=debug
#FLUX: -t=1800
#FLUX: --urgency=16

prefix='relax'
currindex=1
source $MODULESHOME/init/bash
module load lammps/20161117
lmp=lmp_edison
echo "LAMMPS executable is $lmp"
cd $SLURM_SUBMIT_DIR
srun -n 768  $lmp -in benchmark.in # Do not use "<" in place of "-in"
