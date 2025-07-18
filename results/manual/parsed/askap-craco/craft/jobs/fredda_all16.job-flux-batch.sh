#!/bin/bash
#FLUX: --job-name=expressive-punk-1524
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
outfname="fredda_galaxy16.cand"
logfname="fredda_galaxy16.log"
for hdrfile  in `find . -name 'ak*.hdr'` ; do
    rundir=`dirname $hdrfile`
    echo "Running in $rundir"
    outfile="${rundir}/${outfname}"
    if [[ -e $outfile ]] ; then
	echo "Outfile $outfile exists. Skipping"
	continue
    fi
    pushd $rundir
    aprun -B cudafdmt -t 1024 -d 2048 -S 14 -r 1 -K 2 -M 8 -T 8 -G 1 -m 50 -b 24  -z 6 -C 6 -x 9.0 -o $outfname *.[012]?.fil *.3[01234].fil 2>&1 > $logfname
    aprun -B fredfof.py $outfname
    popd
done
module unload PrgEnv-cray
module unload gcc/4.9.0
module load python/2.7.10
module load matplotlib
w=`pwd`
thisdir=`basename $w`
outfile="${thisdir}_${outfname}.png"
aprun -B plot_fredda_cand.py . -f $outfname -o ${outfile}
