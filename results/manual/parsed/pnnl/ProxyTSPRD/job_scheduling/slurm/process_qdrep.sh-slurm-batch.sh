#!/bin/bash
#SBATCH --job-name=process_qdrep_resnet_train
#SBATCH --account=pacer
#SBATCH --output=oresnet_train.txt
#SBATCH --error=eresnet_train.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=2-00:00:00
#SBATCH --partition=a100_shared

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
