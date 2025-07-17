#!/bin/bash
#FLUX: --job-name=n1_g1_b16_r0.001
#FLUX: -n=8
#FLUX: -c=10
#FLUX: --gpus-per-task=1
#FLUX: --queue=regular
#FLUX: -t=14399
#FLUX: --urgency=16

INPUT=${1:?"Please provide an input file"}
FEATS_CKPT=${2:?"Please provide a checkpoint file for features"}
CONDA_ENV=${3:?"Please provide the conda environment ot use"}
conda activate $CONDA_ENV 
MAIN_OUTDIR="./test_ckpt_restart/datasets/full/chunks_W4000_S4000/resnet_clf/C/n1_g1_b16_r0.001"
mkdir -p $MAIN_OUTDIR
JOB="TESTCKPT.0"
OPTIONS=" --profile -C -b 16 -d -g 1 -n 1 -o 256 -W 4000 -S 4000 -r 0.001 -A 1 -e 30 -l -s 2222 -F $FEATS_CKPT -E n1_g1_b16_r0.001"
OUTDIR="$MAIN_OUTDIR/train.$JOB"
LOG="$OUTDIR.log"
CMD="deep-index train --slurm $OPTIONS resnet_clf $INPUT $OUTDIR"
cp $0 $OUTDIR.sh
mkdir -p $OUTDIR
echo "$CMD > $LOG"
srun $CMD > $LOG 2>&1
JOB="TESTCKPT.1"
CKPT=`ls $OUTDIR/epoch*ckpt`
OPTIONS=" --profile -C -b 16 -g 1 -d -n 1 -o 256 -W 4000 -S 4000 -r 0.001 -A 1 -e 30 -l -s 2222 -c $CKPT -E n1_g1_b16_r0.001"
OUTDIR="$MAIN_OUTDIR/train.$JOB"
LOG="$OUTDIR.log"
CMD="deep-index train --slurm $OPTIONS resnet_clf $INPUT $OUTDIR"
cp $0 $OUTDIR.sh
mkdir -p $OUTDIR
echo "$CMD > $LOG"
srun $CMD > $LOG 2>&1
JOB="TESTCKPT.2"
CKPT=`ls $OUTDIR/epoch*ckpt`
OPTIONS=" --profile -C -b 16 -g 1 -d -n 1 -o 256 -W 4000 -S 4000 -r 0.001 -A 1 -e 30 -l -s 2222 -c $CKPT -E n1_g1_b16_r0.001"
OUTDIR="$MAIN_OUTDIR/train.$JOB"
LOG="$OUTDIR.log"
CMD="deep-index train --slurm $OPTIONS resnet_clf $INPUT $OUTDIR"
cp $0 $OUTDIR.sh
mkdir -p $OUTDIR
echo "$CMD > $LOG"
srun $CMD > $LOG 2>&1
JOB="TESTCKPT.3"
CKPT=`ls $OUTDIR/epoch*ckpt`
OPTIONS=" --profile -C -b 16 -g 1 -d -n 1 -o 256 -W 4000 -S 4000 -r 0.001 -A 1 -e 30 -l -s 2222 -c $CKPT -E n1_g1_b16_r0.001"
OUTDIR="$MAIN_OUTDIR/train.$JOB"
LOG="$OUTDIR.log"
CMD="deep-index train --slurm $OPTIONS resnet_clf $INPUT $OUTDIR"
cp $0 $OUTDIR.sh
mkdir -p $OUTDIR
echo "$CMD > $LOG"
srun $CMD > $LOG 2>&1
