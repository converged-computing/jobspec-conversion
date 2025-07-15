#!/bin/bash
#FLUX: --job-name=bloated-rabbit-2003
#FLUX: -c=8
#FLUX: -t=86400
#FLUX: --priority=16

export SINGULARITYENV_FS_LICENSE='$FMRIPREP_HOME/.freesurfer/license.txt'
export SINGULARITYENV_TEMPLATEFLOW_HOME='/templateflow'

DATA_NAME=(${@:1:1})
CON_IMG_DIR=(${@:2:1})
WD_DIR=${HOME}/scratch
DATA_DIR=${WD_DIR}/${DATA_NAME}
BIDS_DIR=${DATA_DIR}_BIDS
DERIVS_DIR=${DATA_DIR}_fmriprep_anat_20.1.1
CODE_DIR=${WD_DIR}/src
SUB_LIST=${CODE_DIR}/${DATA_NAME}_fmriprep_preopt.list
echo ${BIDS_DIR}***${DERIVS_DIR}***${SUB_LIST}***${SINGULARITYENV_FS_LICENSE}***${CON_IMG_DIR}***${DATA_NAME}
SUB_STR=$(sed -n "${SLURM_ARRAY_TASK_ID}p" ${SUB_LIST})
SUB_ID="$(cut -d'-' -f2 <<<${SUB_STR})"
FMRIPREP_HOME=fmriprep_home_${SUB_ID}
LOG_DIR=${DATA_DIR}_fmriprep_anat_slurm_log
WORK_DIR=${DATA_DIR}_fmriprep_anat_work
echo "Processing: sub-${SUB_ID} with home dir: ${FMRIPREP_HOME}"
mkdir -p ${FMRIPREP_HOME}
LOCAL_FREESURFER_DIR="${DERIVS_DIR}/freesurfer-6.0.1"
mkdir -p ${LOCAL_FREESURFER_DIR}
TEMPLATEFLOW_HOST_HOME=$HOME/scratch/templateflow
FMRIPREP_HOST_CACHE=$FMRIPREP_HOME/.cache/fmriprep
mkdir -p ${TEMPLATEFLOW_HOST_HOME}
mkdir -p ${FMRIPREP_HOST_CACHE}
mkdir -p $FMRIPREP_HOME/.freesurfer
export SINGULARITYENV_FS_LICENSE=$FMRIPREP_HOME/.freesurfer/license.txt
cp container_images/license.txt ${SINGULARITYENV_FS_LICENSE}
export SINGULARITYENV_TEMPLATEFLOW_HOME="/templateflow"
SINGULARITY_CMD="singularity run -B ${FMRIPREP_HOME}:/home/fmriprep --home /home/fmriprep --cleanenv \
-B ${BIDS_DIR}:/data:ro \
-B ${DERIVS_DIR}:/output \
-B ${CODE_DIR}:/codes \
-B ${TEMPLATEFLOW_HOST_HOME}:${SINGULARITYENV_TEMPLATEFLOW_HOME} \
-B ${WORK_DIR}:/work \
-B ${LOCAL_FREESURFER_DIR}:/fsdir ${CON_IMG_DIR}"
find ${LOCAL_FREESURFER_DIR}/sub-$SUB_ID/ -name "*IsRunning*" -type f -delete
cmd="${SINGULARITY_CMD} /data /output participant --participant-label $SUB_ID \
-w /work --output-spaces MNI152NLin2009cAsym:res-2 anat fsnative fsaverage5 \
--bids-filter-file /codes/pre_opt.json --fs-subjects-dir /fsdir \
--fs-license-file /home/fmriprep/.freesurfer/license.txt \
--cifti-out 91k --return-all-components \
--write-graph --skip_bids_validation --notrack --resource-monitor"
echo Running task ${SLURM_ARRAY_TASK_ID}
echo Commandline: $cmd
unset PYTHONPATH
eval $cmd
exitcode=$?
echo "sub-$SUB_ID    ${SLURM_ARRAY_TASK_ID}    $exitcode" \
      >> ${LOG_DIR}/${SLURM_JOB_NAME}_${SLURM_ARRAY_JOB_ID}.tsv
echo Finished tasks ${SLURM_ARRAY_TASK_ID} with exit code $exitcode
rm -rf ${FMRIPREP_HOME}
exit $exitcode
