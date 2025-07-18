#!/bin/bash
#FLUX: --job-name=rsfc
#FLUX: -c=4
#FLUX: --queue=short
#FLUX: -t=10800
#FLUX: --urgency=16

pwd; hostname; date
set -e
module load singularity/3.7.1
DATA="OPI"
HOST_DIR="/gpfs1/home/m/r/mriedel"
PROJECT="pace"
DSETS_DIR="${HOST_DIR}/${PROJECT}/dsets"
BIDS_DIR="${DSETS_DIR}/dset-${DATA}"
CODE_DIR="${DSETS_DIR}/code"
IMG_DIR="${HOST_DIR}/${PROJECT}/software"
DERIVS_DIR="${BIDS_DIR}/derivatives"
ROIs_DIR="${HOST_DIR}/${PROJECT}/seed-regions"
mriqc_ver=0.16.1
fmriprep_ver=20.2.5
afni_ver=22.0.20
MRIQC_DIR="${DERIVS_DIR}/mriqc-${mriqc_ver}"
CLEAN_DIR="${DERIVS_DIR}/denoising-${afni_ver}"
subject=$( sed -n -E "$((${SLURM_ARRAY_TASK_ID} + 1))s/sub-(\S*)\>.*/\1/gp" ${BIDS_DIR}/participants.tsv )
desc_clean="aCompCorCens"
desc_sm="aCompCorSM6Cens"
space="MNI152NLin2009cAsym"
seed_regions=(insula hippocampus striatum)
hemispheres=(lh rh)
for seed_region in ${seed_regions[@]}; do
    for hemis in ${hemispheres[@]}; do
        if [[ ${seed_region} ==  "vmPFC" ]]; then
            C1="/rois_dir/sub-vmPFC1_desc-brain_mask.nii.gz"
            C2="/rois_dir/sub-vmPFC2_desc-brain_mask.nii.gz"
            C3="/rois_dir/sub-vmPFC3_desc-brain_mask.nii.gz"
            C4="/rois_dir/sub-vmPFC4_desc-brain_mask.nii.gz"
            C5="/rois_dir/sub-vmPFC5_desc-brain_mask.nii.gz"
            C6="/rois_dir/sub-vmPFC6_desc-brain_mask.nii.gz"
            clusters=(${C1} ${C2} ${C3} ${C4} ${C5} ${C6})
            RSFC_DIR="${DERIVS_DIR}/rsfc-${seed_region}_C1-C2-C3-C4-C5-C6"
        elif [[ ${seed_region} ==  "insula" ]]; then
            C1="/rois_dir/sub-insulaD${hemis}_desc-brain_mask.nii.gz"
            C2="/rois_dir/sub-insulaP${hemis}_desc-brain_mask.nii.gz"
            C3="/rois_dir/sub-insulaV${hemis}_desc-brain_mask.nii.gz"
            clusters=(${C1} ${C2} ${C3})
            RSFC_DIR="${DERIVS_DIR}/rsfc-${seed_region}_D${hemis}-P${hemis}-V${hemis}"
        elif [[ ${seed_region} ==  "hippocampus" ]]; then
            C1="/rois_dir/sub-hippocampus3solF1${hemis}_desc-brain_mask.nii.gz"
            C2="/rois_dir/sub-hippocampus3solF2${hemis}_desc-brain_mask.nii.gz"
            C3="/rois_dir/sub-hippocampus3solF3${hemis}_desc-brain_mask.nii.gz"
            clusters=(${C1} ${C2} ${C3})
            RSFC_DIR="${DERIVS_DIR}/rsfc-${seed_region}_3solF1${hemis}-3solF2${hemis}-3solF3${hemis}"
        elif [[ ${seed_region} ==  "striatum" ]]; then
            C1="/rois_dir/sub-striatumMatchCD${hemis}_desc-brain_mask.nii.gz"
            C2="/rois_dir/sub-striatumMatchCV${hemis}_desc-brain_mask.nii.gz"
            C3="/rois_dir/sub-striatumMatchDL${hemis}_desc-brain_mask.nii.gz"
            C4="/rois_dir/sub-striatumMatchD${hemis}_desc-brain_mask.nii.gz"
            C5="/rois_dir/sub-striatumMatchR${hemis}_desc-brain_mask.nii.gz"
            C6="/rois_dir/sub-striatumMatchV${hemis}_desc-brain_mask.nii.gz"
            clusters=(${C1} ${C2} ${C3} ${C4} ${C5} ${C6})
            RSFC_DIR="${DERIVS_DIR}/rsfc-${seed_region}_matchCD${hemis}-matchCV${hemis}-matchDL${hemis}-matchD${hemis}-matchR${hemis}-matchV${hemis}"
        fi
        mkdir -p ${RSFC_DIR}
        # Run denoising pipeline
        # Compose the command line
        SHELL_CMD="singularity exec --cleanenv \
            -B ${CODE_DIR}:/code \
            -B ${MRIQC_DIR}:/mriqc \
            -B ${CLEAN_DIR}:/clean \
            -B ${RSFC_DIR}:/rsfc \
            -B ${ROIs_DIR}/${seed_region}:/rois_dir \
            $IMG_DIR/afni-${afni_ver}.sif"
        # Run python script inside fmriprep environment
        rsfc="${SHELL_CMD} python /code/rsfc-seed2voxel.py \
            --mriqc_dir /mriqc \
            --clean_dir /clean \
            --rsfc_dir /rsfc \
            --subject sub-${subject} \
            --space ${space} \
            --desc_list ${desc_clean} ${desc_sm} \
            --rois ${clusters[@]} \
            --n_jobs ${SLURM_CPUS_PER_TASK}"
        # Setup done, run the command
        echo
        echo Commandline: $rsfc
        eval $rsfc 
        exitcode=$?
    done
done
echo "sub-$subject   ${SLURM_ARRAY_TASK_ID}    $exitcode" \
      >> ${DSETS_DIR}/code/log/${SLURM_JOB_NAME}/${DATA}/${SLURM_JOB_NAME}.${SLURM_ARRAY_JOB_ID}.tsv
echo Finished tasks ${SLURM_ARRAY_TASK_ID} with exit code $exitcode
date
exit $exitcode
