#!/bin/bash
#FLUX: --job-name=anxious-cat-8907
#FLUX: --queue=dev_q
#FLUX: -t=300
#FLUX: --urgency=16

module reset
module load LAMMPS
echo "LAMMPS_TINKERCLIFFS ROME: Normal beginning of execution."
mpirun -np $SLURM_NTASKS lmp < in.lj > lammps_tinkercliffs_rome.txt
if [ $? -ne 0 ]; then
  echo "LAMMPS_TINKERCLIFFS ROME: Run error!"
  exit 1
fi
echo "LAMMPS_TINKERCLIFFS ROME: Normal end of execution."
exit 0
