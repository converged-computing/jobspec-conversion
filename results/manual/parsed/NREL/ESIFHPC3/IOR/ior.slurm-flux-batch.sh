#!/bin/bash
#FLUX: --job-name=IORtest
#FLUX: -n=100
#FLUX: -t=3600
#FLUX: --urgency=16

export SCRATCH='/scratch/$USER/${SLURM_JOB_NAME:?}'

export SCRATCH=/scratch/$USER/${SLURM_JOB_NAME:?}
if [ -d $SCRATCH ]
then
   rm -rf $SCRATCH
fi
mkdir $SCRATCH; cd $SCRATCH
ml ior/3.2.1
ml openmpi/4.0.4/gcc-8.4.0
ml hdf5/1.10.6/gcc-ompi
echo "Test 1 - POSIX Streaming, 10 GB single-segment, file-per-process"
srun --ntasks=100 --cpu-bind=rank --distribution=block ior -v -a POSIX -i5 -g -w -r -e -C -F -b 100m -t 1m -s 1
echo "Test 2 - MPI Streaming, 100 GB single-segment, single file"
srun --ntasks=100 --cpu-bind=rank --distribution=block ior -v -a MPIIO -i5 -g -w -r -e -C -b 1g -t 1m -s 1
echo "Test 3 - HDF5 Streaming, 100 GB single-segment, single file"
srun --ntasks=100 --cpu-bind=rank --distribution=block ior -v -a HDF5 -i5 -g -w -r -C -b 1g -t 1m -s 1
echo "Test 4 - HDF5 Streaming, 100 GB ten-segment, single file"
srun --ntasks=100 --cpu-bind=rank --distribution=block ior -v -a HDF5 -i5 -g -w -r -e -C -b 10m -t 10m -s 10
echo "Test 5 - POSIX Random, 1 GB single-segment, single file"
srun --ntasks=100 --cpu-bind=rank --distribution=block ior -v -a POSIX -i5 -g -w -r -e -z -b 10m -t 2k -s 1
echo "Test 6 - HDF5 Small Transfer, 1 GB ten-segment, single file"
srun --ntasks=100 --cpu-bind=rank --distribution=block ior -v -a HDF5 -i1 -g -w -r -e -b 10m -t 2k -s 1
