#!/bin/bash
#FLUX: --job-name=soup
#FLUX: -n=8
#FLUX: -c=16
#FLUX: -t=21600
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

Para="../Playgrounds/soupPara.kzr"
Geom="../Playgrounds/soupGeom.kzr"
TestName="soup"
module load openmpi/1.6.4/gcc-4.9.2
module load cmake/3.5.2
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
mpirun sph  $Para $Geom $TestName
