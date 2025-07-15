#!/bin/bash
#FLUX: --job-name=MeasureVessels
#FLUX: --queue=normal
#FLUX: -t=12600
#FLUX: --urgency=16

export MCR_CACHE_ROOT='$mcr_cache_root'

mcr_cache_root=/tmp/$USER/MCR_CACHE_ROOT${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}
mkdir -pv $mcr_cache_root
export MCR_CACHE_ROOT=$mcr_cache_root
ARIA_target="all" # [artery|vein|all]
source $HOME/retina/configs/config.sh
begin=$(date +%s)
j_array_params=$PWD/helpers/MeasureVessels/j_array_params.txt
PARAM=$(sed "${SLURM_ARRAY_TASK_ID}q;d" $j_array_params)
chunk_start=$(echo $PARAM | cut -d" " -f1)
chunk_size=$(echo $PARAM | cut -d" " -f2)
script_dir=$PWD/helpers/MeasureVessels/src/petebankhead-ARIA-328853d/ARIA_tests/
path_to_output=$scratch/retina/preprocessing/output/MeasureVessels_"$ARIA_target"/
script_parmeters="0 REVIEW $ARIA_data_dir $AV_data_dir $ARIA_target $AV_threshold $script_dir $chunk_start $chunk_size $min_QCthreshold_1 $max_QCthreshold_1 $min_QCthreshold_2 $max_QCthreshold_2 $path_to_output"
$ARIA_dir/run_ARIA_run_tests.sh $matlab_runtime $script_parmeters
rm -rv $mcr_cache_root 2>&1 >/dev/null # clear cache
echo FINISHED: files have been written to: $path_to_output
end=$(date +%s) # calculate execution time
tottime=$(expr $end - $begin)
echo "execution time: $tottime sec"
