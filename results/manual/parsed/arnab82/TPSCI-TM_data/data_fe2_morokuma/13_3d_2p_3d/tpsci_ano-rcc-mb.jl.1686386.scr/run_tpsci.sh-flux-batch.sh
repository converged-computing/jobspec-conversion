#!/bin/bash
#FLUX: --job-name=tpsci_cr2.jl
#FLUX: --urgency=16

export NTHREAD='16'
export JULIAENV='/home/arnab22/tpsci_bimetallic'
export MKL_NUM_THREADS='1'
export OMP_NUM_THREADS='1'
export OPENBLAS_NUM_THREADS='1'
export INFILE='$1'
export OUTFILE='${INFILE}.out'
export WORKDIR='$(pwd)'

export NTHREAD=16
export JULIAENV=/home/arnab22/tpsci_bimetallic
sleep 10
hostname
module reset
module load site/tinkercliffs-rome/easybuild/setup
module load site/tinkercliffs/easybuild/setup
module load Anaconda3/2020.07
module load gcc/8.2.0
source activate bst
echo "Usage: sbatch submit.sh {input file} {data file} {data file}"
export MKL_NUM_THREADS=1
export OMP_NUM_THREADS=1
export OPENBLAS_NUM_THREADS=1
export INFILE=$1
export OUTFILE="${INFILE}.out"
export WORKDIR=$(pwd)
echo $INFILE
echo $OUTFILE
echo $WORKDIR
echo $TMPDIR
cp $INFILE $TMPDIR/
if [ "$2" ]
then
        cp $2 $TMPDIR/
fi
if [ "$3" ]
then
        cp $3 $TMPDIR/
fi
cd $TMPDIR
touch $OUTFILE
while true; do rsync -av $OUTFILE $WORKDIR/"${INFILE}.${SLURM_JOB_ID}.out"; sleep 60; done &
julia --project=$JULIAENV -t $NTHREAD $INFILE >& $OUTFILE
cp $OUTFILE $WORKDIR/"${INFILE}.out"
rm $WORKDIR/"${INFILE}.${SLURM_JOB_ID}.out"
mkdir $WORKDIR/"${INFILE}.${SLURM_JOB_ID}.scr"
cp -r * $WORKDIR/"${INFILE}.${SLURM_JOB_ID}.scr"
rm -r *
mv $WORKDIR/"slurm-${SLURM_JOB_ID}.out" $WORKDIR/"${INFILE}.${SLURM_JOB_ID}.scr"
exit
