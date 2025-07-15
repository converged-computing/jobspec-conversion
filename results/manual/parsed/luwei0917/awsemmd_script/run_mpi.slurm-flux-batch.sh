#!/bin/bash
#FLUX: --job-name=CTBP_WL
#FLUX: -n=2
#FLUX: --queue=commons
#FLUX: -t=86400
#FLUX: --urgency=16

echo "My job ran on:"
echo $SLURM_NODELIST
srun /home/wl45/lammps-30Jul16/src/lmp_mpi -in PROTEIN.in
