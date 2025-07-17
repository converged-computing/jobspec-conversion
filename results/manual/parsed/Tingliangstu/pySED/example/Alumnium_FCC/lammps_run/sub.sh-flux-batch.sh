#!/bin/bash
#FLUX: --job-name=SED
#FLUX: -n=64
#FLUX: --queue=amd_512
#FLUX: --urgency=16

export PATH='/public3/home/scg5426/lammps/new/lammps-3Aug2022/src:$PATH'

run_lammps_file="in.vels"
source /public3/soft/modules/module.sh
module load mpi/intel/20.0.4-ls
export PATH=/public3/home/scg5426/lammps/new/lammps-3Aug2022/src:$PATH
mpirun -np 64 lmp_intel_cpu_intelmpi -in ${run_lammps_file}
