#!/bin/bash
#FLUX: --job-name=crusty-leopard-0833
#FLUX: -N=8
#FLUX: --queue=RM
#FLUX: -t=172800
#FLUX: --urgency=16

module load openmpi/3.1.6-gcc8.3.1
CMDDIR=$PROJECT/HPC_pulsar/cmd_files
echo $SLURM_NTASKS
$CMDDIR/multinode_accelsearch.cmd
