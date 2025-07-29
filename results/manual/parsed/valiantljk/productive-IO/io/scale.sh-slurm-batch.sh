#!/bin/bash
#SBATCH --job-name=h5write
#SBATCH --output=%j.out
#SBATCH --error=%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00
#SBATCH --constraint=haswell

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
