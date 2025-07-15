#!/bin/bash
#FLUX: --job-name=gassy-onion-1547
#FLUX: --queue=devel
#FLUX: -t=600
#FLUX: --priority=16

module purge
module use /usr/local/software/jureca/OtherStages
module load Stages/Devel-2019a
module load intel-para/2019a
module load LAMMPS/3Mar2020-Python-3.6.8-kokkos
srun lmp -in in.lj
