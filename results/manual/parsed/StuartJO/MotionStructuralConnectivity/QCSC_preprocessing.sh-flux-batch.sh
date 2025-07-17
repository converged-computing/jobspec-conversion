#!/bin/bash
#FLUX: --job-name=lovely-leopard-6447
#FLUX: -c=10
#FLUX: -t=172800
#FLUX: --urgency=16

export FSLSUB_LOCAL_RUN='YES'
export FSLOUTPUTTYPE='NIFTI'

declare -i ID=$SLURM_ARRAY_TASK_ID
echo $SLURM_ARRAY_TASK_ID
SUBJECT_LIST="/scratch/kg98/stuarto/SCQC_project/SUBJECT_LIST.txt"
SUBJECTID=$(sed -n "${ID}p" ${SUBJECT_LIST})
STUDY=MRH035_
SESSION=_MR01
SUBJECTDIR="$STUDY$SUBJECTID$SESSION";
RESTART=0
PARENTDIR="/scratch/kg98/stuarto/GenCog_xnat"
OUTDIR="/scratch/kg98/stuarto/SCQC_project"
WHERESMYSCRIPT="/scratch/kg98/stuarto/SCQC_project"
PARC_LIST="random200ANDfslatlas20"
DIFFUSION_DATA_EDDY2_PATH="${PARENTDIR}/${SUBJECTDIR}/diffusion/EDDY2.mif"
DIFFUSION_DATA_EDDY1_PATH="${PARENTDIR}/${SUBJECTDIR}/diffusion/EDDY1.mif"
BRAIN_PATH="${PARENTDIR}/${SUBJECTDIR}/T1w/brain_NativeAnat.nii"
T1w_PATH="${PARENTDIR}/${SUBJECTDIR}/T1w/T1w_NativeAnat.nii"
ACT_PATH="${PARENTDIR}/${SUBJECTDIR}/ACT/ACT_NativeAnat.nii"
RUN_COPY_DATA=0
RUN_COPY_PARC=1;
FIX_HCPMMP1_HIPP=0;
RUN_DWI_REG=0
RUNMAIN=1
RUNTRACT=0
RUNSIFT=0
RUNTCKSAMPLE=0
RUNCONN=1
WORKDIR="${OUTDIR}/${SUBJECTID}"
date
module load mrtrix/0.3.15-gcc5
module load fsl/5.0.11
module load matlab
module load freesurfer/5.3
NUM=2000000
if [ "${SUBJECTID}" = "" ]; then
	echo "ERROR! SUBJECTID not definied. Exiting"
	exit
fi
export FSLSUB_LOCAL_RUN=YES
export FSLOUTPUTTYPE="NIFTI"
if [ "${RUN_COPY_DATA}" = 1 ]; then
    	if [ -d "${WORKDIR}" ]; then
		if [ "${RESTART}" = 1 ]; then
        	echo -e "${WORKDIR} already exists. Removing."
        	rm -Rf ${WORKDIR}
        	mkdir ${WORKDIR}
		fi
    	elif [ ! -d "${WORKDIR}" ]; then
        	echo -e "No such directory: ${WORKDIR}\n"
        	mkdir ${WORKDIR}
	fi
	cp -Rfv ${DIFFUSION_DATA_EDDY2_PATH} ${WORKDIR}/dwi_EDDY2.mif
	cp -Rfv ${DIFFUSION_DATA_EDDY1_PATH} ${WORKDIR}/dwi_EDDY1.mif
	cp -Rfv ${BRAIN_PATH} ${WORKDIR}/brain.nii
	cp -Rfv ${T1w_PATH} ${WORKDIR}/T1w.nii
	mrconvert ${ACT_PATH} ${WORKDIR}/ACT_FSL.nii -stride -1,2,3,4
