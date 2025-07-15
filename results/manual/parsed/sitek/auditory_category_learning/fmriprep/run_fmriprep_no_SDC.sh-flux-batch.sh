#!/bin/bash
#FLUX: --job-name=fuzzy-parsnip-2692
#FLUX: -c=4
#FLUX: -t=86400
#FLUX: --priority=16

module add freesurfer
module add fsl
module add afni
module add ants
module add singularity/3.8.3
software_path=/bgfs/bchandrasekaran/krs228/software/
project_path=/bgfs/bchandrasekaran/krs228/data/FLT/
data_dir=$project_path/data_bids_noIntendedFor/
analysis_desc=fmriprep_noSDC/
work_dir=/bgfs/bchandrasekaran/krs228/work/${analysis_desc}
out_dir=$project_path/derivatives/${analysis_desc}/
sing_dir=$software_path/singularity_images/
sing_img=$sing_dir/fmriprep-22.0.0.simg
fs_license=$software_path/license.txt
sub=$1
fs_subjects_dir=${project_path}/derivatives/fmriprep/sourcedata/freesurfer/
mem=64000
nprocs=4
omp_n=2
singularity run --cleanenv -B /bgfs:/bgfs $sing_img \
  $data_dir $out_dir participant \
  --participant-label $sub \
  --fs-license-file $fs_license \
  --work-dir $work_dir \
  --skip_bids_validation \
  --fs-subjects-dir $fs_subjects_dir \
  -vv \
  --mem $mem \
  --nprocs $nprocs --omp-nthreads $omp_n \
  --output-spaces T1w fsnative MNI152NLin2009cAsym
