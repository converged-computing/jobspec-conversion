#!/bin/bash
#FLUX: --job-name=q03
#FLUX: -N=4
#FLUX: -n=160
#FLUX: --queue=ramirez-ruiz
#FLUX: -t=604740
#FLUX: --urgency=16

pwd; hostname; date
echo "Running program on $SLURM_JOB_NUM_NODES nodes with $SLURM_NTASKS total tasks, with each node getting $SLURM_NTASKS_PER_NODE running on cores."
module load intel
module load intel/impi
module load hdf5/1.10.6-parallel
mpirun -n 160 --ppn 40 /home/sschrode/Athena/DISK/BinaryDisk/code/bin/athena -i athinput.binarydisk_stream
date
