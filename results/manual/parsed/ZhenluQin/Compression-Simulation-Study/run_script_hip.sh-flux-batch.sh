#!/bin/bash
#FLUX: --job-name=test
#FLUX: -N=2
#FLUX: -t=900
#FLUX: --urgency=16

ml cmake
ml adios2
ml rocm/5.3
ml craype
set -e
USE_COMPRESSION=1
VERBOSE=0
NUM_GPU=1
REORDER=0
LOSSLESS=0
SIM_ITER=1
ACCUMULATE_DATA=10
COMPUTE_DELAY=0
PREFETCH=1
DEVICE=hip
./build_script_$DEVICE.sh
JSRUN='srun -A CSC331 -N 128 -n 1024 --ntasks-per-node=8 --gpus-per-node=8 --gpu-bind=closest'
SIM=./build_hip/cpu-application-simulator
DATA=$HOME/dev/data/d3d_coarse_v2_700.bin
set -x
	EB=1e17
	ACCUMULATE_DATA=6
	MAX_MEM=32e9
	VERBOSE=0
	rm -rf $DATA.bp
	$ROCPROF $JSRUN $SIM -i $DATA -c /gpfs/alpine/csc143/proj-shared/jieyang/$DATA.bp \
            -t d -n 3 312 1093 585 -m abs -e $EB -s inf -r $REORDER \
            -l $LOSSLESS -g $NUM_GPU -v $VERBOSE -p $SIM_ITER \
            -a $ACCUMULATE_DATA -k $COMPUTE_DELAY -f $MAX_MEM -d $DEVICE
exit 0
if ((0))
then
for ACCUMULATE_DATA in 1 2 4 6 8 10
do
  EB=1e17
  PREFETCH=1
  USE_COMPRESSION=0
  rm -rf $DATA.bp
  $JSRUN $SIM -z $USE_COMPRESSION \
              -i $DATA -c /gpfs/alpine/csc143/proj-shared/jieyang/$DATA.bp \
              -t d -n 3 312 1093 585 -m abs -e $EB -s inf -r $REORDER \
              -l $LOSSLESS -g $NUM_GPU -v $VERBOSE -p $SIM_ITER \
              -a $ACCUMULATE_DATA -k $COMPUTE_DELAY -h $PREFETCH -d $DEVICE
done
for ACCUMULATE_DATA in 1 2 4 6 8 10
do
  EB=1e17
  PREFETCH=0
  USE_COMPRESSION=1
  rm -rf $DATA.bp 
  $JSRUN $SIM -z $USE_COMPRESSION \
              -i $DATA -c /gpfs/alpine/csc143/proj-shared/jieyang/$DATA.bp \
              -t d -n 3 312 1093 585 -m abs -e $EB -s inf -r $REORDER \
              -l $LOSSLESS -g $NUM_GPU -v $VERBOSE -p $SIM_ITER \
              -a $ACCUMULATE_DATA -k $COMPUTE_DELAY -h $PREFETCH -d $DEVICE
done
fi
for ACCUMULATE_DATA in 6 #1 2 4 6 8 10
do
  VERBOSE=3
  EB=1e17
  PREFETCH=1
  USE_COMPRESSION=1
  rm -rf $DATA.bp
  #ROCPROF='rocprof --sys-trace'
  $JSRUN $ROCPROF $SIM -z $USE_COMPRESSION \
              -i $DATA -c /gpfs/alpine/csc143/proj-shared/jieyang/$DATA.bp \
              -t d -n 3 312 1093 585 -m abs -e $EB -s inf -r $REORDER \
              -l $LOSSLESS -g $NUM_GPU -v $VERBOSE -p $SIM_ITER \
              -a $ACCUMULATE_DATA -k $COMPUTE_DELAY -h $PREFETCH -d $DEVICE
done
exit 0
for EB in 1e13 1e14 1e15 1e16 1e17 1e18
do 
  ACCUMULATE_DATA=10
  PREFETCH=1
  USE_COMPRESSION=1
  rm -rf $DATA.bp
  $JSRUN $SIM -z $USE_COMPRESSION \
              -i $DATA -c /gpfs/alpine/csc143/proj-shared/jieyang/$DATA.bp \
              -t d -n 3 312 1093 585 -m abs -e $EB -s inf -r $REORDER \
              -l $LOSSLESS -g $NUM_GPU -v $VERBOSE -p $SIM_ITER \
              -a $ACCUMULATE_DATA -k $COMPUTE_DELAY -h $PREFETCH -d $DEVICE
done
