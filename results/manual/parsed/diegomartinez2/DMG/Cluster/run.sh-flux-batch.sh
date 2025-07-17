#!/bin/bash
#FLUX: --job-name=SrTiO3_qe
#FLUX: -n=40
#FLUX: --queue=all
#FLUX: -t=84600
#FLUX: --urgency=16

export NPROCS='$SLURM_NTASKS'

module load intel/2021a
node=`hostname`
echo "******************"
echo "job run at node " $node
echo "******************"
echo ""
if [[ ! -e /lscratch/$USER ]]; then
    mkdir /lscratch/$USER
fi
cp -r $SLURM_SUBMIT_DIR  /lscratch/$USER/$SLURM_JOB_ID
cd /lscratch/$USER/$SLURM_JOB_ID
export NPROCS=$SLURM_NTASKS
rm slurm*.out
echo "put your jobs here"
echo "Run job 1"
mpirun -np 40 pw.x < scf.in > scf.out
cd $SLURM_SUBMIT_DIR
echo "Making backup..."
mkdir BACKUP
for file in *; do
	if [ $file != BACKUP ] && [ $file != slurm*out ]; then
		mv $file BACKUP/$file
	fi
done
echo "Copying files from /lscratch..."
cp -r /lscratch/$USER/$SLURM_JOB_ID/* $SLURM_SUBMIT_DIR/
echo "Deleting files from /lscratch..."
rm -r /lscratch/$USER/$SLURM_JOB_ID
echo "Deleting the BACKUP..."
cd $SLURM_SUBMIT_DIR
for file in *; do
	if [ $file != BACKUP ] && [ $file != slurm*out ] && [ -e BACKUP/$file ]; then
		rm -r BACKUP/$file
	fi
done
rmdir BACKUP
echo "DONE"
