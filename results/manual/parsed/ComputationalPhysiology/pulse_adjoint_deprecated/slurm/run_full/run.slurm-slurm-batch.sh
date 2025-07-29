#!/bin/bash
#FLUX: --job-name=SubName
#FLUX: -t=345600
#FLUX: --urgency=16

export CC='gcc'
export CXX='g++'
export FC='gfortran'
export F77='gfortran'
export F90='gfortran'

source /cluster/bin/jobsetup
set -o errexit # exit on errors
ulimit -S -s unlimited
module purge   # clear any inherited modules
module load gcc/5.1.0
module load openmpi.gnu/1.8.8
module load cmake/3.1.0
export CC=gcc
export CXX=g++
export FC=gfortran
export F77=gfortran
export F90=gfortran
INPUT=$SUBMITDIR"/input/file_"$TASK_ID".yml"
OUTDIR=$(python outfile.py $INPUT "outdir")
OUTPUT=$OUTDIR"/result.h5"
echo $OUTDIR
MESH=$(python outfile.py $INPUT "mesh")
PRESSURE=$(python outfile.py $INPUT "pressure")
cp run.py $SCRATCH 
cp $INPUT $SCRATCH
cp $MESH $SCRATCH
cp $PRESSURE $SCRATCH
mkdir -p $OUTDIR
cleanup "cp $SCRATCH/result.h5 $OUTDIR/result.h5"
cleanup "cp $SCRATCH/input.yml $OUTDIR/input.yml"
cleanup "cp $SCRATCH/output.log $OUTDIR/output.log"
cd $SCRATCH
mpirun python run.py $INPUT $OUTPUT
