#!/bin/bash
#FLUX: --job-name=cifti_parcellate
#FLUX: -c=2
#FLUX: -t=1800
#FLUX: --urgency=16

export BIDS_DIR='${BASEDIR}/${OPENNEURO_DSID}/bids'
export SING_CONTAINER='${BASEDIR}/containers/fmriprep_ciftify_v1.3.2-2.3.3.img'
export DERIVED_DIR='${BASEDIR}/${OPENNEURO_DSID}/derived/'
export WORK_DIR='${BASEDIR}/${OPENNEURO_DSID}/work/'
export LOGS_DIR='${BASEDIR}/${OPENNEURO_DSID}/logs'

module load tools/Singularity/3.8.5
OPENNEURO_DSID=`basename ${SLURM_SUBMIT_DIR}`
BASEDIR=`dirname ${SLURM_SUBMIT_DIR}`
CODEDIR=${BASEDIR}/code/openneuro_preproc/code/
echo "the CODEDIR is $CODEDIR"
clean_config=cleaning_settings.json
parcellation_dir=${BASEDIR}/parcellations
dlabel_file=Schaefer2018_100Parcels_7Networks_order.dlabel.nii
atlas="atlas-SchaeferP100N7"
function cleanup_ramdisk {
    echo -n "Cleaning up ramdisk directory /$SLURM_TMPDIR/ on "
    date
    rm -rf /$SLURM_TMPDIR
    echo -n "done at "
    date
}
trap "cleanup_ramdisk" TERM
export BIDS_DIR=${BASEDIR}/${OPENNEURO_DSID}/bids
export SING_CONTAINER=${BASEDIR}/containers/fmriprep_ciftify_v1.3.2-2.3.3.img
export DERIVED_DIR=${BASEDIR}/${OPENNEURO_DSID}/derived/
export WORK_DIR=${BASEDIR}/${OPENNEURO_DSID}/work/
export LOGS_DIR=${BASEDIR}/${OPENNEURO_DSID}/logs
SUB_SIZE=1 ## number of subjects to run
CORES=2
bigger_bit=`echo "($SLURM_ARRAY_TASK_ID + 1) * ${SUB_SIZE}" | bc`
SUBJECT=`sed -n -E "s/sub-(\S*)\>.*/\1/gp" ${BIDS_DIR}/participants.tsv | head -n ${bigger_bit} | tail -n ${SUB_SIZE}`
sing_home=$(mktemp -d -t wb-XXXXXXXXXX)
fmriprep_folder=${DERIVED_DIR}/fmriprep
cifti_bold=$(find ${fmriprep_folder}/ -type f -name "*_task-*_bold.dtseries.nii")
for ff in ${cifti_bold};
do
if [[ "$ff" == *"$SUBJECT"* ]]; then
func_base=$(basename ${ff})
dtseries=${ff}
echo $func_base
if [[ "$ff" == *"ses"* ]]; then
sub="$(cut -f1 -nd "_" <<< "$func_base")"
ses="$(cut -f2 -nd "_" <<< "$func_base")"
task="$(cut -f3 -nd "_" <<< "$func_base")"
container_dtseries=/fmriprep/${sub}/${ses}/func/${func_base}
confounds_tsv=/fmriprep/${sub}/${ses}/func/${sub}_${ses}_${task}_desc-confounds_timeseries.tsv
cleaned_dtseries=cifti_clean/${sub}/${ses}/func/${sub}_${ses}_${task}_space-fsLR_den-91k_desc-cleaneds0_bold.dtseries.nii
output_ptseries=parcellated/${atlas}/ptseries/${sub}/${ses}/func/${sub}_${ses}_${task}_${atlas}_desc-cleaneds0_bold.ptseries.nii
output_csv=parcellated/${atlas}/csv/${sub}/${ses}/func/${sub}_${ses}_${task}_${atlas}_desc-cleaneds0_meants.csv
mkdir -p ${DERIVED_DIR}/cifti_clean/${sub}/${ses}/func/
mkdir -p ${DERIVED_DIR}/parcellated/${atlas}/ptseries/${sub}/${ses}/func
mkdir -p ${DERIVED_DIR}/parcellated/${atlas}/csv/${sub}/${ses}/func
else
sub="$(cut -f1 -nd "_" <<< "$func_base")"
task="$(cut -f2 -nd "_" <<< "$func_base")"
container_dtseries=/fmriprep/${sub}/func/${func_base}
confounds_tsv=/fmriprep/${sub}/func/${sub}_${task}_desc-confounds_timeseries.tsv
cleaned_dtseries=cifti_clean/${sub}/func/${sub}_${task}_space-fsLR_den-91k_desc-cleaneds0_bold.dtseries.nii
output_ptseries=parcellated/${atlas}/ptseries/${sub}/func/${sub}_${task}_${atlas}_desc-cleaneds0_bold.ptseries.nii
output_csv=parcellated/${atlas}/csv/${sub}/func/${sub}_${task}_${atlas}_desc-cleaneds0_meants.csv
mkdir -p ${DERIVED_DIR}/cifti_clean/${sub}/${ses}/func/
mkdir -p ${DERIVED_DIR}/parcellated/${atlas}/ptseries/${sub}/${ses}/func
mkdir -p ${DERIVED_DIR}/parcellated/${atlas}/csv/${sub}/${ses}/func
fi
echo $dtseries
echo $container_dtseries
singularity exec \
-H ${sing_home} \
-B ${DERIVED_DIR}:/output \
-B ${fmriprep_folder}:/fmriprep \
-B ${CODEDIR}:/code \
${SING_CONTAINER} \
    ciftify_clean_img \
    --output-file=/output/${cleaned_dtseries}\
    --clean-config=/code/${clean_config} \
    --confounds-tsv=${confounds_tsv} \
    ${container_dtseries}
singularity exec \
-H ${sing_home} \
-B ${DERIVED_DIR}:/output \
-B ${parcellation_dir}:/parcellations \
${SING_CONTAINER} \
 wb_command -cifti-parcellate \
  /output/${cleaned_dtseries} \
  /parcellations/${dlabel_file} \
  COLUMN \
  /output/${output_ptseries} \
  -include-empty
singularity exec \
  -H ${sing_home} \
  -B ${DERIVED_DIR}:/output \
  ${SING_CONTAINER} wb_command -cifti-convert -to-text \
  /output/${output_ptseries} \
  /output/${output_csv} \
  -col-delim ","
fi
done
rm -r ${sing_home}
