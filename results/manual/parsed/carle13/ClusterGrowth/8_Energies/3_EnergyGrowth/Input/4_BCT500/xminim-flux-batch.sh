#!/bin/bash
#FLUX: --job-name=phat-nunchucks-9143
#FLUX: -n=40
#FLUX: -t=3600
#FLUX: --urgency=16

module purge
module load lammps/20210929-mpi
echo $randomSeed
srun /gpfswork/rech/nyu/uvm82kt/.Software/1_Lammps_withLassoLars_BIS/src/lmp_mpi -i input.lmp -log seed${randomSeed}.log -var seed ${randomSeed}
