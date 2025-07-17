#!/bin/bash
#FLUX: --job-name=h5write
#FLUX: --queue=debug
#FLUX: -t=300
#FLUX: --urgency=16

export LD_PRELOAD='/opt/cray/pe/mpt/7.4.4/gni/mpich-gnu/5.1/lib/libmpich.so:/usr/common/software/darshan/3.0.1/lib/libdarshan.so:$LD_PRELOAD'

nodes=1        #Nodes 32
nprocs=2      #Processes 1024
iscollective=1 #Collective IO
dimx=320      #Size of X dimension
dimy=3000      #Size of Y dimension
lost=2         #OST 72
hostpartion=haswell
filename_py=$SCRATCH/hdf-data/ost${lost}/test_${hostpartion}_${nprocs}_${SLURM_JOBID}_py.h5
rm -rf $SCRATCH/hdf-data/ost${lost}/
mkdir -p $SCRATCH/hdf-data/ost${lost}/
lfs setstripe -c $lost $SCRATCH/hdf-data/ost${lost}/
module load darshan/3.0.1
printf "h5py:\n"
module load python/2.7-anaconda
module load h5py-parallel
export LD_PRELOAD=/opt/cray/pe/mpt/7.4.4/gni/mpich-gnu/5.1/lib/libmpich.so:/usr/common/software/darshan/3.0.1/lib/libdarshan.so:$LD_PRELOAD
cmd="srun -n $nprocs python-mpi h5write.py $iscollective $filename_py $dimx $dimy"
echo $cmd
time $cmd
