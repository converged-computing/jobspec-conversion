#!/bin/bash
#FLUX: --job-name=CTBP_WL
#FLUX: --queue=commons
#FLUX: -t=86400
#FLUX: --urgency=16

echo "My job ran on:"
echo $SLURM_NODELIST
srun ~/lammps_awsemmd_20161125/bin/lmp_serial -in PROTEIN.in
