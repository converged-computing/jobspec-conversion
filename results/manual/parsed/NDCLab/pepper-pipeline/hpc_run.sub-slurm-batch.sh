#!/bin/bash
#SBATCH --job-name=pipeline_run
#SBATCH --account=iacc_gbuzzell
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --time=00:02:00
#SBATCH --qos=medium

module load singularity-3.5.3
ls /home/data/NDClab/data/base-eeg/CMI/rawdata/ -F | grep / > subjects.txt
arr=()
while IFS= read -r line; do
  arr+=("$line")
done < subjects.txt
parallel_script=""
for sub in "${arr[@]}"
do
   sub=${sub:4}
   sub_num=${sub::-1}
   parallel_script+="srun --ntasks=1 "
   parallel_script+="singularity exec --bind /home/data/NDClab/data/base-eeg/CMI/derivatives,"
   parallel_script+="/home/data/NDClab/data/base-eeg/CMI/rawdata"
   parallel_script+=" container/run-container.simg python3 run.py & "
done
parallel_script+="wait"
echo $parallel_script
eval "$parallel_script"
rm -f subjects.txt