fi
if [ "${RUN_COPY_PARC}" = 1 ]; then
	# This copies in parcellation data from its original location
	for PARC_TYPE in ${PARC_LIST}; do
		mrconvert -force ${PARENTDIR}/${SUBJECTDIR}/${PARC_TYPE}/${PARC_TYPE}_NativeAnat.nii ${WORKDIR}/${PARC_TYPE}.nii -stride -1,2,3
	done
	if [ "${FIX_HCPMMP1_HIPP}" = 1 ]; then
	cp -rf ${WORKDIR}/HCPMMP1ANDfslatlas20.nii ${WORKDIR}/HCPMMP1ANDfslatlas20_poor_hipp.nii
	rm ${WORKDIR}/HCPMMP1ANDfslatlas20.nii
	# Get the left hippocampus and binarise and make its new value the same as the right hippocampus. Binarise the value for the right hippocampus. Reverse the mask by adding 1, subtracting 2 and getting the absolute value. This mask indicates all regions which are not hippocampus ROIs. Multiply the original image by this mask to remove hippocampus regions
	fslmaths ${WORKDIR}/HCPMMP1ANDfslatlas20_poor_hipp.nii -thr 120 -uthr 120 -bin -mul 310 -add ${WORKDIR}/HCPMMP1ANDfslatlas20_poor_hipp.nii -thr 310 -uthr 310 -bin -add 1 -sub 2 -abs -mul ${WORKDIR}/HCPMMP1ANDfslatlas20_poor_hipp.nii ${WORKDIR}/HCPMMP1ANDfslatlas20_no_hipp.nii
	fslmaths ${WORKDIR}/aparcANDfirst.nii -thr 39 -uthr 39 -bin -mul 120 ${WORKDIR}/L_Hipp.nii
	fslmaths ${WORKDIR}/aparcANDfirst.nii -thr 80 -uthr 80 -bin -mul 310 ${WORKDIR}/R_Hipp.nii
		# Binarise the hippocampus masks, add 1 then subtract 2 and then get the absolute values to created an inverted mask. Multiply the parcellation by the inverted image to 
		# remove any voxels they were labelled in the hippocampus and then add on the masks 
	fslmaths ${WORKDIR}/L_Hipp.nii.gz -add ${WORKDIR}/R_Hipp.nii.gz -bin -add 1 -sub 2 -abs -mul ${WORKDIR}/HCPMMP1ANDfslatlas20_no_hipp.nii -add ${WORKDIR}/L_Hipp.nii -add ${WORKDIR}/R_Hipp.nii ${WORKDIR}/HCPMMP1ANDfslatlas20.nii
	mrconvert ${PARENTDIR}/${SUBJECTDIR}/aparcANDfirst/aparcANDaseg.nii ${WORKDIR}/aparc+aseg.nii -stride -1,2,3
	5ttgen freesurfer -tempdir ${WORKDIR} ${WORKDIR}/aparc+aseg.nii ${WORKDIR}/ACT_FREESURFER.nii -nocrop
	matlab -nodisplay -nosplash -r "WheresMyScript='${WHERESMYSCRIPT}/Functions'; addpath(genpath(WheresMyScript)); CustomACT('${WORKDIR}/ACT_FSL.nii','${WORKDIR}/ACT_FREESURFER.nii','${WORKDIR}/ACT.nii'); exit"
	fi
