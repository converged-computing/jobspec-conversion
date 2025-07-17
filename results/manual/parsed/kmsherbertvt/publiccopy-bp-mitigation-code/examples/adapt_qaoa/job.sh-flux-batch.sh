#!/bin/bash
#FLUX: --job-name=bricky-destiny-9700
#FLUX: -c=20
#FLUX: --queue=normal_q
#FLUX: -t=259200
#FLUX: --urgency=16

export NTHREAD='20'
export JULIAENV='/home/gbarron/bp-mitigation-code/'
export MKL_NUM_THREADS='1'
export OMP_NUM_THREADS='1'
export OPENBLAS_NUM_THREADS='1'
export INFILE='$1'
export OUTFILE='${INFILE}.out'

sleep 10
hostname
module load Julia/1.7.2-linux-x86_64
export NTHREAD=20
export JULIAENV=/home/gbarron/bp-mitigation-code/
export MKL_NUM_THREADS=1
export OMP_NUM_THREADS=1
export OPENBLAS_NUM_THREADS=1
echo "Usage: sbatch job.sh script.jl"
export INFILE=$1
export OUTFILE="${INFILE}.out"
echo $INFILE
echo $OUTFILE
julia --project=$JULIAENV -t $NTHREAD $INFILE >& $OUTFILE
exit
