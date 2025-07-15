#!/bin/bash
#FLUX: --job-name=misunderstood-diablo-8342
#FLUX: --priority=16

PLIST=$1
BIND=$( python3 $HOME/parse_settings.py --BIND ) # SEE --> https://github.com/jurjen93/lofar_vlbi_helpers/blob/main/parse_settings.py
SIMG=$( python3 $HOME/parse_settings.py --SIMG )
LOFAR_HELPERS=$( python3 $HOME/parse_settings.py --lofar_helpers )
SCRIPT_DIR=$PWD
mkdir -p phasediff_h5s
DIR=$( awk NR==${SLURM_ARRAY_TASK_ID} $PLIST )
echo "$DIR"
mkdir $DIR
cp -r *${DIR}*.ms $DIR
cd $DIR
chmod 755 ${SCRIPT_DIR}/*
singularity exec -B $BIND $SIMG ${SCRIPT_DIR}/phasediff_multi.sh
mv scalarphasediff0*phaseup.h5 ../phasediff_h5s
cd ../
singularity exec -B $BIND $SIMG python ${SCRIPT_DIR}/phasediff_output.py --h5 phasediff_h5s/*.h5
