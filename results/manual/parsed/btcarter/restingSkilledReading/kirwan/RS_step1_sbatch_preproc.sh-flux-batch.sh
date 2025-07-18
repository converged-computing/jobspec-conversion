#!/bin/bash
#FLUX: --job-name=RS1
#FLUX: -n=6
#FLUX: -t=72000
#FLUX: --urgency=16

export PBS_NODEFILE='`/fslapps/fslutils/generate_pbs_nodefile`'
export PBS_JOBID='$SLURM_JOB_ID'
export PBS_O_WORKDIR='$SLURM_SUBMIT_DIR'
export PBS_QUEUE='batch'
export OMP_NUM_THREADS='$SLURM_CPUS_ON_NODE'

export PBS_NODEFILE=`/fslapps/fslutils/generate_pbs_nodefile`
export PBS_JOBID=$SLURM_JOB_ID
export PBS_O_WORKDIR="$SLURM_SUBMIT_DIR"
export PBS_QUEUE=batch
export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE
START_DIR=$(pwd)										# starting directory
STUDY=~/compute/skilledReadingStudy						# study directory
TEMPLATE_DIR=${STUDY}/template							# location of study template
DICOM_DIR=${STUDY}/dicomdir/${1}						# location of dicoms was called rawDir by Nate
PARTICIPANT_REST=${STUDY}/resting/${1}					# location of derived participant NIFTI files
subj=$1
parDir=~/compute/RS_test							###??? Update this
workDir=${parDir}/derivatives/$subj
rawDir=${parDir}/rawdata/$subj
blip=0
tempDir=~/bin/Templates/vold2_mni
template=${tempDir}/vold2_mni_brain+tlrc
actDir=${tempDir}/priors_ACT
for i in {1..4}; do
	if [ ! -f ${actDir}/Prior${i}.nii.gz ]; then
		echo >&2
		echo "Prior${i} not detected. Check \$actDir. Exit 1" >&2
		echo >&2
		exit 1
	fi
done
if [ ! -f ${template}.HEAD ]; then
	echo >&2
	echo "Template not detected. Check \$tempDir. Exit 2" >&2
	echo >&2
	exit 2
fi
if [ ! -f ${workDir}/Resting+orig.HEAD ]; then
	3dcopy ${rawDir}/func/${subj}_task-context_run-1_bold.nii.gz ${workDir}/Resting+orig
fi
if [ ! -f ${workDir}/struct+orig.HEAD ]; then
	3dcopy ${rawDir}/anat/${subj}_T1w.nii.gz ${workDir}/struct+orig
fi
if [ ! -f ${workDir}/Resting+orig.HEAD ] || [ ! -f ${workDir}/struct+orig.HEAD ]; then
	echo >&2
	echo "Func and/or Anat data not detected in $workDir. Check $rawDir. Exit 3" >&2
	echo >&2
	exit 3
fi
cd $workDir
tr_counts=`3dinfo -ntimes Resting+orig`
gridSize=`3dinfo -di Resting+orig`
if [ ! -s outcount.RS.1D ]; then
	# determine polort arg, outliers
	len_tr=`3dinfo -tr Resting+orig`
	pol_time=$(echo $(echo $tr_counts*$len_tr | bc)/150 | bc -l)
	pol=$((1 + `printf "%.0f" $pol_time`))
	3dToutcount -automask -fraction -polort $pol -legendre Resting+orig > outcount.RS.1D
	# censor - more conservative threshold (0.05) used for RS
	> out.${j}.pre_ss_warn.txt
	1deval -a outcount.RS.1D -expr "1-step(a-0.05)" > out.cen.RS.1D
	if [ `1deval -a outcount.RS.1D"{0}" -expr "step(a-0.4)"` ]; then
		echo "** TR #0 outliers: possible pre-steady state TRs in run RS"  >> out.RS.pre_ss_warn.txt
	fi
fi
if [ ! -f vr_base+orig.HEAD ]; then
    3dDespike -NEW -nomask -prefix tmp_despike Resting+orig
	minindex=`3dTstat -argmin -prefix - outcount.RS.1D\'`
	ovals=(`1d_tool.py -set_run_lengths $tr_counts -index_to_run_tr $minindex`)
	minouttr=${ovals[1]}
    3dbucket -prefix vr_base tmp_despike+orig"[$minouttr]"
fi
if [ ! -f struct_ns+orig.HEAD ]; then
	align_epi_anat.py \
	-anat2epi \
	-anat struct+orig \
	-save_skullstrip \
	-suffix _rotated \
	-epi vr_base+orig \
	-epi_base 0 \
	-epi_strip 3dAutomask \
	-cost lpc+ZZ \
	-volreg off \
	-tshift off
fi
if [ ! -f anat.un.aff.qw_WARP.nii ]; then
	auto_warp.py -base $template -input struct_ns+orig -skull_strip_input no
	3dbucket -prefix struct_ns awpy/struct_ns.aw.nii*
	cp awpy/anat.un.aff.Xat.1D .
	cp awpy/anat.un.aff.qw_WARP.nii .
fi
if [ ! -f struct_ns+tlrc.HEAD ]; then
	echo >&2
	echo "Normalization failed - no struct_ns+tlrc.HEAD detected. Exit 4" >&2
	echo >&2
	exit 4
