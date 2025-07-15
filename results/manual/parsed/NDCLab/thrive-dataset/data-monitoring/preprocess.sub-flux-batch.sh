#!/bin/bash
#FLUX: --job-name=milky-kitty-4676
#FLUX: -t=1800
#FLUX: --urgency=16

source /home/data/NDClab/tools/lab-devOps/scripts/monitor/tools.sh
module load singularity-3.5.3
module load r-4.0.2-gcc-8.2.0-tf4pnwr
module load miniconda3-4.5.11-gcc-8.2.0-oqs2mbg
dataset=$(dirname $(pwd))
output_path="${dataset}/derivatives/preprocessed"
data_source="${dataset}/sourcedata/checked/redcap/"
data_dict="${dataset}/data-monitoring/data-dictionary/central-tracker_datadict.csv"
log="${dataset}/data-monitoring/data-monitoring-log.md"
dir="$(basename $dataset)"
tracker="${dataset}/data-monitoring/central-tracker_${dir}.csv"
datadict="${dataset}/data-monitoring/data-dictionary/central-tracker_datadict.csv"
sing_image="/home/data/NDClab/tools/instruments/containers/singularity/inst-container.simg"
json_scorer="/home/data/NDClab/tools/instruments/scripts/json_scorer.py"
survey_data="/home/data/NDClab/tools/instruments/scripts/surveys.json"
id_col_script="/home/data/NDClab/tools/instruments/scripts/get_id_col.py"
input_files=$( get_new_redcaps $data_source)
echo "Found newest redcaps: ${input_files}"
for input_file in ${input_files}
do
    idcol=$(python3 $id_col_script "${data_source}/${input_file}" $data_dict)
    # run instruments to preprocess survey data
    singularity exec --bind $dataset,/home/data/NDClab/tools/instruments \
                    $sing_image \
                    python3 $json_scorer \
                    "${data_source}/${input_file}" \
                    $survey_data \
                    $output_path \
                    $idcol \
                    $datadict \
                    $tracker
done
if [[ ! -f "$log" ]]; then
    echo "$log does not exist, skipping log."
    exit 0
fi
now=`date '+%Y-%m-%d_%T'`
echo "${now} Preprocessing ran: view slurm-${SLURM_JOB_ID}.out file to see effects." >> $log
