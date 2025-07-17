#!/bin/bash
#FLUX: --job-name=geoflood.%j
#FLUX: -n=67
#FLUX: --queue=normal
#FLUX: -t=172800
#FLUX: --urgency=16

args=( )
for arg; do
    case "$arg" in
        --job )                   args+=( -j ) ;;
        --job_id )                args+=( -d ) ;;
        --path_img )         args+=( -i ) ;;
        --path_sh )          args+=( -s ) ;;
        --path_log )         args+=( -l ) ;;
        --path_cmds )        args+=( -c ) ;;
        --path_cmd_outputs ) args+=( -o ) ;;
        --path_rc )          args+=( -r ) ;;
        --queue )                 args+=( -q ) ;;
        --start_time )            args+=( -t ) ;;
        *)                        args+=( "$arg" ) ;;
    esac
done
set -- "${args[@]}"
ARGS=""
while [ $# -gt 0 ]; do
    unset OPTIND
    unset OPTARG
    while getopts "j:d:i:s:l:c:o:r:q:t:" OPTION; do
        : "$OPTION" "$OPTARG"
        case $OPTION in
            j) JOBS="$OPTARG";;
            d) SLURM_JOB_ID="$OPTARG";;
            i) PATH_IMG="$(readlink -f $OPTARG)";;
            s) PATH_SH="$(readlink -f $OPTARG)";;
            l) PATH_LOG="$OPTARG";;
            c) PATH_CMDS="$(readlink -f $OPTARG)";;
            o) PATH_CMD_OUTPUTS="$(readlink -f $OPTARG)";;
            r) PATH_RC="$(readlink -f $OPTARG)";;
            q) QUEUE="$OPTARG";;
            t) START_TIME="$OPTARG";;
        esac
    done
    shift $((OPTIND-1))
    ARGS="${ARGS} $1 "
    shift
done
module unload xalt
module load tacc-singularity
bash --noprofile \
     --norc \
     -c "${PATH_SH} -j $JOBS --job_id ${SLURM_JOB_ID} --queue ${QUEUE} --start_time ${START_TIME} --path_rc ${PATH_RC} --path_cmds ${PATH_CMDS} --path_cmd_outputs ${PATH_CMD_OUTPUTS} --path_log ${PATH_LOG} $ARGS"
