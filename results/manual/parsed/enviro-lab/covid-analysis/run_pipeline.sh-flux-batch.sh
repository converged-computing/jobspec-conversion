#!/bin/bash
#FLUX: --job-name=misunderstood-frito-1023
#FLUX: -t=21600
#FLUX: --urgency=16

export PATH='$here:$PATH'

set -eu
echo "Artic sequencing and strain anlysis pipeline"
if [[ ${0} = *"slurm"* ]]; then
COMMAND=$(scontrol show job ${SLURM_JOBID} | awk -F= '/Command=/{print $2}')
else
COMMAND="${0} ${@}"
fi
here=`echo "$COMMAND" | while read cmd args; do dirname $cmd; done;`
export PATH=$here:$PATH
usage()
{
    cat << HEREDOC
This script is a wrapper to ensure all necessary environments are installed/accessible
 and to run the artic pipeline and subsequent analyses and metadata collection.
Usage: 
 `basename $0 [options]`
 -h, --help     display this help and exit
 -p, --plate    an identifier for this sequencing batch - used in output filenames (no spaces)
 -f, --fastqs   a directory containing directories of fastqs organized by barcode
 -m, --meta     a csv of metadata for each sample
 -o, --out      the output directory
 -g, --group    number of name of group - if provided, group will receive writing permissions (optional)
 -l, --local    a flag to use the local_only param (instead of attempting to use slurm)
 -V, --version  show the version and exit
HEREDOC
}
OPTS=$(getopt -l "help,plate:,fastqs:,meta:,out:,kraken_db:,group:,local,version" -o "hp:f:m:o:k:g:lV" -n "${0}" -- "$@")
if [ $? != 0 ] ; then echo "Error in command line arguments." >&2 ; usage; exit 1 ; fi
eval set -- "$OPTS"
while [[ "${#}" -gt 0 ]]; do
    case "${1}" in
        -h | --help)        usage; exit 0;;
        -p | --plate)       plate=${2}; shift 2;;
        -f | --fastqs)      fastqs=${2}; shift 2;;
        -m | --meta)        meta=${2}; shift 2;;
        -o | --out)         out=${2}; shift 2;;
        -k | --kraken_db)   kraken_db=${2}; shift 2;;
        -g | --group)       group=${2}; shift 2;;
        -l | --local)       local_only='-profile local_only'; shift;;
        -V | --version)     echo "version: `cat ${here}/version.txt`" && exit 0;;
        --)                 break;;
        *)                  echo "unexpected argument: ${1}"; exit 0;;
    esac
done
enviro_check()
{
    # prioritize using argument `kraken_db` as kraken database, if provided
    if [[ ! -z ${kraken_db:-} ]]; then
        kraken_db_info="--kraken_db ${kraken_db}"
    # if given as env variable, use that
    elif [[ ! -z ${HUMAN_KRAKEN_DATABASE:-} ]]; then
        kraken_db="$HUMAN_KRAKEN_DATABASE"
    # if found in config, use that
    else
        kraken_db=`grep kraken_db $here/nextflow.config | cut -d= -f2 | sed 's/"//g' | sed "s/'//g" | awk '{$1=$1};1'`
    fi
    # verify the file exists
    if [[ -z ${kraken_db:-}  && ! projectDir = ${kraken_db:-} ]]; then
        echo -e "To make your kraken database available, please do one of the following:\n * export HUMAN_KRAKEN_DATABASE=/your/path/to/db,\n * edit `kraken_db` in the main nextflow.config, or\n * pass in the argument `--kraken_db /your/path/to/db`\n"
        exit 1
    fi
    echo "HUMAN_KRAKEN_DATABASE=$kraken_db"
    # check for directories for all envs - if not there, make them
    for env in pangolin nextclade nextflow artic kraken2 porechop homopolish; do
        env_dir="$here/conda/env-$env"
        if [[ ! -d $env_dir ]]; then
            echo "Can't find $env_dir. Please run the following script to prepare all conda environments:"
            echo "$here/prepare_envs.sh"
            break
        fi
    done
}
main()
{
    echo Running covid analysis pipeline
    echo vars:
    for x in plate fastqs meta out; do echo "${x}: ${!x}"; done
    [[ ! -z ${group:-} ]] && echo group: $group
    cd `dirname $fastqs`
    # check for envs & create if needed
    enviro_check
    if [[ ! -z ${group:-} ]]; then group_info="--group $group"; fi
    # run
    # load in the module that lets us run conda
    module load anaconda3 &>/dev/null || source "$(dirname $(which conda))/../etc/profile.d/conda.sh" || (echo 'make sure you have conda installed'; exit 1)
    conda activate $here/conda/env-nextflow
    nextflow run $here/analyzeReads.nf \
        --plate "$plate" \
        --fastqs "$fastqs" \
        --meta "$meta" \
        --out "$out" \
        ${kraken_db_info:-} ${group_info:-} \
        -resume ${local_only:-}
    # set some permissions
    if [[ ! -z ${group:-} ]]; then
        set +e
        echo Changing permissions...
        chgrp -R enviro_lab work output slurm* *.csv .next*
        chmod -R g+w work output slurm* *.csv .next*
        echo Done changing permissions
    fi
    echo Workflow complete.
}
main
