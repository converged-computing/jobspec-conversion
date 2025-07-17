#!/bin/bash
#FLUX: --job-name=ipi_lammps_example
#FLUX: -t=604800
#FLUX: --urgency=16

export PYTHONUNBUFFERED='1'
export PSM2_CUDA='0'

module purge
module load compiler/gcc/11 openmpi/4.1 lammps/23June2022
export PYTHONUNBUFFERED=1
export PSM2_CUDA=0
HOST=$(hostname)
sed -i "s/address>[^<]*</address>$HOST</" input.xml
i-pi input.xml &> log.ipi &
sleep 20
sed -i "s/localhost/$HOST/" in.lmp
mpirun `which lmp` < in.lmp > lammps.out
