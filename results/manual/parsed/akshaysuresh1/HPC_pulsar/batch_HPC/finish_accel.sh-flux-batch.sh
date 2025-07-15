#!/bin/bash
#FLUX: --job-name=moolicious-citrus-8318
#FLUX: --priority=16

module load openmpi/3.1.6-gcc8.3.1
CMDDIR=$PROJECT/HPC_pulsar/cmd_files
echo $SLURM_NTASKS
$CMDDIR/finish_accel.cmd
