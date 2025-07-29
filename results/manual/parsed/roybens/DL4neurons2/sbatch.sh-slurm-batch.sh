#!/bin/bash
#SBATCH --job-name=izhi
#SBATCH --output=/global/cscratch1/sd/vbaratha/izhi/runs/slurm/%A_%a.out
#SBATCH --error=/global/cscratch1/sd/vbaratha/izhi/runs/slurm/%A_%a.err
#SBATCH --mail-user=vbaratham@berkeley.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --partition=debug
#SBATCH --constraint=haswell
#SBATCH --array=1-2
#SBATCH --licenses=SCRATCH,project

cd /global/cscratch1/sd/vbaratha/izhi
MODELNAME=hh_ball_stick_9param
VERSION=2
RUNDIR=runs/${SLURM_JOB_ID}
RUNDIR=runs/${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}
mkdir $RUNDIR
DSET_NAME=${MODELNAME}_v$VERSION
NSAMPLES=500000
stimname=chirp16a
stimfile=stims/${stimname}.csv
paramfile=$RUNDIR/${DSET_NAME}.csv
OUTFILE=$RUNDIR/${DSET_NAME}_${SLURM_ARRAY_TASK_ID}_${stimname}.h5
echo "STIM FILE" $stimfile
echo "OUTFILE" $OUTFILE
args="--outfile $OUTFILE --stim-file ${stimfile} --param-file ${paramfile} \
      --model $MODELNAME --num $NSAMPLES --print-every 1000"
srun -n 1 python run.py $args --create-params # create file that lists param values sampled
srun -n 1 python run.py $args --create # create output file
srun --label -n 64 python run.py $args 
chmod -R a+r $RUNDIR
