#!/bin/bash
#FLUX: --job-name=bricky-leg-8693
#FLUX: -c=2
#FLUX: --queue=gpu
#FLUX: --urgency=16

workers=0
REMAINING_ARGS=()
while [[ $# -gt 0 ]]; do
    case $1 in
        --mem)
            workers=$((`nvidia-smi --query-gpu=index,memory.total --format=csv | tail -1 | awk '{print $2}'` / $2))
            echo "With memory limit of $2, $workers workers will be launched"
            shift # past argument
            shift # past value
            ;;
        *)
            REMAINING_ARGS+=($1) # save positional arg
            shift # past argument
            ;;
    esac
done
python -m experimentator ${REMAINING_ARGS[@]} --kwargs "jobid=${SLURM_JOB_ID}" --workers $workers
