#!/bin/bash
#FLUX: --job-name=phat-underoos-8168
#FLUX: --queue=work
#FLUX: --urgency=16

subject=$1
cpus=$2
granularity=$3
field=$4
if [ $subject == "ffmpeg"  ]; then
    declare -a releases=(
        "0.5.0" "0.6.0" "0.7.0" "0.8.0" "0.9.0" "0.10.0" "0.11.0" "1.0.0"
        "1.1.0" "1.2.0" "2.0.0" "2.1.0" "2.2.0" "2.3.0" "2.4.0" "2.5.0"
    )
    export LD_LIBRARY_PATH="$HOME/lib:$HOME/lib64"
    export PKG_CONFIG_PATH="$HOME/lib/pkgconfig:$HOME/lib64/pkgconfig"
elif [ $subject == "wireshark" ]; then
    declare -a releases=(
        "1.0.0" "1.2.0" "1.4.0" "1.6.0" "1.8.0" "1.10.0" "1.12.0"
    )
fi
module load python/3.5.2
source venv/bin/activate
DEBUG=1 python3 manage.py updatedb \
    -s $subject \
    -r ${releases[${SLURM_ARRAY_TASK_ID}]} \
    -f $field \
    -g $granularity
