#!/bin/bash
#FLUX: --job-name=salted-buttface-6059
#FLUX: --urgency=16

module purge
module load intel/17.2 openmpi/intel/2.0.1 
module load lammps/17Nov16
cd $PWD
time srun lmp_icc_openmpi < in.interface
