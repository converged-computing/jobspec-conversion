#!/bin/bash
#FLUX: --job-name=GP4ku
#FLUX: -N=4
#FLUX: --queue=small
#FLUX: -t=82800
#FLUX: --urgency=16

export LD_LIBRARY_PATH='/home/ext/apps/spack/opt/spack/linux-centos7-cascadelake/gcc-11.2.0/gsl-2.7-h5q52xdndmnqwjwnysbdt5c6ccbk4fv6/lib'

source ../../../pravega-env-setup.sh
export LD_LIBRARY_PATH='/home/ext/apps/spack/opt/spack/linux-centos7-cascadelake/gcc-11.2.0/gsl-2.7-h5q52xdndmnqwjwnysbdt5c6ccbk4fv6/lib'
mpirun -np 64 ./main2d.gnu.MPI.ex input2.in
