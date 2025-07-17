#!/bin/bash
#FLUX: --job-name=process_qdrep_resnet_train
#FLUX: --queue=a100_shared
#FLUX: -t=172800
#FLUX: --urgency=16

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
