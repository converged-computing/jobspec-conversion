#!/bin/bash
#FLUX: --job-name=salted-plant-1863
#FLUX: --queue=standard
#FLUX: -t=604800
#FLUX: --urgency=16

module load gcc/7.1.0 python/3.6.8 ffmpeg intel/18.0 intelmpi/18.0 cuda pgi openmpi
cd $SLURM_SUBMIT_DIR
echo `pwd`
mpiexec -np 20 /home/rh3bf/mylammps/build/lmp -i run.lmp
