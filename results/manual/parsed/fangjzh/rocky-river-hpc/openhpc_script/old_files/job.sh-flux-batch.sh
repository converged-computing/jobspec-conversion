#!/bin/bash
#FLUX --job-name=psycho-lamp-7846
#FLUX -N=2
#FLUX -n=4
#FLUX --queue=normal
#FLUX --urgency=16

mpirun   /opt/ohpc/pub/apps/lammps/lmp_mpi  -i in.lj
