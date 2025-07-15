#!/bin/bash
#FLUX: --job-name=fix_dropped
#FLUX: -t=3600
#FLUX: --urgency=16

module use /project/6004902/modulefiles
module load presto
if [[ -z "${CHIPSPIPE_DIR}" ]];then
    # CHIPSPIPE_DIR isn't set, so use this default
    AFP="/home/${USER}/CHIME-Pulsar_automated_filterbank"
else
    AFP="${CHIPSPIPE_DIR}"
fi
SCRATCH_DIR=$(pwd)
FIL=$1
if [[ -d "$AFP" ]] && [[ -f "$AFP/fdp.py" ]];then
    cp $FIL ${SLURM_TMPDIR}
    #go to compute node
    cd ${SLURM_TMPDIR}
    python $AFP/fdp.py $FIL
    #come back from compute node
    cd $SCRATCH_DIR
    PULSAR=$(echo "$FIL" | cut -f 1 -d '.')
    cp ${SLURM_TMPDIR}/"$PULSAR"_fdp.fil $SCRATCH_DIR
    #clear tmpdir
    rm ${SLURM_TMPDIR}/*
else
    echo "Problem finding AFP directory of AFP/fdp.py file"
fi
