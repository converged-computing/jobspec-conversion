#!/bin/bash
#FLUX: --job-name=chunky-bike-9418
#FLUX: --queue=hci-rw
#FLUX: -t=259200
#FLUX: --urgency=16

udocker=/uufs/chpc.utah.edu/common/HIPAA/u0028003/BioApps/UDocker/udocker-1.1.1/udocker
mount=/scratch/mammoth/serial/u0028003/
set -e; start=$(date +'%s')
echo -e "\n---------- Starting -------- $((($(date +'%s') - $start)/60)) min"
name=${PWD##*/}
tumor=`readlink -f tumor.bam`
normal=`readlink -f normal.bam`
jobDir=`readlink -f .`
echo -e "\n---------- Launching Container -------- $((($(date +'%s') - $start)/60)) min"
$udocker run \
--env=tumor=$tumor --env=normal=$normal --env=name=$name --env=jobDir=$jobDir \
--volume=$mount:$mount \
SnakeMakeBioApps_1 < somTriCaller_*.udocker.sh
echo -e "\n---------- Complete! -------- $((($(date +'%s') - $start)/60)) min total"
