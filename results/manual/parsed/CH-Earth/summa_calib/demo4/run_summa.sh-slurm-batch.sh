#!/bin/bash
#FLUX: --job-name=demo4summa
#FLUX: -n=2
#FLUX: -t=1800
#FLUX: --urgency=16

control_file=$1   # "control_active.txt"
nJob=3            # number of jobs in job array. Should be the same as in --array.
nSubset=2         # number of GRU subsets in summa GRUs split. Should be the same as in --ntasks.
read_from_control () {
    control_file=$1
    setting=$2
    line=$(grep -m 1 "^${setting}" $control_file)
    info=$(echo ${line##*|}) # remove the part that ends at "|"
    info=$(echo ${info%%#*}) # remove the part starting at '#'; does nothing if no '#' is present
    echo $info
}
read_from_summa_route_config () {
    input_file=$1
    setting=$2
    line=$(grep -m 1 "^${setting}" $input_file)
    info=$(echo ${line%%!*}) # remove the part starting at '!'
    info="$( cut -d ' ' -f 2- <<< "$info" )" # get string after the first space
    info="${info%\'}" # remove the suffix '. Do nothing if no '.
    info="${info#\'}" # remove the prefix '. Do nothing if no '.
    echo $info
}
calib_path="$(read_from_control $control_file "calib_path")"
model_path="$(read_from_control $control_file "model_path")"
if [ "$model_path" = "default" ]; then model_path="${calib_path}/model"; fi
summa_settings_relpath="$(read_from_control $control_file "summa_settings_relpath")"
summa_settings_path=$model_path/$summa_settings_relpath
summa_filemanager="$(read_from_control $control_file "summa_filemanager")"
summa_filemanager=$summa_settings_path/$summa_filemanager
summaExe="$(read_from_control $control_file "summa_exe_path")"
summa_attributeFile="$(read_from_summa_route_config $summa_filemanager "attributeFile")"
summa_attributeFile=$summa_settings_path/$summa_attributeFile
nGRU=$( ncks -Cm -v gruId -m $summa_attributeFile | grep 'gru = '| cut -d' ' -f 7 )
countGRU=$(( ( $nGRU / ($nJob * $nSubset) ) + ( $nGRU % ($nJob * $nSubset)  > 0 ) )) 
offset=$SLURM_ARRAY_TASK_ID 
gruStart=$(( 1 + countGRU*nSubset*offset ))
gruEnd=$(( countGRU*nSubset*(offset+1) ))
if [ $gruEnd -gt $nGRU ]; then
    gruEnd=$nGRU
fi
../scripts/make_summa_run_list_jobarray.sh $control_file $gruStart $gruEnd $nSubset $countGRU $offset
srun --kill-on-bad-exit=0 --multi-prog summa_run_lists/summa_run_list_${offset}.txt 
