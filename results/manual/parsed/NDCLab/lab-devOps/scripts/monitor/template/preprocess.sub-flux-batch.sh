#!/bin/bash
#FLUX: --job-name=eccentric-destiny-5140
#FLUX: -t=1800
#FLUX: --urgency=16

source /home/data/NDClab/tools/lab-devOps/scripts/monitor/tools.sh
module load singularity-3.8.2
module load r-4.0.2-gcc-8.2.0-tf4pnwr
module load miniconda3-4.5.11-gcc-8.2.0-oqs2mbg
module load matlab-2021b
dataset=$(dirname $(pwd))
output_path="${dataset}/derivatives/preprocessed/redcap"
data_source="${dataset}/sourcedata/checked/redcap/"
data_dict="${dataset}/data-monitoring/data-dictionary/central-tracker_datadict.csv"
log="${dataset}/data-monitoring/data-monitoring-log.md"
proj="$(basename $dataset)"
tracker="${dataset}/data-monitoring/central-tracker_${proj}.csv"
datadict="${dataset}/data-monitoring/data-dictionary/central-tracker_datadict.csv"
sing_image="/home/data/NDClab/tools/instruments/containers/singularity/inst-container.simg"
json_scorer="/home/data/NDClab/tools/instruments/scripts/json_scorer.py"
survey_data="/home/data/NDClab/tools/instruments/scripts/surveys.json"
id_col_script="/home/data/NDClab/tools/instruments/scripts/get_id_col.py"
input_files=$( get_new_redcaps $data_source)
echo "Found newest redcaps: ${input_files}"
for input_file in ${input_files}
do
    #idcol=$(python3 $id_col_script "${data_source}/${input_file}" $data_dict)
    idcol=$(singularity exec -e $sing_image python3 $id_col_script "${data_source}/${input_file}" $datadict)
    # run instruments to preprocess survey data
    singularity exec --bind $dataset,/home/data/NDClab/tools/instruments \
                    $sing_image \
                    python3 $json_scorer \
                    "${data_source}/${input_file}" \
                    $survey_data \
                    $idcol \
                    -o $output_path \
                    -d $datadict \
                    -t $tracker
done
sessions=($(find ${dataset}/sourcedata/raw -mindepth 1 -maxdepth 1 -type d -printf "%f\n"))
if [[ -z "$score" ]]; then
    if [[ -n "$sstr" ]]; then
        IFS=',' read -ra subs_to_process <<< $sstr && unset IFS
        for s in ${subs_to_process[@]}; do
            session=$(echo $s | cut -d':' -f1)
            subjects_to_process=$(echo $s | cut -d':' -f2)
            matlab -nodisplay -nosplash -r "addpath('$dataset/code'); MADE_pipeline $proj $subjects_to_process $session"
            # update tracker
            singularity exec -e $sing_image python3 update-tracker-postMADE.py $proj $session
        done
    elif [[ -n "$nstr" ]]; then
        IFS=',' read -ra subs_not_to_process <<< $nstr && unset IFS
        for s in ${subs_not_to_process[@]}; do
            session=$(echo $s | cut -d':' -f1)
            subjects_not_to_process=$(echo $s | cut -d':' -f2)
            subjects_to_process=$(singularity exec -e $sing_image python3 subjects_yet_to_process.py $project $session) #need container for pandas
            subs_arr=($(echo ${subjects_to_process} | sed 's/\// /g'))
            for subnot in $(echo ${subjects_not_to_process} | sed 's/\// /g' ); do
                #subjects_to_process=$(echo $subjects_to_process | sed -E 's/${subnot}(\/)?//g')
                subs_arr=($(echo ${subs_arr[@]/$subnot}))
            done
            subjects_to_process=$(echo ${subs_arr[*]} | sed 's/ /\//g')
            matlab -nodisplay -nosplash -r "addpath('$dataset/code'); MADE_pipeline $proj $subjects_to_process $session"
            # update tracker
            singularity exec -e $sing_image python3 update-tracker-postMADE.py $proj $session
        done
    else
        for session in ${sessions[@]}; do
            subjects_to_process=$(singularity exec -e $sing_image python3 subjects_yet_to_process.py $(basename $dataset) $session) #need container for pandas
            if [[ -n ${subjects_to_process} ]]
                then
                matlab -nodisplay -nosplash -r "addpath('$dataset/code'); MADE_pipeline $proj $subjects_to_process $session"
                # update tracker
                singularity exec -e $sing_image python3 update-tracker-postMADE.py $proj $session
            fi
        done
    fi
    NUMERRORS=$(cat preprocess.sub-${SLURM_JOB_ID}.out | grep "ERROR: " | wc -l)
    if [[ $NUMERRORS -gt 0 ]]; then
        cat preprocess.sub-${SLURM_JOB_ID}.out | grep "ERROR: " > preprocess.sub-${SLURM_JOB_ID}_errorlog.out
    fi
else
    echo -e "skipping preprocessing"
fi
if [[ ! -f "$log" ]]; then
    echo "$log does not exist, skipping log."
    exit 0
fi
now=`date '+%Y-%m-%d_%T'`
echo "${now} Preprocessing ran: view slurm-${SLURM_JOB_ID}.out file to see effects." >> $log