fi
if [ "${RUN_DWI_REG}" = 1 ]; then
	for EDDYTYPE in EDDY1 EDDY2; do
    # In case this already exists, get rid of it
	rm -f ${WORKDIR}/MeanBZero_${EDDYTYPE}.mif
	dwiextract ${WORKDIR}/dwi_${EDDYTYPE}.mif -bzero ${WORKDIR}/dwi_${EDDYTYPE}_1.mif 
	mrcalc ${WORKDIR}/dwi_${EDDYTYPE}_1.mif 0.0 -max ${WORKDIR}/dwi_${EDDYTYPE}_2.mif 
	mrmath ${WORKDIR}/dwi_${EDDYTYPE}_2.mif mean -axis 3 ${WORKDIR}/MeanBZero_${EDDYTYPE}.mif
	mrconvert -force ${WORKDIR}/MeanBZero_${EDDYTYPE}.mif ${WORKDIR}/MeanBZero_${EDDYTYPE}.nii -stride -1,2,3
	rm -f ${WORKDIR}/b0_mask_${EDDYTYPE}.nii
	rm -f ${WORKDIR}/b0_mask_${EDDYTYPE}.nii
	# Make a mask using bet
	bet ${WORKDIR}/MeanBZero_${EDDYTYPE}.nii ${WORKDIR}/b0_mask_${EDDYTYPE}.nii -m -f 0.2
	BRAIN_MASK=b0_mask_${EDDYTYPE}.nii
	dwi2response -force -tempdir ${WORKDIR} tax ${WORKDIR}/dwi_${EDDYTYPE}.mif ${WORKDIR}/response_${EDDYTYPE}.txt -voxels ${WORKDIR}/RF_voxels_${EDDYTYPE}.mif
	dwi2fod -force csd ${WORKDIR}/dwi_${EDDYTYPE}.mif ${WORKDIR}/response_${EDDYTYPE}.txt ${WORKDIR}/FOD_${EDDYTYPE}.mif -mask ${WORKDIR}/${BRAIN_MASK}
	dwi2tensor -force -mask ${WORKDIR}/${BRAIN_MASK} ${WORKDIR}/dwi_${EDDYTYPE}.mif ${WORKDIR}/tensor_${EDDYTYPE}.mif
	tensor2metric -force -mask ${WORKDIR}/${BRAIN_MASK} -vector ${WORKDIR}/directions_${EDDYTYPE}.mif ${WORKDIR}/tensor_${EDDYTYPE}.mif
	tensor2metric -force -mask ${WORKDIR}/${BRAIN_MASK} -fa ${WORKDIR}/FA_${EDDYTYPE}.mif ${WORKDIR}/tensor_${EDDYTYPE}.mif
	tensor2metric -force -mask ${WORKDIR}/${BRAIN_MASK} -adc ${WORKDIR}/MD_${EDDYTYPE}.mif ${WORKDIR}/tensor_${EDDYTYPE}.mif
	# Register the brain in anatomical space to the DWI brain
	flirt -in ${WORKDIR}/MeanBZero_${EDDYTYPE}.nii -ref ${WORKDIR}/brain.nii -omat ${WORKDIR}/${EDDYTYPE}dwi2T1w_flirt.mat -bins 256 -cost normmi -searchrx -180 180 -searchry -180 180 -searchrz -180 180 -dof 6 -interp trilinear
	convert_xfm -omat ${WORKDIR}/T1w2${EDDYTYPE}dwi_flirt.mat -inverse ${WORKDIR}/${EDDYTYPE}dwi2T1w_flirt.mat
	transformconvert -force ${WORKDIR}/T1w2${EDDYTYPE}dwi_flirt.mat ${WORKDIR}/brain.nii ${WORKDIR}/MeanBZero_${EDDYTYPE}.nii flirt_import ${WORKDIR}/T1w2${EDDYTYPE}dwi_mrtrix.txt
	mrtransform -force ${WORKDIR}/brain.nii ${WORKDIR}/brain_${EDDYTYPE}.nii -linear ${WORKDIR}/T1w2${EDDYTYPE}dwi_mrtrix.txt
	mrtransform ${WORKDIR}/ACT.nii ${WORKDIR}/ACT_${EDDYTYPE}.nii -linear ${WORKDIR}/T1w2${EDDYTYPE}dwi_mrtrix.txt
	mrconvert -force -coord 3 2 -axes 0,1,2 ${WORKDIR}/ACT_${EDDYTYPE}.nii ${WORKDIR}/WM_${EDDYTYPE}.nii
	mrconvert -force -coord 3 1 -axes 0,1,2 ${WORKDIR}/ACT_${EDDYTYPE}.nii ${WORKDIR}/sub_GM_${EDDYTYPE}.nii
	mrconvert -force -coord 3 0 -axes 0,1,2 ${WORKDIR}/ACT_${EDDYTYPE}.nii ${WORKDIR}/cort_GM_${EDDYTYPE}.nii
	mrcalc -force ${WORKDIR}/WM_${EDDYTYPE}.nii ${WORKDIR}/sub_GM_${EDDYTYPE}.nii -add ${WORKDIR}/cort_GM_${EDDYTYPE}.nii -add 0 -gt ${WORKDIR}/GMWMmask_${EDDYTYPE}.nii
	5tt2gmwmi -force ${WORKDIR}/ACT_${EDDYTYPE}.nii ${WORKDIR}/GMWMI_${EDDYTYPE}.nii
	mrcalc -force ${WORKDIR}/WM_${EDDYTYPE}.nii 0 -gt ${WORKDIR}/WMmask_${EDDYTYPE}.nii
	done
