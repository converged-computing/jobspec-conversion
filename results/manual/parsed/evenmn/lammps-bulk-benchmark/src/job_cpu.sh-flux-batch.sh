#!/bin/bash
#FLUX: --job-name=cpu
#FLUX: -n=16
#FLUX: --queue=normal
#FLUX: --urgency=16

mpirun lmp_test -in in.lammps
