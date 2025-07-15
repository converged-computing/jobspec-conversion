#!/bin/bash
#FLUX: --job-name=WASABI_boldmeans
#FLUX: -c=4
#FLUX: --queue=standard
#FLUX: -t=86400
#FLUX: --priority=16

export MATLAB_NUM_THREADS='1'

hostname
module load matlab/r2022a
fmriprep_dir="/dartfs-hpc/rc/lab/C/CANlab/labdata/data/spacetop_data/derivatives/fmriprep/results/fmriprep"
files=("$fmriprep_dir"/sub-*/ses-*/func/*task-social_acq-mb8_run-*_space-MNI152*preproc_bold.nii.gz)
subject=$(basename "${files[$SLURM_ARRAY_TASK_ID]}" | cut -d'-' -f2 | cut -d'_' -f1)
ses=$(basename "${files[$SLURM_ARRAY_TASK_ID]}" | cut -d'-' -f3 | cut -d'_' -f1)
task=$(basename "${files[$SLURM_ARRAY_TASK_ID]}" | cut -d'-' -f4 | cut -d'_' -f1)
run=$(basename "${files[$SLURM_ARRAY_TASK_ID]}" |  grep -oP "(?<=_run-)\d+(?=_)" | head -n1)
echo "Running $((SLURM_ARRAY_TASK_ID+1)) of ${#files[@]} files"
echo "Subject: $subject, Session: $ses, Task: $task, Run: $run"
input_file=${files[$SLURM_ARRAY_TASK_ID]}
mean_output="/dartfs-hpc/rc/lab/C/CANlab/labdata/data/spacetop_data/derivatives/fmriprep_qc/meanimg/sub-$subject/$(basename "${files[$SLURM_ARRAY_TASK_ID]%.nii.gz}")_mean.nii"
mkdir -p "$(dirname "$mean_output")"
export MATLAB_NUM_THREADS=1
matlab -nodisplay -r "addpath(genpath('//dartfs-hpc/rc/lab/C/CANlab/modules/spm12')); addpath(genpath('//dartfs-hpc/rc/lab/C/CANlab/labdata/projects/WASABI/software')); mean_fmridata('$input_file', '$mean_output'); exit;"
module unload matlab
