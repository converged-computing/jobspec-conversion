#!/bin/bash
#FLUX: --job-name=crunchy-cinnamonbun-8731
#FLUX: --urgency=16

module load openmpi/3.1.6-gcc8.3.1
CMDDIR=$PROJECT/HPC_pulsar/cmd_files
echo $SLURM_NTASKS
$CMDDIR/finish_accel.cmd
