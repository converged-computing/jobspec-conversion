#!/bin/bash
#FLUX: --job-name=doopy-lemur-9912
#FLUX: --priority=16

module load cuda/11.4
i=0
for file in /qfs/projects/pacer/proxytsprd/output/profiles/theta_profiles/profiles_v3/*.qdrep
do
    i=$(( i + 1 ))
    name=${file##*/}
    echo "$file"
    if [ "$i" -gt 0 ]; then
        #echo "helloooooooooooooooo"
        #echo ""
        nsys stats -f csv -o . --force-overwrite=true $file
    fi
done
