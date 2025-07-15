#!/bin/bash
#FLUX: --job-name=astute-train-7344
#FLUX: -t=86399
#FLUX: --priority=16

export STARPU_HOSTNAME='`echo $HOSTNAME | sed 's/[0-9]//g'`'

module purge
module load build/cmake/3.15.3
module load compiler/gcc/9.2.0
module load linalg/mkl/2019_update4
module load mpi/openmpi/4.0.2
module load compiler/cuda/10.1
module load hardware/hwloc/1.11.13
module load trace/eztrace/1.1-8
module load partitioning/metis/int64/5.1.0
module load partitioning/scotch/int64/6.0.9
module load runtime/parsec/master/mpi
module load runtime/starpu/1.3.3/mpi                                                                         
export STARPU_HOSTNAME=`echo $HOSTNAME | sed 's/[0-9]//g'`
MTXNAME=$1
shift
ARTIFACTDIR=$PWD
BINARY=$ARTIFACTDIR/pastix_sharedM/example/bench_facto
TESTDIR=$ARTIFACTDIR/raw_results
MACHINENAME=miriel
NBCORES=24
OPTIONS="$* -v4 -i iparm_ordering_default 0 -i iparm_scotch_cmin 20 -t $NBCORES"
dist1d="-i iparm_tasks2d_level 0"
dist2d="-i iparm_tasks2d_width"
cd $TESTDIR
mkdir -p pmap-${MACHINENAME}-factor/$MTXNAME
cd pmap-${MACHINENAME}-factor/$MTXNAME
min=288
maxcoef=3
max=$((min * maxcoef))
s=1
bsize="-s $s -i iparm_min_blocksize $min -i iparm_max_blocksize $max $dist1d"
cand=0
allcand="-i iparm_allcand $cand"
fname="${MACHINENAME}_${MTXNAME}_sched${s}_1d_bs${min}_${max}_cand${cand}.log"
if [ ! -s $mapfile ]
then
    rm -f $fname
fi
if [ ! -s $fname ]
then
    echo $BINARY $OPTIONS $bsize $dist1d $allcand >> $fname
    $BINARY $OPTIONS $bsize $dist1d $allcand >> $fname 2>&1
    rm pastix-*/*.dot
    rm pastix-*/*.svg
fi
rm -f core*
cand=1
fname="${MACHINENAME}_${MTXNAME}_sched${s}_1d_bs${min}_${max}_cand${cand}.log"
allcand="-i iparm_allcand $cand"
if [ ! -s $fname ]
then
    echo $BINARY $OPTIONS $bsize $dist1d $allcand >> $fname
    $BINARY $OPTIONS $bsize $dist1d $allcand >> $fname 2>&1
    rm pastix-*/*.dot
    rm pastix-*/*.svg
fi
rm -f core*
cand=3
fname="${MACHINENAME}_${MTXNAME}_sched${s}_1d_bs${min}_${max}_cand${cand}.log"
allcand="-i iparm_allcand $cand"
if [ ! -s $fname ]
then
    echo $BINARY $OPTIONS $bsize $dist1d $allcand >> $fname
    $BINARY $OPTIONS $bsize $dist1d $allcand >> $fname 2>&1
    rm pastix-*/*.dot
    rm pastix-*/*.svg
fi
rm -f core*
