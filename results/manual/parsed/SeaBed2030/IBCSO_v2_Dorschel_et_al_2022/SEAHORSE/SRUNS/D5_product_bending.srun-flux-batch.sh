#!/bin/bash
#FLUX: --job-name=evasive-hobbit-9611
#FLUX: -c=12
#FLUX: --urgency=16

export SSD_DIR='$(getSSD)  # get new ssd dir from tmp/tmp_$SLURM_JOBID'

module purge 2>/dev/null
module load ${CONDA} 2>/dev/null
source activate ${CONDA_ENV}
which python
TYPE=$1	# get type (e.g. median)
export SSD_DIR=$(getSSD)  # get new ssd dir from tmp/tmp_$SLURM_JOBID
NN_FILE=${RASTERPRODUCT}/${timestamp}_${TYPE}_high_NN.tif
MASK_FILE=${RASTERPRODUCT}/${timestamp}_${TYPE}_high_mask_NN.tif
SURF_FILE=${RASTERPRODUCT}/${timestamp}_${TYPE}_low_surf.tif
SSD_SURF=${SSD_DIR}/${timestamp}_${TYPE}_low_surf.tif
SSD_NN=${SSD_DIR}/${timestamp}_${TYPE}_high_NN.tif
SSD_MASK=${SSD_DIR}/${timestamp}_${TYPE}_high_mask_NN.tif
echo "SLURM_JOBID:	$SLURM_JOBID"
echo "EVOKER:	$EVOKER"
START_TIME=$(date -u +"%Y-%m-%d %T")
START_UNIX=$(date -u +%s%3N)
echo "START TIME:	$START_TIME"
cp ${NN_FILE} ${SSD_NN}
cp ${MASK_FILE} ${SSD_MASK}
cp ${SURF_FILE} ${SSD_SURF}
cd ${SSD_DIR}
python ${PYDIR}/D5_product_bending.py ${BENDING_SETTINGS} ${SSD_SURF} ${SSD_NN} ${SSD_MASK} ${TYPE}
mv ${SSD_DIR}/*${TYPE}_composite*.tif ${RASTERPRODUCT}
mv ${SSD_DIR}/*${TYPE}_transition*.tif ${RASTERPRODUCT}
mv ${SSD_DIR}/*.html ${LOGDIR} # dask performance report
mv ${SSD_DIR}/*.csv ${LOGDIR} 2>/dev/null # dask memory usage report (per task)
rm ${SSD_DIR}/${timestamp}_${TYPE}_*.tif 2>/dev/null
END_TIME=$(date -u +"%Y-%m-%d %T")
END_UNIX=$(date -u +%s%3N) #unix time in ms
echo "END TIME:	$END_TIME"
echo "CSVLINE	$SLURM_JOB_NAME	$SLURM_JOB_ID	$SLURM_ARRAY_TASK_ID	$SLURM_ARRAY_TASK_COUNT	$EVOKER	$SLURM_JOB_PARTITION	$FILESIZE_TRUE	$START_UNIX	$END_UNIX"
