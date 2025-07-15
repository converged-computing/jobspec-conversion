#!/bin/bash
#FLUX: --job-name=arid-carrot-6263
#FLUX: -t=1296000
#FLUX: --urgency=16

	#for all queues
	#for cuda queue
module load centos7.3/app/namd/2017-11-10-multicore-cuda
echo "SLURM_NODELIST $SLURM_NODELIST"
echo "NUMBER OF CORES $SLURM_NTASKS"
$NAMD_DIR/namd2  +p $SLURM_NTASKS  +idlepoll config.conf
