#!/bin/bash
#FLUX: --job-name=blue-leg-0192
#FLUX: -t=1440
#FLUX: --urgency=16

module load singularity-3.8.2
singularity exec -e /home/data/NDClab/tools/containers/python-3.8/python-3.8.simg ./hallMonitor.sh
source /home/data/NDClab/tools/lab-devOps/scripts/monitor/tools.sh
logfile="data-monitoring-log.md"
NUMERRORS=$(cat slurm-${SLURM_JOB_ID}.out | grep "Error: " | wc -l)
if [[ $NUMERRORS -gt 0 ]]; then
    cat slurm-${SLURM_JOB_ID}.out | grep "Error: " > slurm-${SLURM_JOB_ID}_errorlog.out
    error_detected="true"
else
    error_detected="false"
fi
if [ $error_detected = true ]; then
    update_log "error; $NUMERRORS errors seen, check slurm-${SLURM_JOB_ID}_errorlog.out for more info" $logfile
else
    update_log "success" $logfile
fi
