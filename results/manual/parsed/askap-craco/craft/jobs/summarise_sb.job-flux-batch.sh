#!/bin/bash
#FLUX: --job-name=strawberry-fork-9722
#FLUX: -t=8400
#FLUX: --urgency=16

export CRAFT='/home/ban115/craft/craft/'
export PATH='$CRAFT/cuda-fdmt/cudafdmt/src:$CRAFT/python:$PATH'
export PYTHONPATH='$CRAFT/python:$PYTHONPATH'
export OMP_NUM_THREADS='8'

export CRAFT=/home/ban115/craft/craft/
export PATH=$CRAFT/cuda-fdmt/cudafdmt/src:$CRAFT/python:$PATH
export PYTHONPATH=$CRAFT/python:$PYTHONPATH
export OMP_NUM_THREADS=8
module unload gcc/4.9.0
module unload PrgEnv-cray
module load python/2.7.10
module load astropy
thedir=$1
thebase=`basename $thedir`
echo Summarising $1 to ${thebase}.json
aprun find $thedir -name 'ak*.hdr.v2' | xargs ~ban115/craft/craft/python/summarise_scans.py -o ${thebase}.json
