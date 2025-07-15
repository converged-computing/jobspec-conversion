#!/bin/bash
#FLUX: --job-name=E0002
#FLUX: -N=100
#FLUX: --queue=workq
#FLUX: -t=3600
#FLUX: --priority=16

export EXPERIMENT_NAME='$SLURM_JOB_NAME'
export TOTAL_NC='$SLURM_JOB_NUM_NODES'
export LAMMPS_NC='100'
export LAMMPS_PPN='64'
export Px='15'
export Py='15'
export Pz='15'
export APP_BASE_DIR='/lus/cls01053/msrinivasa/develop'
export LMP_ROOT='$APP_BASE_DIR/lammps'
export DATA_DIR='./data'
export EXPERIMENT_METAFILE='$EXPERIMENT_NAME.README.txt'
export EXPERIMENT_JOBFILE='$EXPERIMENT_NAME.JOBFILE.csv'
export PAT_RT_EXPDIR_BASE='$DATA_DIR/lammps/idle'
export LAMMPS_IDLE_START='`date -uI'seconds'`'
export LAMMPS_IDLE_END='`date -uI'seconds'`'

module restore PrgEnv-cray
module load perftools-base
module load perftools
export EXPERIMENT_NAME=$SLURM_JOB_NAME
export TOTAL_NC=$SLURM_JOB_NUM_NODES
export LAMMPS_NC=100
export LAMMPS_PPN=64
export Px=15
export Py=15
export Pz=15
export APP_BASE_DIR=/lus/cls01053/msrinivasa/develop
export LMP_ROOT=$APP_BASE_DIR/lammps
export DATA_DIR=./data
export EXPERIMENT_METAFILE=$EXPERIMENT_NAME.README.txt
export EXPERIMENT_JOBFILE=$EXPERIMENT_NAME.JOBFILE.csv
mkdir -p $DATA_DIR
echo $EXPERIMENT_NAME>$EXPERIMENT_METAFILE
echo "Total Allocation: "$TOTAL_NC>>$EXPERIMENT_METAFILE
echo "LAMMPS Allocation: "$LAMMPS_NC>>$EXPERIMENT_METAFILE
echo "Nodelist: "$SLURM_JOB_NODELIST>>$EXPERIMENT_METAFILE
export PAT_RT_EXPDIR_BASE=$DATA_DIR/lammps/idle
mkdir -p $PAT_RT_EXPDIR_BASE
export LAMMPS_IDLE_START=`date -uI'seconds'`
srun --relative=0 \
     --nodes=$LAMMPS_NC \
     --ntasks-per-node=$LAMMPS_PPN \
     $LMP_ROOT/build/lmp+tracing \
     -var x $Px -var y $Py -var z $Pz \
     -in $LMP_ROOT/perftools/inputfiles/in.rhodo.scaled \
     > $PAT_RT_EXPDIR_BASE/lammps.idle.out
export LAMMPS_IDLE_END=`date -uI'seconds'`
echo "start_time,end_time,job_id,job_name,user">$EXPERIMENT_JOBFILE
echo $LAMMPS_IDLE_START,$LAMMPS_IDLE_END,$EXPERIMENT_NAME.01,$EXPERIMENT_NAME.LAMMPS.IDLE,$USER>>$EXPERIMENT_JOBFILE
