#!/bin/bash
#FLUX: --job-name=rts_setup
#FLUX: --queue=workq
#FLUX: -t=600
#FLUX: --urgency=16

module use /pawsey/mwa/software/python3/modulefiles
module load python-singularity
module load mongoose
module load hyperdrive
CURRENTDATE=`date +%Y_%m_%d`
obsarr=()
while IFS= read -r line || [[ "$line" ]]; do
        obsarr+=("$line")
done < LoBES13_093_corr.txt 
OBSID=${obsarr[${SLURM_ARRAY_TASK_ID}]}
python edit_rts.py ${CURRENTDATE} ${OBSID}
obspath="/astro/mwaeor/MWA/data/$OBSID/${CURRENTDATE}"
obspath2="/astro/mwaeor/MWA/data/$OBSID"
cd $obspath2
unzip -n "${OBSID}_flags.zip"
cd $obspath
METAFITS=$(find .. -maxdepth 1 -name "*.metafits" -print -quit)
[ $META ] && echo "No metafits file in parent directory!" && exit 1
cp ${METAFITS} .
METAFITS="${PWD}/$(basename "${METAFITS}")"
echo "Using ${METAFITS}"
set -eux
overwrite-metafits-delays "${METAFITS}"
srclist by-beam -i rts -m ${OBSID}.metafits -n 300 -o rts --collapse-into-single-source --source-dist-cutoff 50 /astro/mwaeor/clynch/catalog/srclist_pumav3_EoR0aegean_fixedEoR1pietro+ForA_phase1+2_GSCRB_GLMGP.txt srclist_pumav3_EoR0aegean_fixedEoR1pietro+ForA_phase1+2_GSCRB_GLMGP_${OBSID}_patch300.txt
srclist by-beam -i rts -m ${OBSID}.metafits -n 10 -o rts --source-dist-cutoff 50 /astro/mwaeor/clynch/catalog/srclist_pumav3_EoR0aegean_fixedEoR1pietro+ForA_phase1+2_GSCRB_GLMGP.txt srclist_pumav3_EoR0aegean_fixedEoR1pietro+ForA_phase1+2_GSCRB_GLMGP_${OBSID}_peel10.txt
cd $obspath2
time reflag-mwaf-files
cd $obspath
rts-in-file-generator patch \
                      --base-dir .. \
                      --metafits "${METAFITS}" \
                      --srclist srclist_pumav3_EoR0aegean_fixedEoR1pietro+ForA_phase1+2_GSCRB_GLMGP_${OBSID}_patch300.txt \
					  --use-fee-beam \
                      --subband-ids 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 \
                      -o rts_patch.in
rts-in-file-generator peel \
                      --base-dir .. \
                      --metafits "${METAFITS}" \
                      --srclist srclist_pumav3_EoR0aegean_fixedEoR1pietro+ForA_phase1+2_GSCRB_GLMGP_${OBSID}_peel10.txt \
		      		  --num-primary-cals 0 \ #Number of sources with full DD calibration
					  --use-fee-beam \
		              --num-cals 1 \ #Number of ionospheric calibrators
		              --num-peel 1 \ #Number of sources to remove from the data
		              --subband-ids 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 \
                      -o rts_peel.in
