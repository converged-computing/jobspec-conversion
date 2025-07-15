#!/bin/bash
#FLUX: --job-name=anxious-soup-8010
#FLUX: -c=8
#FLUX: -t=259200
#FLUX: --priority=16

module add freesurfer
module add fsl
module add afni
module add ants
module add singularity/3.8.3
software_path=/bgfs/bchandrasekaran/krs228/software/
project_path=/bgfs/bchandrasekaran/krs228/data/FLT/
data_dir=$project_path/data_denoised/
fmriprep_version=22.1.1
analysis_desc="denoised_fmriprep-$fmriprep_version"
work_dir=/bgfs/bchandrasekaran/krs228/work/${analysis_desc}
out_dir=$data_dir/derivatives/${analysis_desc}/
sing_dir=$software_path/singularity_images/
sing_img=$sing_dir/${fmriprep_version}.simg
fs_license=$software_path/license.txt
sub=$1
fs_subjects_dir=${project_path}/derivatives/22.1.1/sourcedata/freesurfer/
mem=64000
nprocs=8
omp_n=4
singularity run --cleanenv -B /bgfs:/bgfs $sing_img \
  $data_dir $out_dir participant \
  --participant-label $sub \
  --fs-license-file $fs_license \
  --fs-subjects-dir $fs_subjects_dir \
  --work-dir $work_dir \
  --skip_bids_validation \
  -vv \
  --mem $mem \
  --nprocs $nprocs --omp-nthreads $omp_n \
  --output-spaces T1w func fsnative MNI152NLin2009cAsym