fi
if [ ! -f tmp_epi_mask_warped+tlrc.HEAD ]; then
	# calc volreg
	3dvolreg -verbose -zpad 1 -base vr_base+orig \
	-1Dfile dfile_Resting.1D -prefix tmp_epi_volreg \
	-cubic \
	-1Dmatrix_save mat.vr.aff12.1D \
	tmp_despike+orig
	# concat calcs for epi movement (volreg, align, warp)
	cat_matvec -ONELINE \
	anat.un.aff.Xat.1D \
	struct_rotated_mat.aff12.1D -I \
	mat.vr.aff12.1D > mat.warp_epi.aff12.1D
	# warp epi
	3dNwarpApply -master struct_ns+tlrc \
	-dxyz $gridSize \
	-source tmp_despike+orig \
	-nwarp "anat.un.aff.qw_WARP.nii mat.warp_epi.aff12.1D" \
	-prefix tmp_epi_warped_nomask
	# warp mask for extents masking; make intersection mask (epi+anat)
	3dcalc -overwrite -a tmp_despike+orig -expr 1 -prefix tmp_epi_mask
	3dNwarpApply -master struct_ns+tlrc \
	-dxyz $gridSize \
	-source tmp_epi_mask+orig \
	-nwarp "anat.un.aff.qw_WARP.nii mat.warp_epi.aff12.1D" \
	-interp cubic \
	-ainterp NN -quiet \
	-prefix tmp_epi_mask_warped
fi
if [ ! -f tmp_epi_clean+tlrc.HEAD ]; then
	3dTstat -min -prefix tmp_epi_min tmp_epi_mask_warped+tlrc
	3dcopy tmp_epi_min+tlrc mask_epi_extents
	3dcalc -a tmp_epi_warped_nomask+tlrc -b mask_epi_extents+tlrc -expr 'a*b' -prefix tmp_epi_clean
fi
if [ ! -f final_vr_base+tlrc.HEAD ];then
	cat_matvec -ONELINE \
	anat.un.aff.Xat.1D \
	struct_rotated_mat.aff12.1D -I  > mat.basewarp.aff12.1D
	3dNwarpApply -master struct_ns+tlrc \
	-dxyz $gridSize \
	-source vr_base+orig \
	-nwarp "anat.un.aff.qw_WARP.nii mat.basewarp.aff12.1D" \
	-prefix final_vr_base
fi
if [ ! -f final_anat+tlrc.HEAD ]; then
	3dcopy struct_ns+tlrc final_anat
fi
if [ ! -f final_anat_head+tlrc.HEAD ]; then
	3dAllineate -base final_vr_base+tlrc -allcostX -input final_anat+tlrc | tee out.allcostX.txt
	3dNwarpApply \
	-source struct+orig \
	-master final_anat+tlrc \
	-ainterp wsinc5 \
	-nwarp anat.un.aff.qw_WARP.nii anat.un.aff.Xat.1D \
	-prefix final_anat_head
fi
if [ ! -f tmp_epi_blur+tlrc.HEAD ]; then
	int=`printf "%.0f" $gridSize`
	blur=$((2*$int))
	3dmerge -1blur_fwhm $blur -doall -prefix tmp_epi_blur tmp_epi_clean+tlrc
fi
if [ ! -f final_anat_mask+tlrc.HEAD ]; then
	3dAutomask -prefix tmp_mask_epi tmp_epi_blur+tlrc
	3dmask_tool -inputs tmp_mask_epi+tlrc.HEAD -union -prefix full_mask
	3dresample -master full_mask+tlrc -input struct_ns+tlrc -prefix tmp_anat_resamp
	3dmask_tool -dilate_input 5 -5 -fill_holes -input tmp_anat_resamp+tlrc -prefix final_anat_mask
	3dmask_tool -input full_mask+tlrc final_anat_mask+tlrc -inter -prefix mask_epi_anat
	3dABoverlap -no_automask full_mask+tlrc final_anat_mask+tlrc | tee out.mask_ae_overlap.txt
	3dresample -master full_mask+tlrc -prefix ./tmp_resam_group -input $template
	3dmask_tool -dilate_input 5 -5 -fill_holes -input tmp_resam_group+tlrc -prefix Template_mask
fi
if [ ! -f final_mask_GM_eroded+tlrc.HEAD ]; then
	# get priors
	tiss=(CSF GMc WM GMs)
	prior=(Prior{1..4})
	tissN=${#tiss[@]}
	c=0; while [ $c -lt $tissN ]; do
		cp ${actDir}/${prior[$c]}.nii.gz ./tmp_${tiss[$c]}.nii.gz
		let c=$[$c+1]
	done
	c3d tmp_GMc.nii.gz tmp_GMs.nii.gz -add -o tmp_GM.nii.gz
	# resample, erode
	for i in CSF GM WM; do
		c3d tmp_${i}.nii.gz -thresh 0.3 1 1 0 -o tmp_${i}_bin.nii.gz
		3dresample -master tmp_epi_blur+tlrc -rmode NN -input tmp_${i}_bin.nii.gz -prefix tmp_mask_${i}+tlrc
		3dmask_tool -input tmp_${i}_bin.nii.gz -dilate_input -1 -prefix tmp_mask_${i}_eroded
		3dresample -master tmp_epi_blur+tlrc -rmode NN -input tmp_mask_${i}_eroded+orig -prefix final_mask_${i}_eroded
	done
fi
if [ ! -f Resting_scale+tlrc.HEAD ]; then
	3dTstat -prefix tmp_tstat tmp_epi_blur+tlrc
	3dcalc \
	-a tmp_epi_blur+tlrc \
	-b tmp_tstat+tlrc \
	-c mask_epi_extents+tlrc \
	-expr 'c * min(200, a/b*100)*step(a)*step(b)' \
	-prefix Resting_scale
fi