fi
if [ "${RUNMAIN}" = 1 ]; then
	for EDDYTYPE in EDDY1 EDDY2; do
			# This just warps each parcellation from anatomical/T1w space into diffusion space
			for PARC in ${PARC_LIST}; do
				mrtransform -force ${WORKDIR}/${PARC}.nii ${WORKDIR}/${PARC}_${EDDYTYPE}.nii -linear ${WORKDIR}/T1w2${EDDYTYPE}dwi_mrtrix.txt
			done
		for MASK in ACT GMWMmask; do
			if [ "${MASK}" = "ACT" ]; then
				MASKCOMMAND="-act"
				SEEDTYPES="dynamic wm gmwmi"
				BACKTRACK="-backtrack"
			elif [ "${MASK}" = "GMWMmask" ]; then
				MASKCOMMAND="-mask"
				SEEDTYPES="dynamic wm"
				BACKTRACK=""
			fi	
			for SEED in ${SEEDTYPES}; do
				if [ "${SEED}" = "dynamic" ]; then
					SEEDCOMMAND="-seed_dynamic ${WORKDIR}/FOD_${EDDYTYPE}.mif"
				elif [ "${SEED}" = "wm" ]; then
					SEEDCOMMAND="-seed_image ${WORKDIR}/WMmask_${EDDYTYPE}.nii"
				elif [ "${SEED}" = "gmwmi" ]; then
					SEEDCOMMAND="-seed_gmwmi ${WORKDIR}/GMWMI_${EDDYTYPE}.nii"
				fi
				if [ "${RUNTRACT}" = 1 ]; then
					echo "\n***Running FACT: ${EDDYTYPE} ${MASK} ${SEED}***\n"
					date
					tckgen -force ${SEEDCOMMAND} -angle 45 ${MASKCOMMAND} ${WORKDIR}/${MASK}_${EDDYTYPE}.nii -maxlength 400 -select ${NUM} -algorithm FACT -downsample 5 ${WORKDIR}/directions_${EDDYTYPE}.mif ${WORKDIR}/streamlines_${EDDYTYPE}_${MASK}_${SEED}_FACT.tck
					echo "\n***Finished running FACT: ${EDDYTYPE} ${MASK} ${SEED}***\n"
					date
					echo "\n***Running iFOD2: ${EDDYTYPE} ${MASK} ${SEED}***\n"	
					date
					tckgen -force ${BACKTRACK} ${SEEDCOMMAND} -angle 45 ${MASKCOMMAND} ${WORKDIR}/${MASK}_${EDDYTYPE}.nii -maxlength 400 -select ${NUM} -algorithm iFOD2 ${WORKDIR}/FOD_${EDDYTYPE}.mif ${WORKDIR}/streamlines_${EDDYTYPE}_${MASK}_${SEED}_iFOD2.tck 
					echo "\n***Finished running iFOD2: ${EDDYTYPE} ${MASK} ${SEED}***\n"
					date
				fi
				for ALGOR in FACT iFOD2; do	
					echo "\n***Running SIFT2: ${ALGOR} ${EDDYTYPE} ${MASK} ${SEED}***\n"
					date
					if [ "${MASK}" = "ACT" ]; then
						if [ "${RUNSIFT}" = 1 ]; then
							tcksift2 -force -csv ${WORKDIR}/SIFT_data_${EDDYTYPE}_${MASK}_${SEED}_${ALGOR}.csv -act ${WORKDIR}/ACT_${EDDYTYPE}.nii ${WORKDIR}/streamlines_${EDDYTYPE}_${MASK}_${SEED}_${ALGOR}.tck ${WORKDIR}/FOD_${EDDYTYPE}.mif ${WORKDIR}/SIFT2_weights_${EDDYTYPE}_${MASK}_${SEED}_${ALGOR}.txt
						fi
					elif [ "${MASK}" = "GMWMmask" ]; then
						if [ "${RUNSIFT}" = 1 ]; then
							tcksift2 -force -csv ${WORKDIR}/SIFT_data_${EDDYTYPE}_${MASK}_${SEED}_${ALGOR}.csv ${WORKDIR}/streamlines_${EDDYTYPE}_${MASK}_${SEED}_${ALGOR}.tck ${WORKDIR}/FOD_${EDDYTYPE}.mif ${WORKDIR}/SIFT2_weights_${EDDYTYPE}_${MASK}_${SEED}_${ALGOR}.txt
						fi
					fi
					echo "\n***Finished running SIFT2: ${ALGOR} ${EDDYTYPE} ${MASK} ${SEED}***\n"
					date
					if [ "${RUNTCKSAMPLE}" = 1 ]; then
						tcksample -force ${WORKDIR}/streamlines_${EDDYTYPE}_${MASK}_${SEED}_${ALGOR}.tck ${WORKDIR}/FA_${EDDYTYPE}.mif ${WORKDIR}/FA_tractweights_${EDDYTYPE}_${MASK}_${SEED}_${ALGOR}.csv -stat_tck mean
					fi				
						for PARC in ${PARC_LIST}; do
							for SIFTTYPE in SIFT2 NOS; do
								if [ "${SIFTTYPE}" = "SIFT2" ]; then
									SIFTCOMMAND="-tck_weights_in ${WORKDIR}/SIFT2_weights_${EDDYTYPE}_${MASK}_${SEED}_${ALGOR}.txt"
								elif [ "${SIFTTYPE}" = "NOS" ]; then
									SIFTCOMMAND=""
								fi
							if [ "${RUNCONN}" = 1 ]; then
									echo "\n***Connectome Generation: Making ${PARC} ${EDDYTYPE} ${MASK} ${SEED} ${ALGOR} ${SIFTTYPE}***\n"
									date
									tck2connectome -force -zero_diagonal -assignment_radial_search 5 ${SIFTCOMMAND} ${WORKDIR}/streamlines_${EDDYTYPE}_${MASK}_${SEED}_${ALGOR}.tck ${WORKDIR}/${PARC}_${EDDYTYPE}.nii ${WORKDIR}/${PARC}_${EDDYTYPE}_${MASK}_${SEED}_${ALGOR}_${SIFTTYPE}.csv
									tck2connectome -force -zero_diagonal -scale_length -stat_edge mean -assignment_radial_search 5 ${SIFTCOMMAND} ${WORKDIR}/streamlines_${EDDYTYPE}_${MASK}_${SEED}_${ALGOR}.tck ${WORKDIR}/${PARC}_${EDDYTYPE}.nii ${WORKDIR}/${PARC}_${EDDYTYPE}_${MASK}_${SEED}_${ALGOR}_${SIFTTYPE}_length.csv
									tck2connectome -force -zero_diagonal -scale_file ${WORKDIR}/FA_tractweights_${EDDYTYPE}_${MASK}_${SEED}_${ALGOR}.csv -stat_edge mean -assignment_radial_search 5 ${SIFTCOMMAND} ${WORKDIR}/streamlines_${EDDYTYPE}_${MASK}_${SEED}_${ALGOR}.tck ${WORKDIR}/${PARC}_${EDDYTYPE}.nii ${WORKDIR}/${PARC}_${EDDYTYPE}_${MASK}_${SEED}_${ALGOR}_${SIFTTYPE}_FA.csv
									matlab -nodisplay -nosplash -r "WheresMyScript='${WHERESMYSCRIPT}/Functions'; addpath(genpath(WheresMyScript)); csv_to_mat('${WORKDIR}/${PARC}_${EDDYTYPE}_${MASK}_${SEED}_${ALGOR}_${SIFTTYPE}_length.csv','${WORKDIR}/${PARC}_${EDDYTYPE}_${MASK}_${SEED}_${ALGOR}_${SIFTTYPE}_length.mat'); exit"
									matlab -nodisplay -nosplash -r "WheresMyScript='${WHERESMYSCRIPT}/Functions'; addpath(genpath(WheresMyScript)); csv_to_mat('${WORKDIR}/${PARC}_${EDDYTYPE}_${MASK}_${SEED}_${ALGOR}_${SIFTTYPE}_FA.csv','${WORKDIR}/${PARC}_${EDDYTYPE}_${MASK}_${SEED}_${ALGOR}_${SIFTTYPE}_FA.mat'); exit"
									echo "\n***Finished connectome Generation: Making ${PARC} ${EDDYTYPE} ${MASK} ${SEED} ${ALGOR} ${SIFTTYPE}***\n"
									date
							fi
							done
						done
				done
			done
		done
	done
fi
echo "\n***Finished running for participant ${SUBJECTID}***\n"
date
