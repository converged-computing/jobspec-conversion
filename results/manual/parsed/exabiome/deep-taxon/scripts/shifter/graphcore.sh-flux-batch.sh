#!/bin/bash
#FLUX: --job-name=n16_b512_SHFTR
#FLUX: -n=64
#FLUX: -c=16
#FLUX: -t=21600
#FLUX: --urgency=16

INPUT="$PSCRATCH/exabiome/deep-taxon/input/gtdb/r207/r207.rep.h5"
REPO_DIR="$HOME/projects/exabiome/deep-taxon.git"
SCRIPT="$REPO_DIR/bin/deep-taxon.py"
NODES=16
JOB="$SLURM_JOB_ID"
OUTDIR="runs/train.$JOB"
CONF="$OUTDIR.yml"
mkdir -p $OUTDIR
cp $0 $OUTDIR.sh
cp $REPO_DIR/configs/graphcore.yml $CONF
LOG="$OUTDIR.log"
OPTIONS="--csv --slurm -g 4 -n $NODES -e 6 -k 6 -y -D -E shifter_n${NODES}_g4"
CMD="$SCRIPT train $OPTIONS $CONF $INPUT $OUTDIR"
mv train.$JOB.log $LOG
srun --ntasks $(($NODES*4)) shifter python $CMD > $LOG 2>&1
