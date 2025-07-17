#!/bin/bash
#FLUX: --job-name=`basename
#FLUX: --urgency=16

cmd=`basename $0`
if [ ! -f $1 ]; then
    echo "Error: $1 does not exist."
    exit 1
fi 
wc=`wc -l $1|awk '{ print $1 }'`
cat <<EOF
bash -c "\$( sed -n \${SLURM_ARRAY_TASK_ID}p $1)"
EOF
