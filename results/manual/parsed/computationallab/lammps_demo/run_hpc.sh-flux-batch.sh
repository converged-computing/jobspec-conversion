#!/bin/bash
#FLUX: --job-name=melt
#FLUX: --queue=gor
#FLUX: --urgency=16

module load singularity gnu8 openmpi3
rm -rf out
mkdir out/
mpirun -np ${SLURM_NTASKS} singularity exec /opt/site/singularity-apps/lammps/20200505/lammps-20200505-centos7-python3.6.9.sif lammps -i melt.in
