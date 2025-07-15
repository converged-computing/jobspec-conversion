#!/bin/bash
#FLUX: --job-name=delicious-ricecake-6601
#FLUX: -c=8
#FLUX: --queue=gpuq
#FLUX: -t=7200
#FLUX: --priority=16

export CRAFT='/home/ban115/craft/craft/'
export PATH='$CRAFT/cuda-fdmt/cudafdmt/src:$CRAFT/python:$PATH'
export PYTHONPATH='$CRAFT/python:$PYTHONPATH'
export OMP_NUM_THREADS='8'

module swap PrgEnv-cray  PrgEnv-gnu
module load cudatoolkit
export CRAFT=/home/ban115/craft/craft/
export PATH=$CRAFT/cuda-fdmt/cudafdmt/src:$CRAFT/python:$PATH
export PYTHONPATH=$CRAFT/python:$PYTHONPATH
export OMP_NUM_THREADS=8
indir=$1
if [[ ! -d $indir ]] ; then
    echo "fredda_all.job: Cannot process directory $indir. Quitting"
    exit 1
fi
echo "Going to $indir"
cd $indir
outfname="fredda_galaxy14.cand"
logfname="fredda_galaxy14.log"
for hdrfile  in `find . -name '*.hdr'` ; do
    rundir=`dirname $hdrfile`
    echo "Running in $rundir"
    outfile="${rundir}/${outfname}"
    if [[ -e $outfile ]] ; then
	echo "Outfile $outfile exists. Skipping"
	continue
    fi
    pushd $rundir
    aprun -B cudafdmt -t 512 -d 1024 -S 8 -r 1 -K 2 -M 8 -T 8 -G 1 -m 50 -b 24  -n 1 -z 6 -C 6 -x 7.5 -o $outfname *.fil 2>&1 > $logfname
    popd
done
module unload PrgEnv-cray
module unload gcc/4.9.0
module load python/2.7.10
module load matplotlib
