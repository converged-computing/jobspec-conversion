#!/bin/bash
#FLUX: --job-name=run_make_deltas_v${V_CODE_MAJOR}.${V_CODE_MINOR}
#FLUX: --queue=debug
#FLUX: -t=1800
#FLUX: --urgency=16

export OMP_NUM_THREADS='64'

BASEDIR="/project/projectdirs/desi/users/jfarr/LyaCoLoRe_paper/"
LYACOLORE_PATH="/global/homes/j/jfarr/Projects/LyaCoLore/"
V_CODE_MAJOR=9
V_CODE_MINOR=0
V_REALISATIONS=`echo {0..9}`
NPROC=32
NSIDE=16
FLAGS=""
RUN_LYA_AUTO=1
RUN_QSO_AUTO=1
RUN_DLA_AUTO=1
RUN_LYA_AA_AUTO=1
RUN_LYA_QSO_CROSS=1
RUN_LYA_DLA_CROSS=1
RUN_QSO_DLA_CROSS=1
for r in $V_REALISATIONS; do
DELTADIRNAME="$BASEDIR/v${V_CODE_MAJOR}.${V_CODE_MINOR}.${r}/data/picca_input/deltas/"
ZCAT_DIRNAME="$BASEDIR/v${V_CODE_MAJOR}.${V_CODE_MINOR}.${r}/data/picca_input/catalogs/"
if (( $RUN_LYA_AUTO == 1)) ; then
fi
echo "Run file will be written to "$RUN_FILE
cat > $RUN_FILE <<EOF
umask 0002
export OMP_NUM_THREADS=64
python $LYACOLORE_PATH/scripts/make_picca_deltas_from_transmission.py --in-dir $INDIRNAME --out-dir $OUTDIRNAME --nproc $NPROC --downsampling $DS --downsampling-seed $DS_SEED --DLA-z-buffer $DLA_Z_BUFFER --lambda-obs-min $lObs_min --lambda-obs-max $lObs_max --lamdba-RF-min $lRF_min --lambda-RF-max $lRF_max $FLAGS
wait
date
EOF
done
