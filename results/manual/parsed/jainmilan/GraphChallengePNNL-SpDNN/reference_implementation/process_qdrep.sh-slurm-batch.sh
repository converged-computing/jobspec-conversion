#!/bin/bash
#SBATCH --job-name=process_qdrep
#SBATCH --account=pacer
#SBATCH --output=oresnet_train.txt
#SBATCH --error=eresnet_train.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:0
#SBATCH --time=2-00:00:00

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
