#!/bin/bash
#FLUX: --job-name=ornery-fudge-4041
#FLUX: --urgency=16

module purge
module load gcc openmpi eccodes anaconda # the stuff other than anaconda was to ensure eccodes loaded correctly
source activate mrms_processing
source __utils.sh
source __directories.sh
cd ${assar_dirs[repo]}
YEARS=$(seq 2001 2022)
for YEAR in ${YEARS}
do
	year=${YEAR}
	determine_month_and_day ${YEAR} ${SLURM_ARRAY_TASK_ID}
	month=${array_out[0]}
	day=${array_out[1]}
	# process the mrms mesonet grib data
	# echo "Node ID: $HOSTNAME"
	# echo "Slurm Array Task ID: ${SLURM_ARRAY_TASK_ID}"
	python ${assar_dirs[hpc_da]}  ${year}${month}${day} ${assar_dirs[raw_mrms]} ${assar_dirs[raw_nssl]} ${assar_dirs[raw_mrms_quantized]} ${assar_dirs[scratch_zarrs]} ${assar_dirs[scratch_gribs]} ${assar_dirs[out_fullres_dailyfiles]}
	# echo "Finished attempt to create netcdf for ${year}${month}${day}"
done
