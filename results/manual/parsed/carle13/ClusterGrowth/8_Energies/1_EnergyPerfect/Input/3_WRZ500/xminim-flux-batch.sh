#!/bin/bash
#FLUX: --job-name=quirky-lizard-8798
#FLUX: -n=40
#FLUX: -t=3600
#FLUX: --urgency=16

module purge
module load lammps/20210929-mpi
srun /gpfswork/rech/nyu/uvm82kt/.Software/1_Lammps_withLassoLars_BIS/src/lmp_mpi -i input.lmp
