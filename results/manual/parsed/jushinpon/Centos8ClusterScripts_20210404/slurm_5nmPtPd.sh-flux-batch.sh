#!/bin/bash
#FLUX: --job-name=5nmPtPd
#FLUX: --queue=debug
#FLUX: --priority=16

export LD_LIBRARY_PATH='/opt/mpich-3.4.1/lib:$LD_LIBRARY_PATH'
export PATH='/opt/mpich-3.4.1/bin:$PATH'

export LD_LIBRARY_PATH=/opt/mpich-3.4.1/lib:$LD_LIBRARY_PATH
export PATH=/opt/mpich-3.4.1/bin:$PATH
mpiexec /opt/lammps-mpich-3.4.1/lmp_20210223 -in tension_5nmPtPd.in
