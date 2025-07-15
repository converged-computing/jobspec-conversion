#!/bin/bash
#FLUX: --job-name=eccentric-soup-2465
#FLUX: -c=8
#FLUX: -t=259200
#FLUX: --priority=16

set -eu # Stop on errors
IMG='' # put path to qsiprep docker image here
scratch='' # assign working directory
args=($@)
subjs=(${args[@]:1})
bids_dir=$1
subject=${subjs[${SLURM_ARRAY_TASK_ID}]}
output_dir=${bids_dir}/derivatives
mkdir -p ${output_dir}
mkdir -p ${scratch}/${subject}_db/derivatives/qsiprep
ln -sf $bids_dir/dataset_description.json $scratch/${subject}_db/dataset_description.json 
ln -sf $bids_dir/$subject $scratch/${subject}_db/$subject
ln -sf $bids_dir/derivatives/qsiprep/$subject/ $scratch/${subject}_db/derivatives/qsiprep/
cmd="singularity run -B ${scratch},${bids_dir},${output_dir} $IMG --participant_label ${subject:4} -w $scratch --recon-only --recon-input $scratch/${subject}_db/derivatives/qsiprep/ --recon-spec ${bids_dir}/code/qsiprep/dki_noddi_recon.json --fs-license-file ${bids_dir}/code/qsiprep/license.txt --skip-bids-validation $scratch/${subject}_db/ ${output_dir} participant"
echo "Submitted job for: ${subject}"
echo $'Command :\n'${cmd}
${cmd}
