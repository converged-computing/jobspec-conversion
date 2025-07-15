#!/bin/bash
#FLUX: --job-name=gloopy-peanut-butter-8270
#FLUX: -t=600
#FLUX: --priority=16

format_time() {
  ((h=${1}/3600))
  ((m=(${1}%3600)/60))
  ((s=${1}%60))
  printf "%02d:%02d:%02d\n" $h $m $s
 }
echo 'List1'
ls -l -d ~/scratch/*/
echo 'List2'
ls -l -d ~/*/
mlflow_dir="validation_output/mlruns"
dt=$(date '+%d-%m-%Y-%H-%M-%S');
echo "Time Signature: ${dt}"
out_dir_f="validation_output/"
mkdir -p $out_dir_f
out_dir="${out_dir_f}${dt}"
mkdir -p $out_dir
echo "Using OutDir: : ${out_dir}"
echo 'Starting task !'
echo 'Load Modules Python !'
echo 'Creating VENV'
virtualenv --no-download $SLURM_TMPDIR/env
echo 'Source VENV'
source $SLURM_TMPDIR/env/bin/activate
echo 'Installing package'
echo 'Calling python script'
python ./Finetuning/finetuning.py \
--config ./Finetuning/config_macos.yml \
--xray_path 'NIH/' \
--output_dir $out_dir \
--mlflow_dir $mlflow_dir| tee finetuning_${dt}.txt
echo "Time Signature: ${dt}"
echo "Saving Monolytic File Archive in : ${out_dir}/finetuning${dt}.txt"
echo "Script completed in $(format_time $SECONDS)"
mv finetuning_${dt}.txt "${out_dir}/finetuning_${dt}.txt"
