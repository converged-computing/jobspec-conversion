#!/bin/bash
#FLUX: --job-name=eccentric-ricecake-8323
#FLUX: -c=4
#FLUX: -t=1800
#FLUX: --urgency=16

export MPLBACKEND='agg'

prepro_variant=AROMAnonaggr
echo "Processing " $subject ".................."
if [ ! -d "$FMRIPREP_DIR/$subject/dbscan" ]; then
          mkdir -p $FMRIPREP_DIR/$subject/dbscan
fi
rm -rf $FMRIPREP_DIR/$subject/dbscan/*
func=$FMRIPREP_DIR/$subject'/func/'$subject"_task-rest_"$SCAN_ID"bold_space-"$space_variant"_variant-"$prepro_variant"_preproc.nii.gz"
confounds=$FMRIPREP_DIR/$subject'/func/'$subject"_task-rest_"$SCAN_ID"bold_confounds.tsv"
gm_prob_T1w=$FMRIPREP_DIR/$subject/anat/$subject"_T1w_space-"$space_variant"_class-GM_probtissue.nii.gz"
gm_prob_epi=$FMRIPREP_DIR/$subject/anat/$subject"_bold_space-"$space_variant"_class-GM_probtissue.nii.gz"
mask_T1w=$FMRIPREP_DIR/$subject/anat/$subject"_T1w_space-"$space_variant"_brainmask.nii.gz"
mask_epi=$FMRIPREP_DIR/$subject/anat/$subject"_bold_space-"$space_variant"_brainmask.nii.gz"
dtissue_T1w=$FMRIPREP_DIR/$subject/anat/$subject"_T1w_space-"$space_variant"_dtissue.nii.gz"
dtissue_epi=$FMRIPREP_DIR/$subject/anat/$subject"_bold_space-"$space_variant"_dtissue.nii.gz"
dtissue_epi_masked=$FMRIPREP_DIR/$subject"/dbscan/"$subject"_bold_space-"$space_variant"_dtissue_masked.nii.gz"
flirt -in $gm_prob_T1w -out $gm_prob_epi -ref $func -applyxfm -usesqform
flirt -in $mask_T1w -out $mask_epi -ref $func -applyxfm -usesqform
flirt -in $dtissue_T1w -out $dtissue_epi -ref $func -applyxfm -interp nearestneighbour -usesqform
mean_epi_targ=$FMRIPREP_DIR/$subject'/dbscan/'$subject"_task-rest_"$SCAN_ID"bold_space-"$space_variant"_variant-"$prepro_variant"_preproc_mean.nii.gz"
fslmaths $func -Tmean $mean_epi_targ
fslmaths $dtissue_epi -mas $mean_epi_targ $dtissue_epi_masked
dbscan_folder=$FMRIPREP_DIR/$subject"/dbscan/"
gm_dbscan=$FMRIPREP_DIR/$subject"/dbscan/"$subject"_bold_space-"$space_variant"_gm_mask.nii.gz"
tissue_ordering=$FMRIPREP_DIR/$subject"/dbscan/"$subject"_bold_space-"$space_variant"_gm_mask_gsordering_tissue.nii.gz"
export func
export gm_prob_epi
export gm_dbscan
export mask_epi
export dtissue_epi_masked
export confounds
export dbscan_folder
fslmaths $gm_prob_epi -thr 0.5 -bin $dbscan_folder/temp_mask_gm
fslmaths $func -Tmean $dbscan_folder/temp_mask_30
read min max <<< $(fslstats $dbscan_folder/temp_mask_30 -r)
fslmaths $dbscan_folder/temp_mask_30 -div $max -thr 0.3 -bin $dbscan_folder/temp_mask_30
fslmaths $dbscan_folder/temp_mask_gm -mul $dbscan_folder/temp_mask_30 $gm_dbscan
fslmaths $gm_dbscan -mul 2 $dbscan_folder/temp_gm_2
fslmaths $dbscan_folder/temp_gm_2 -add $dtissue_epi_masked $dtissue_epi_masked
gm=$subject"_T1w_space-"$space_variant"_class-GM_probtissue"
csf=$subject"_T1w_space-"$space_variant"_class-CSF_probtissue"
wm=$subject"_T1w_space-"$space_variant"_class-WM_probtissue"
bmask=$subject"_T1w_space-"$space_variant"_brainmask"
csf_epi=$subject"_bold_space-"$space_variant"_CSF"
wm_epi=$subject"_bold_space-"$space_variant"_WM"
csfwm_epi=$subject"_bold_space-"$space_variant"_CSFWM"
tmp_roi_dir=$FMRIPREP_DIR/$subject"/dbscan/tmp"
anat_dir=$FMRIPREP_DIR/$subject/anat/
mkdir -p $tmp_roi_dir
fslmaths $anat_dir/$gm -thr 0.95 -bin $tmp_roi_dir/vmask
fslmaths $tmp_roi_dir/vmask -dilD -bin $tmp_roi_dir/vmask
fslmaths $tmp_roi_dir/vmask -dilD -bin $tmp_roi_dir/vmask
fslmaths $tmp_roi_dir/vmask -add $anat_dir/$wm -binv $tmp_roi_dir/vmask
fslmaths $anat_dir/$bmask -eroF $tmp_roi_dir/e_native_t1_brain_mask
fslmaths $tmp_roi_dir/e_native_t1_brain_mask -eroF $tmp_roi_dir/e_native_t1_brain_mask
fslmaths $tmp_roi_dir/vmask -mul $tmp_roi_dir/e_native_t1_brain_mask $tmp_roi_dir/$csf"v"
fslmaths $tmp_roi_dir/$csf"v" -eroF -bin $tmp_roi_dir/$csf"_e1"
fslmaths $tmp_roi_dir/$csf"_e1" -eroF -bin $tmp_roi_dir/$csf"_e2"
fslmaths $anat_dir/$wm -thr 0.95 -bin $tmp_roi_dir/$wm"v"
input_wm=$tmp_roi_dir/$wm"v"
for i in `seq 1 5`;
	do
		output_wm=$tmp_roi_dir/$wm"_e"$i
		fslmaths $input_wm -eroF -bin $output_wm
		# Now save the input for the next erosion
		intput_wm=$output_wm
	done
flirt -in $tmp_roi_dir/$csf"_e1" -ref $func -out $tmp_roi_dir/$csf_epi"_e1" -applyxfm -interp nearestneighbour -usesqform
flirt -in $tmp_roi_dir/$wm"_e5" -ref $func -out $tmp_roi_dir/$wm_epi"_e5" -applyxfm -interp nearestneighbour -usesqform
fslmaths $tmp_roi_dir/$wm_epi"_e5" -mul 2 -add $tmp_roi_dir/$csf_epi"_e1" $FMRIPREP_DIR/$subject"/dbscan/"$csfwm_epi
fslmeants -i $func --label=$FMRIPREP_DIR/$subject"/dbscan/"$csfwm_epi -o $FMRIPREP_DIR/$subject'/func/'${subject}_task-rest_bold_wmcsf.tsv
fslmeants -i $func --label=$mask_epi -o $FMRIPREP_DIR/$subject'/dbscan/'$subject"_brain_signal.txt"
paste -d '\t' $FMRIPREP_DIR/$subject'/func/'${subject}_task-rest_bold_wmcsf.tsv $FMRIPREP_DIR/$subject'/dbscan/'$subject"_brain_signal.txt" > $FMRIPREP_DIR/$subject'/func/'${subject}_task-rest_bold_wmcsfgs.tsv
fslmeants -i $func --label=$dtissue_epi_masked -o $FMRIPREP_DIR/$subject'/dbscan/'$subject"_tissue_signals.txt"
awk -v OFS='\t' '{print $4}' $FMRIPREP_DIR/$subject'/dbscan/'$subject"_tissue_signals.txt" > $FMRIPREP_DIR/$subject'/func/'${subject}_task-rest_bold_gm.tsv
paste -d '\t' $FMRIPREP_DIR/$subject'/func/'${subject}_task-rest_bold_wmcsf.tsv $FMRIPREP_DIR/$subject'/func/'${subject}_task-rest_bold_gm.tsv > $FMRIPREP_DIR/$subject'/func/'${subject}_task-rest_bold_wmcsfgm.tsv
func_2P=$FMRIPREP_DIR/$subject'/func/'$subject"_task-rest_"$SCAN_ID"bold_space-"$space_variant"_variant-"$prepro_variant"_preproc+2P.nii.gz"
func_2P_GSR=$FMRIPREP_DIR/$subject'/func/'$subject"_task-rest_"$SCAN_ID"bold_space-"$space_variant"_variant-"$prepro_variant"_preproc+2P+GSR.nii.gz"
func_2P_GMR=$FMRIPREP_DIR/$subject'/func/'$subject"_task-rest_"$SCAN_ID"bold_space-"$space_variant"_variant-"$prepro_variant"_preproc+2P+GMR.nii.gz"
fsl_regfilt -i $func -d $FMRIPREP_DIR/$subject'/func/'${subject}_task-rest_bold_wmcsf.tsv -f 1,2 -o $func_2P -a
fsl_regfilt -i $func -d $FMRIPREP_DIR/$subject'/func/'${subject}_task-rest_bold_wmcsfgs.tsv -f 1,2,3 -o $func_2P_GSR -a
fsl_regfilt -i $func -d $FMRIPREP_DIR/$subject'/func/'${subject}_task-rest_bold_wmcsfgm.tsv -f 1,2,3 -o $func_2P_GMR -a
input_dbscan=$FMRIPREP_DIR/$subject'/dbscan/'$subject"_task-rest_"$SCAN_ID"bold_space-"$space_variant"_variant-"$prepro_variant"_preproc+2P_detrended_hpf.nii.gz"
sh fmriprepProcess/preprocess_fmriprep.sh $func_2P $input_dbscan $dbscan_folder $mask_epi
func_2P_GSR_dhpf=$FMRIPREP_DIR/$subject'/dbscan/'$subject"_task-rest_"$SCAN_ID"bold_space-"$space_variant"_variant-"$prepro_variant"_preproc+2P+GSR_detrended_hpf.nii.gz"
sh fmriprepProcess/preprocess_fmriprep.sh $func_2P_GSR $func_2P_GSR_dhpf $dbscan_folder $mask_epi
func_2P_GMR_dhpf=$FMRIPREP_DIR/$subject'/dbscan/'$subject"_task-rest_"$SCAN_ID"bold_space-"$space_variant"_variant-"$prepro_variant"_preproc+2P+GMR_detrended_hpf.nii.gz"
sh fmriprepProcess/preprocess_fmriprep.sh $func_2P_GMR $func_2P_GMR_dhpf $dbscan_folder $mask_epi
echo "up to reordering GS"
python --version
echo $input_dbscan
echo $dtissue_epi_masked
echo $tissue_ordering
python fmriprepProcess/gsReorder.py -f $input_dbscan -ts $dtissue_epi_masked -of $tissue_ordering
output_folder=$FMRIPREP_DIR/$subject'/dbscan/'
python carpetCleaning/clusterCorrect.py $dtissue_epi_masked '.' $input_dbscan $output_folder $subject
regressor_dbscan=$subject"_dbscan_liberal_regressors.csv"
f1=$subject"_task-rest_"$SCAN_ID"bold_space-"$space_variant"_variant-"$prepro_variant"_preproc+2P_detrended_hpf.nii.gz"
python carpetCleaning/vacuum_dbscan.py -f $f1 -db $regressor_dbscan -s $subject -d $output_folder
output_dbscan=$FMRIPREP_DIR/$subject'/dbscan/'$subject"_task-rest_"$SCAN_ID"bold_space-"$space_variant"_variant-"$prepro_variant"_preproc+2P_detrended_hpf_dbscan.nii.gz"
export MPLBACKEND="agg"
python fmriprepProcess/clusterReorder.py $dtissue_epi_masked '.' $input_dbscan $output_folder $subject
cluster_tissue_ordering=$FMRIPREP_DIR/$subject/dbscan/$subject"_bold_space-"$space_variant"_dtissue_masked_clusterorder.nii.gz"
python carpetReport/tapestry.py -f $input_dbscan","$output_dbscan","$func_2P_GMR_dhpf","$func_2P_GSR_dhpf -fl "ICA_AROMA,DBSCAN,GMR,GSR"  -o $tissue_ordering","$cluster_tissue_ordering -l "GS_reorder,CLUST" -s $subject -d $FMRIPREP_DIR"/dbscan/" -ts $dtissue_epi_masked -reg $FMRIPREP_DIR/$subject'/dbscan/'$regressor_dbscan -cf $confounds
