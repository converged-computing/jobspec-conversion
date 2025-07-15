#!/bin/bash
#FLUX: --job-name=aoflagger
#FLUX: --urgency=16

SIMG=$( python3 $HOME/parse_settings.py --SIMG )
SING_BIND=$( python3 $HOME/parse_settings.py --BIND )
pattern="sub6asec*.ms"
MS_FILES=( $pattern )
SB=${MS_FILES[${SLURM_ARRAY_TASK_ID}]}
RUNDIR=$TMPDIR/subtract_${SLURM_ARRAY_TASK_ID}
OUTDIR=$PWD
mkdir -p $RUNDIR
cp -r $SB $RUNDIR
cp $SIMG $RUNDIR
cd $RUNDIR
singularity exec -B $PWD ${SIMG##*/} aoflagger ${SB##*/}
mv ${SB##*/} $OUTDIR/flagged_${SB##*/}
