#!/bin/bash
#FLUX: --job-name=Test_dam
#FLUX: -t=6000
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK '

Para="../Playgrounds/Dam_Para.kzr"
Geom="../Playgrounds/Dam_Geom.kzr"
TestName="dam"
module load openmpi/1.6.4/gcc-4.9.2 
module load cmake/3.5.2 
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK 
mpirun sph $Para $Geom $TestName 
