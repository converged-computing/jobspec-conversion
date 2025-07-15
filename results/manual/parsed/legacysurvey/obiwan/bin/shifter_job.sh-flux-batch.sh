#!/bin/bash
#FLUX: --job-name=tart-cupcake-4646
#FLUX: --queue=debug
#FLUX: --priority=16

export brick='1238p245'
export PYTHONPATH='.:${PYTHONPATH}'
export MKL_NUM_THREADS='1'

export brick=1238p245
module use /global/cscratch1/sd/kaylanb/test/obiwan/etc/modulefiles
for name in obiwan dust  legacysurvey  unwise_coadds  unwise_coadds_timeresolved; do
    module load $name
done  
export PYTHONPATH=/global/cscratch1/sd/kaylanb/test/legacypipe/py:${PYTHONPATH}
export PYTHONPATH=/global/cscratch1/sd/kaylanb/test/theValidator:${PYTHONPATH}
export PYTHONPATH=.:${PYTHONPATH}
export MKL_NUM_THREADS=1
mkdir logs
log="logs/$brick.log"
echo logging to $log
srun -n 1 -c 32 shifter python obiwan/kenobi.py -b ${brick} \
    -n 2 --DR 5 -o elg --add_sim_noise --zoom 1550 1650 1550 1650 \
    >> $log 2>&1
