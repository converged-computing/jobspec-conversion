#!/bin/bash
#FLUX: --job-name=purple-eagle-0938
#FLUX: --queue=long
#FLUX: -t=259200
#FLUX: --urgency=16

module load gcc
module load python3
module load bright/7.3  # for hdf5_18
module load hdf5_18
cd $SLURM_SUBMIT_DIR
: ${PARAMS?Must define PARAMS}
if [ -z "$PARAMS" ]
then
    echo "Must define PARAMS (is empty)."
    exit 1
fi
SEED=$(printf "%06d" $RANDOM); 
echo "Chrom number $SLURM_ARRAY_TASK_ID - seed $SEED"
ALL_PARAMS="$PARAMS -d $SEED"
echo "$ALL_PARAMS"
/usr/bin/time --format='elapsed: %E / kernel: %S / user: %U / mem: %M' \
     ./msp-sim.py $ALL_PARAMS | grep -v REJECTING
echo "Done!"
