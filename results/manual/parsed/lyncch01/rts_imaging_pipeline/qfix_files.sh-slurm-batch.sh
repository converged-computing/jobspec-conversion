#!/bin/bash
#FLUX: --job-name=edit_fixfile
#FLUX: --queue=workq
#FLUX: -t=600
#FLUX: --urgency=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/pawsey/intel/19.0.5/mkl/lib/intel64/'

CURRENTDATE=`date +%Y_%m_%d`
obsarr=()
while IFS= read -r line || [[ "$line" ]]; do
        obsarr+=("$line")
done < LoBES13_093_corr.txt 
OBSID=${obsarr[${SLURM_ARRAY_TASK_ID}]}
mkdir ${OBSID}
cd "${OBSID}/"
DATPTH="/astro/mwaeor/MWA/data/${OBSID}/${CURRENTDATE}/uvdump*uvfits"
cp ${DATPTH} .
METPTH="/astro/mwaeor/MWA/data/${OBSID}/${CURRENTDATE}/${OBSID}.metafits"
cp ${METPTH} .
module load python-singularity
time python ../correct_rtsuvfits.py 
module load casa/5.6.1-8
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/pawsey/intel/19.0.5/mkl/lib/intel64/
time casa --nologger -c ../rts_uv2ms.py 
module load cotter
time python ../fixMS.py $OBSID 
