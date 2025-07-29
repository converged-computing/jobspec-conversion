#!/bin/bash
#SBATCH --account=quinnlab_paid
#SBATCH --output=_script_outputs/%x/%A_%a_%N.out
#SBATCH --error=_script_errors/%x/%A_%a_%N.out
#SBATCH --mail-user=dcl3nd@virginia.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=80000
#SBATCH --time=2-00:00:00
#SBATCH --partition=standard
#SBATCH --array=10,11,12,3,4,5,7,8,9
#SBATCH --exclude=udc-ba26-18,udc-ba27-14,udc-ba26-16,udc-ba26-17

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
