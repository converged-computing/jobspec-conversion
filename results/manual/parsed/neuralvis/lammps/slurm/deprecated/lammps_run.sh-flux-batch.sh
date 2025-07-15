#!/bin/bash
#FLUX: --job-name=lmp_diffuse_2d
#FLUX: -N=5
#FLUX: -n=40
#FLUX: -t=21600
#FLUX: --priority=16

module load cce/10.0.3
module load craype/2.7.2
module load cray-mpich/8.0.15
module load cray-libsci/20.08.1.2
cd /home/users/msrinivasa/develop/lammps
srun build/lmp+pat -i examples/DIFFUSE/in.msd.2d
