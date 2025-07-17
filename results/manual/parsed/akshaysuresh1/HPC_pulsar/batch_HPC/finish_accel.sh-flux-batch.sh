#!/bin/bash
#FLUX: --job-name=dinosaur-squidward-0483
#FLUX: --queue=RM
#FLUX: -t=36000
#FLUX: --urgency=16

module load openmpi/3.1.6-gcc8.3.1
CMDDIR=$PROJECT/HPC_pulsar/cmd_files
echo $SLURM_NTASKS
$CMDDIR/finish_accel.cmd
