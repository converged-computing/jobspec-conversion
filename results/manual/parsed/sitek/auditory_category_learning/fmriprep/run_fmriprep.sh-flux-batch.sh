#!/bin/bash
#FLUX: --job-name=loopy-puppy-4393
#FLUX: -c=12
#FLUX: -t=259200
#FLUX: --urgency=16

module add freesurfer
module add fsl
module add afni
module add ants
module add singularity/3.8.3
software_path=/bgfs/bchandrasekaran/krs228/software/
project_path=/bgfs/bchandrasekaran/krs228/data/FLT/
data_dir=$project_path/data_bids/
analysis_desc=fmriprep
work_dir=/bgfs/bchandrasekaran/krs228/work/${analysis_desc}
out_dir=$project_path/derivatives/${analysis_desc}/
sing_dir=$software_path/singularity_images/
sing_img=$sing_dir/fmriprep-20.0.1.simg
fs_license=$software_path/license.txt
sub=$1
mem=100000
nprocs=12
omp_n=4
singularity run --cleanenv -B /bgfs:/bgfs $sing_img \
  $data_dir $out_dir participant \
  --participant-label $sub \
  --fs-license-file $fs_license \
  --work-dir $work_dir \
  --skip_bids_validation \
  -vv \
  --mem $mem \
  --nprocs $nprocs --omp-nthreads $omp_n \
  --output-spaces T1w func fsnative MNI152NLin2009cAsym
