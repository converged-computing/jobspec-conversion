#!/bin/bash
#FLUX: --job-name=Nextflow_WES
#FLUX: -t=129600
#FLUX: --priority=16

export NXF_JAVA_HOME='$workflow_path/tools/java/jdk'

set -euo pipefail
workflow_path='/hpc/diaggen/software/production/DxNextflowWES'
input=`realpath -e $1`
output=`realpath $2`
email=$3
optional_params=( "${@:4}" )
mkdir -p $output && cd $output
mkdir -p log
if ! { [ -f 'workflow.running' ] || [ -f 'workflow.done' ] || [ -f 'workflow.failed' ]; }; then
touch workflow.running
output_log="${output}/log"
file="${output_log}/nextflow_trace.txt"
if [ -e "${file}" ]; then
    current_suffix=0
    # Get a list of all trace files WITH a suffix
    trace_file_list=$(ls "${output_log}"/nextflow_trace*.txt 2> /dev/null)
    # Check if any trace files with a suffix exist
    if [ "$?" -eq 0 ]; then
        # Check for each trace file with a suffix if the suffix is the highest and save that one as the current suffix
        for trace_file in ${trace_file_list}; do
            basename_trace_file=$(basename "${trace_file}")
            if echo "${basename_trace_file}" | grep -qE '[0-9]+'; then
                suffix=$(echo "${basename_trace_file}" | grep -oE '[0-9]+')
            else
                suffix=0
            fi
            if [ "${suffix}" -gt "${current_suffix}" ]; then
                current_suffix=${suffix}
            fi
        done
    fi
    # Increment the suffix
    new_suffix=$((current_suffix + 1))
    # Create the new file name with the incremented suffix
    new_file="${file%.*}_$new_suffix.${file##*.}"
    # Rename the file
    mv "${file}" "${new_file}"
fi
sbatch <<EOT
export NXF_JAVA_HOME='$workflow_path/tools/java/jdk'
$workflow_path/tools/nextflow/nextflow run $workflow_path/WES.nf \
-c $workflow_path/WES.config \
--fastq_path $input \
--outdir $output \
--email $email \
-profile slurm \
-resume -ansi-log false \
${optional_params[@]:-""}
if [ \$? -eq 0 ]; then
    echo "Nextflow done."
    echo "Zip work directory"
    find work -type f | egrep "\.(command|exitcode)" | zip -@ -q work.zip
    echo "Remove work directory"
    rm -r work
    echo "Creating md5sum"
    find -type f -not -iname 'md5sum.txt' -exec md5sum {} \; > md5sum.txt
    echo "WES workflow completed successfully."
    rm workflow.running
    touch workflow.done
    echo "Change permissions"
    chmod 775 -R $output
    exit 0
else
    echo "Nextflow failed"
    rm workflow.running
    touch workflow.failed
    echo "Change permissions"
    chmod 775 -R $output
    exit 1
fi
EOT
else
echo "Workflow job not submitted, please check $output for 'workflow.status' files."
fi
