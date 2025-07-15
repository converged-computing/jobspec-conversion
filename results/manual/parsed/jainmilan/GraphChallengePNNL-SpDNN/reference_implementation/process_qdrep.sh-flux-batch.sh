#!/bin/bash
#FLUX: --job-name=chocolate-punk-2766
#FLUX: --priority=16

module load cuda/11.4
i=0
for file in /qfs/projects/pacer/milan/logs/GraphChallenge/nsys/*.qdrep
do
    i=$(( i + 1 ))
    name=${file##*/}
    echo "$file"
    if [ "$i" -gt 0 ]; then
        #echo "helloooooooooooooooo"
        #echo ""
        nsys stats -f csv -o . --force-overwrite true $file
    fi
done
