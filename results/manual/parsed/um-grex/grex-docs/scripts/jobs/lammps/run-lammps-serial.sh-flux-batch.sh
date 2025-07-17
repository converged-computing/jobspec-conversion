#!/bin/bash
#FLUX: --job-name=Lammps-Test
#FLUX: -t=10800
#FLUX: --urgency=16

module load intel/2019.5 ompi/3.1.4 lammps/29Sep21
echo "Starting run at: `date`"
lmp_exec=lmp_grex
lmp_input="lammps.in"
lmp_output="lammps_lj_output.txt"
${lmp_exec} < ${lmp_input} > ${lmp_output}
echo "Program finished with exit code $? at: `date`"
