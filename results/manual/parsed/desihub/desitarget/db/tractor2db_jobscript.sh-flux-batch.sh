#!/bin/bash
#FLUX: --job-name=prodload
#FLUX: --queue=regular
#FLUX: -t=90000
#FLUX: --urgency=16

export NERSC_HOST='`/usr/common/usg/bin/nersc_host`'
export OMP_NUM_THREADS='${CORES_ON_NODE}'

cd $SLURM_SUBMIT_DIR
sanity="prodload_jobids.txt"
echo "SLURM_JOBID="$SLURM_JOBID >> ${sanity}
export NERSC_HOST=`/usr/common/usg/bin/nersc_host`
if [ "$NERSC_HOST" == "cori" ] ; then
    export CORES_ON_NODE=32
elif [ "$NERSC_HOST" == "edison" ] ; then
    export CORES_ON_NODE=24
fi
export OMP_NUM_THREADS=${CORES_ON_NODE}
echo cores=${OMP_NUM_THREADS}
date
srun -n 1 -c ${OMP_NUM_THREADS} python tractor_load.py --cores ${OMP_NUM_THREADS} --list_of_cats dr3_cats_qso.txt --schema dr3 --load_db
date
echo DONE
