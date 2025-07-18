#!/bin/bash
#FLUX: --job-name=psycho-malarkey-3724
#FLUX: -c=8
#FLUX: --queue=gpuq
#FLUX: -t=7200
#FLUX: --urgency=16

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
outfname="fredda_galaxy11.cand"
logfname="fredda_galaxy11.log"
for hdrfile  in `find . -name '*.hdr'` ; do
    rundir=`dirname $hdrfile`
    echo "Running in $rundir"
    outfile="${rundir}/${outfname}"
    if [[ -e $outfile ]] ; then
	echo "Outfile $outfile exists. Skipping"
	continue
    fi
    pushd $rundir
    aprun -B cudafdmt -t 512 -d 1024 -S 8 -r 1 -o $outfname -K 1 -M 4 -T 4 -G 3 -m 10 -n 1 -z 6 -x 10.0 *.fil 2>&1 > $logfname
    popd
done
module unload PrgEnv-cray
module unload gcc/4.9.0
module load python/2.7.10
module load matplotlib
plot_fredda_cand.py ak*/ -f $outfname --detail
