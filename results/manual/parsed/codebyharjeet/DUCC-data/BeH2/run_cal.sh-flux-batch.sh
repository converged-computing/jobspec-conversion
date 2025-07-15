#!/bin/bash
#FLUX: --job-name=test13
#FLUX: -c=16
#FLUX: --priority=16

export MKL_NUM_THREADS='1'
export OMP_NUM_THREADS='1'
export OPENBLAS_NUM_THREADS='1'
export INFILE='$1'
export OUTFILE='${INFILE}.out'
export WORKDIR='$(pwd)'

hostname
module reset; module load intel/2019b
source activate myenv
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
python $INFILE >& $OUTFILE
cp $OUTFILE $WORKDIR/"${INFILE}.out"
rm $WORKDIR/"${INFILE}.${SLURM_JOB_ID}.out"
mkdir $WORKDIR/"${INFILE}.${SLURM_JOB_ID}.scr"
cp -r * $WORKDIR/"${INFILE}.${SLURM_JOB_ID}.scr"
rm -r *
mv $WORKDIR/"slurm-${SLURM_JOB_ID}.out" $WORKDIR/"${INFILE}.${SLURM_JOB_ID}.scr"
exit
