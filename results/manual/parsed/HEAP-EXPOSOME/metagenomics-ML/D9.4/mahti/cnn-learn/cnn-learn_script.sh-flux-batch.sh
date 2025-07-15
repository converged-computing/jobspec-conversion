#!/bin/bash
#FLUX: --job-name=CNN-learn
#FLUX: --queue=gpumedium
#FLUX: -t=3600
#FLUX: --priority=16

timer=`date +%s`
function log {
  local output=$(echo "";echo "`date +'%y-%m-%d %H:%M:%S'`" ; while IFS= read -r line; do echo -e "\t$line"; done < <(echo -e "$@");echo "")
  echo "$output"
  echo "$output" 1>&2
}
function esc {
    echo "$@" | sed 's#\\#\\\\\\\\#g'
}
log "Current date: $(esc "`date`")"
log "Master host: $(esc "`/bin/hostname`")"
log "Working directory: $(esc "`pwd`")"
log "Current job: $SLURM_JOB_ID\n$(esc "`scontrol show job $SLURM_JOB_ID`")"
log "Current script: $0\n$(esc "`cat -n $0`")"
log "Python script: cnn-learn.py\n$(esc "`cat -n cnn-learn.py`")"
log "Loading modules"
module load tensorflow
JOB_ID=$SLURM_JOB_ID
mkdir job-$JOB_ID && cd job-$JOB_ID
cp ../cnn-learn.py ./
log "Preparing nodes list"
srun hostname -s | sort > all_nodes.txt
log "All nodes: `uniq -c all_nodes.txt | xargs -I {} echo ' {}' | paste -sd ','`"
log "Running tests"
python3 cnn-learn.py \
            | tee >(cat >&2)
timer=$(( `date +%s` - $timer ))
h=$(( $timer / (60 * 60) ))
m=$(( ($timer / 60) % 60 ))
s=$(( $timer % 60 ))
log "Script completed after ${h}h ${m}m ${s}s."
