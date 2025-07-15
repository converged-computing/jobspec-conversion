#!/bin/bash
#FLUX: --job-name=quirky-truffle-9756
#FLUX: -n=128
#FLUX: -c=8
#FLUX: -t=1800
#FLUX: --urgency=16

source /etc/profile.d/modules.sh
module load lammps/12Aug13-sandybridge
cd $SCRATCH_DIR
cp -pr /share/test/LAMMPS/* .
srun lmp_mpi -var x 10 -var y 40 -var z 40 -in in.lj
cp -pr $SCRATCH_DIR $HOME/OUT/lammps/
