#!/bin/bash
#FLUX: --job-name=docker
#FLUX: --queue=debug
#FLUX: -t=300
#FLUX: --urgency=16

export brick='1238p245'
export obiwan_code='$CSCRATCH/obiwan_code'
export PYTHONPATH='.:${PYTHONPATH}'
export obiwan_data='$CSCRATCH/obiwan_data'
export LEGACY_SURVEY_DIR='${obiwan_data}/legacysurveydir_dr5'
export obiwan_outdir='$CSCRATCH/obiwan_outdir'
export MKL_NUM_THREADS='1'

export brick=1238p245
export obiwan_code=$CSCRATCH/obiwan_code
export PYTHONPATH=$obiwan_code/obiwan/py:${PYTHONPATH}
export PYTHONPATH=$obiwan_code/legacypipe/py:${PYTHONPATH}
export PYTHONPATH=$obiwan_code/theValidator:${PYTHONPATH}
export PYTHONPATH=.:${PYTHONPATH}
module use $obiwan_code/obiwan/etc/modulefiles
for name in dust unwise_coadds  unwise_coadds_timeresolved; do
    module load $name
done  
export obiwan_data=$CSCRATCH/obiwan_data
export LEGACY_SURVEY_DIR=${obiwan_data}/legacysurveydir_dr5
export obiwan_outdir=$CSCRATCH/obiwan_outdir
log="${obiwan_outdir}/logs/${brick}.log"
mkdir -p $(dirname $log)
export MKL_NUM_THREADS=1
echo logging to $log
srun -n 1 -c 32 shifter python obiwan/kenobi.py -b ${brick} \
    -n 2 --DR 5 -o elg --outdir $obiwan_outdir \
    --add_sim_noise --zoom 1550 1650 1550 1650 \
    >> $log 2>&1
