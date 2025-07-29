#!/bin/bash
#FLUX: --job-name=E0001
#FLUX: -N=100
#FLUX: --queue=workq
#FLUX: -t=3600
#FLUX: --urgency=16

export EXPERIMENT_NAME='$SLURM_JOB_NAME'
export TOTAL_NC='$SLURM_JOB_NUM_NODES'
export LAMMPS_NC='50'
export LAMMPS_PPN='4'
export GPCNET_NC='50'
export GPCNET_PPN='64'
export APP_BASE_DIR='/home/users/msrinivasa/develop'
export DATA_DIR='./data'
export EXPERIMENT_METAFILE='$EXPERIMENT_NAME.README.txt'
export EXPERIMENT_JOBFILE='$EXPERIMENT_NAME.JOBFILE.csv'
export PAT_RT_EXPDIR_BASE='$DATA_DIR/lammps/congested'
export LAMMPS_IDLE_START='`date -uI'seconds'`'
export LAMMPS_IDLE_END='`date -uI'seconds'`'
export GPCNET_START='`date -uI'seconds'`'
export LAMMPS_CONGESTED_START='`date -uI'seconds'`'
export LAMMPS_CONGESTED_END='`date -uI'seconds'`'
export GPCNET_END='`date -uI'seconds'`'

module restore PrgEnv-cray
module load perftools-base
module load perftools
export EXPERIMENT_NAME=$SLURM_JOB_NAME
export TOTAL_NC=$SLURM_JOB_NUM_NODES
export LAMMPS_NC=50
export LAMMPS_PPN=4
export GPCNET_NC=50
export GPCNET_PPN=64
export APP_BASE_DIR=/home/users/msrinivasa/develop
export DATA_DIR=./data
export EXPERIMENT_METAFILE=$EXPERIMENT_NAME.README.txt
export EXPERIMENT_JOBFILE=$EXPERIMENT_NAME.JOBFILE.csv
mkdir -p $DATA_DIR
echo $EXPERIMENT_NAME>$EXPERIMENT_METAFILE
echo "Total Allocation: "$TOTAL_NC>>$EXPERIMENT_METAFILE
echo "GPCNet Allocation: "$GPCNET_NC>>$EXPERIMENT_METAFILE
echo "LAMMPS Allocation: "$LAMMPS_NC>>$EXPERIMENT_METAFILE
echo "Nodelist: "$SLURM_JOB_NODELIST>>$EXPERIMENT_METAFILE
export PAT_RT_EXPDIR_BASE=$DATA_DIR/lammps/idle
mkdir -p $PAT_RT_EXPDIR_BASE
export LAMMPS_IDLE_START=`date -uI'seconds'`
srun --relative=0 \
     --nodes=$LAMMPS_NC \
     --ntasks-per-node=$LAMMPS_PPN \
    $APP_BASE_DIR/lammps/build/lmp+tracing \
    -i $APP_BASE_DIR/lammps/examples/DIFFUSE/in.msd.2d \
    > $PAT_RT_EXPDIR_BASE/lammps.idle.out
export LAMMPS_IDLE_END=`date -uI'seconds'`
sleep 30
export PAT_RT_EXPDIR_BASE=$DATA_DIR/gpcnet
mkdir -p $PAT_RT_EXPDIR_BASE
export GPCNET_START=`date -uI'seconds'`
srun --relative=$LAMMPS_NC \
     --nodes=$GPCNET_NC \
     --ntasks-per-node $GPCNET_PPN \
     $APP_BASE_DIR/GPCNET/network_load_test+pat \
     > $PAT_RT_EXPDIR_BASE/gpcnet.out &
sleep 30
export PAT_RT_EXPDIR_BASE=$DATA_DIR/lammps/congested
mkdir -p $PAT_RT_EXPDIR_BASE
export LAMMPS_CONGESTED_START=`date -uI'seconds'`
srun --relative=0 \
     --nodes=$LAMMPS_NC \
     --ntasks-per-node=$LAMMPS_PPN \
     $APP_BASE_DIR/lammps/build/lmp+tracing \
     -i $APP_BASE_DIR/lammps/examples/DIFFUSE/in.msd.2d \
     > $PAT_RT_EXPDIR_BASE/lammps.congested.out
export LAMMPS_CONGESTED_END=`date -uI'seconds'`
wait
export GPCNET_END=`date -uI'seconds'`
echo "start_time,end_time,job_id,job_name,user">$EXPERIMENT_JOBFILE
echo $LAMMPS_IDLE_START,$LAMMPS_IDLE_END,$EXPERIMENT_NAME.01,$EXPERIMENT_NAME.LAMMPS.IDLE,$USER>>$EXPERIMENT_JOBFILE
echo $GPCNET_START,$GPCNET_END,$EXPERIMENT_NAME.02,$EXPERIMENT_NAME.GPCNET.AGGRESSOR,$USER>>$EXPERIMENT_JOBFILE
echo $LAMMPS_CONGESTED_START,$LAMMPS_CONGESTED_END,$EXPERIMENT_NAME.03,$EXPERIMENT_NAME.LAMMPS.CONGESTED,$USER>>$EXPERIMENT_JOBFILE
rm *.dat
rm *.rec
rm log.lammps
