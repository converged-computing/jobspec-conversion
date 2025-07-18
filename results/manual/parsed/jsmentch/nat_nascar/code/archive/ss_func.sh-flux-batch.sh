#!/bin/bash
#FLUX: --job-name=func
#FLUX: -c=16
#FLUX: -t=172800
#FLUX: --urgency=16

set -eu # Stop on errors
fmriprep_version=23.0.0
xcpd_version=0.4.0rc2
fmriprep_IMG=/om2/user/smeisler/fmriprep_${fmriprep_version}.img
xcpd_IMG=/om2/user/smeisler/xcp_d_${xcpd_version}.img
module add openmind8/apptainer/1.1.7
data_dir=/om4/group/gablab/data/hbn_bids/ # TEMP data are on /om4 locally, so we copy from there
args=($@)
subjs=(${args[@]:1})
bids_dir=$1
fs_license=$bids_dir/code/license.txt
subject=${subjs[${SLURM_ARRAY_TASK_ID}]}
pushd $bids_dir/$subject
ses=$(ls)
popd
scratch=/om2/scratch/tmp/$(whoami)/HBN_funcstruct_filtertest/$subject/ # assign working directory
mkdir -p ${scratch}/data/derivatives/fmriprep/
mkdir -p ${scratch}/data/derivatives/freesurfer/
mkdir -p ${scratch}/data/$subject/$ses/fmap/
output_dir=${bids_dir}/derivatives/
freesurfer_input_dir=$output_dir/freesurfer_7.3.2/$subject/
cp -nL $bids_dir/*.json ${scratch}/data/ # BIDS jsons
cp -nrL $bids_dir/$subject/$ses/anat/ ${scratch}/data/$subject/$ses/ # Anatomicals 
cp -nrL $bids_dir/$subject/$ses/func/ ${scratch}/data/$subject/$ses/ # fMRI
if [ -d $bids_dir/$subject/$ses/fmap/ ]; then
cp -nrL $bids_dir/$subject/$ses/fmap/ ${scratch}/data/$subject/$ses/ # fMRI fieldmaps
fi 
cp -n $fs_license ${scratch}/license.txt # FS license
filter=/nese/mit/group/sig/projects/hbn/hbn_bids/code/sfc/movie_filter_file.json
cp -f $filter ${scratch}/filter.json
filter_argstr="--bids-filter-file ${scratch}/filter.json"
if [ -d $freesurfer_input_dir ]; then
cp -nr $freesurfer_input_dir ${scratch}/data/derivatives/freesurfer/
fi
rm -f ${scratch}/data/derivatives/freesurfer/$subject/scripts/*Running*
cd $scratch
if [ ! -e $output_dir/fmriprep_${fmriprep_version}/${subject}.html ]; then
	# define the command
fmriprep_cmd="singularity run -e -B ${scratch} $fmriprep_IMG --participant_label ${subject:4} -w $scratch --skip-bids-validation --fs-license-file ${scratch}/license.txt --project-goodvoxels --output-layout legacy --stop-on-first-crash --nthreads 16 --omp-nthreads 8 --mem-mb 40000 --fd-spike-threshold .9 --dvars-spike-threshold 5 --notrack --cifti-output 91k --use-syn-sdc --low-mem $filter_argstr $scratch/data $scratch/data/derivatives participant" # -t rest
echo "Submitted fmriprep job for: ${subject}"
echo $'Command :\n'${fmriprep_cmd}
${fmriprep_cmd}
mkdir -p ${output_dir}/fmriprep_${fmriprep_version}/
cp -rn $scratch/data/derivatives/fmriprep/$subject ${output_dir}/fmriprep_${fmriprep_version}/
cp -n $scratch/data/derivatives/fmriprep/${subject}.html ${output_dir}/fmriprep_${fmriprep_version}/
cp -n $scratch/data/derivatives/fmriprep/*.tsv ${output_dir}/fmriprep_${fmriprep_version}/
cp -n $scratch/data/derivatives/fmriprep/dataset_description.json ${output_dir}/fmriprep_${fmriprep_version}/
if [ ! -d $freesurfer_input_dir ]; then
cp -nr $scratch/data/derivatives/fmriprep/ $freesurfer_input_dir
fi
rm -rf $scratch/fmriprep*wf/
fi
if [ ! -e $output_dir/xcp_d_${xcpd_version}/${subject}.html ]; then
xcpd_cmd="singularity run -e -B ${scratch} $xcpd_IMG $scratch/data/derivatives/fmriprep $scratch/data/derivatives participant --participant_label ${subject:4} -w $scratch -p 36P --despike --motion-filter-type lp --band-stop-min 6 --notrack -s -f .9 --nthreads 16 --omp-nthreads 8 --mem_gb 40 $filter_argstr" 
echo "Submitted xcp job for: ${subject}"
echo $'Command :\n'${xcpd_cmd}
${xcpd_cmd}
mkdir -p ${output_dir}/xcp_d_${xcpd_version}/
cp -rn $scratch/data/derivatives/xcp_d/$subject ${output_dir}/xcp_d_${xcpd_version}/
cp -n $scratch/data/derivatives/xcp_d/*.dlabel.nii ${output_dir}/xcp_d_${xcpd_version}/
cp -n $scratch/data/derivatives/xcp_d/dataset_description.json ${output_dir}/xcp_d_${xcpd_version}/
cp -n $scratch/data/derivatives/xcp_d/${subject}.html ${output_dir}/xcp_d_${xcpd_version}/
rm -rf $scratch/xcpd*wf/
rm -rf $scratch/data/derivatives/fmriprep/
rm -rf $scratch/data/derivatives/xcp_d/
fi
