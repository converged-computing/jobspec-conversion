#!/bin/bash
#FLUX: --job-name=hcpParcelTS
#FLUX: -t=1800
#FLUX: --priority=16

export subject='$(sed -n "${SLURM_ARRAY_TASK_ID}p" ${SUBJECT_LIST})'

SUBJECT_LIST="/home/kaqu0001/projects/DiCER/hcp_processing/WHITE1andWHITE2_remaining.txt"
export subject=$(sed -n "${SLURM_ARRAY_TASK_ID}p" ${SUBJECT_LIST})
echo -e "\t\t\t --------------------------- "
echo -e "\t\t\t ----- ${SLURM_ARRAY_TASK_ID} ${subject} ----- "
echo -e "\t\t\t --------------------------- \n"
module load connectome
module load matlab
working_hcp_dir=/scratch/kg98/HCP_grayordinates_processed/
hcpmatlabtools=/home/kaqu0001/projects/matlabHCPtools/
giftitoolbox=/home/kaqu0001/projects/gifti/
fileToRegress=$working_hcp_dir"/"$subject"/"$subject"_rest_dm.nii.gz"
gm_signal=$working_hcp_dir"/"$subject"/"$subject"_rest_GMsignal.txt"
GMR_output=$working_hcp_dir"/"$subject"/"$subject"_rest_dm_GMR.nii.gz"
fsl_regfilt -i $fileToRegress -d $gm_signal -f 1 -o $GMR_output
template_cifti=$working_hcp_dir"/"$subject"/"$subject"_all_rest_Atlas_MSMAll.dtseries.nii"
parcel_time_series () {
	# First have to split up the regressor file
	preproType=$1
	fileTimeSeries=$working_hcp_dir"/"$subject"/"$subject"_rest_"$preproType".nii.gz"
	temp_cifti=$working_hcp_dir"/"$subject"/"$subject"_all_rest_Atlas_MSMAll"$preproType".dtseries.nii"
	temp_gifti=$working_hcp_dir"/"$subject"/"$subject"_all_rest_Atlas_MSMAll"$preproType".func.gii"
	# Convert the file to a cifti
	wb_command -cifti-convert -from-nifti $fileTimeSeries $template_cifti $temp_cifti
	# Convert the file to a gifti
	wb_command -cifti-convert -to-gifti-ext $temp_cifti $temp_gifti
	# Now remove the cifti
	rm -rf $temp_cifti
	# Run the matlab script
	output_tsv=$working_hcp_dir"/parcel_cortical_subcortical/"$preproType"/"$subject"_rest_"$preproType".tsv"
	matlab -nodisplay -r "addpath(genpath('${hcpmatlabtools}'));addpath(genpath('${giftitoolbox}'));create_parcel_series('${temp_gifti}','${output_tsv}'); exit"
	rm -rf $temp_gifti
	rm -rf $working_hcp_dir"/"$subject"/"$subject"_all_rest_Atlas_MSMAll"$preproType".func.gii.data"
}
parcel_time_series "dm"
parcel_time_series "dm_GMR"
parcel_time_series "dm_dbscan"
