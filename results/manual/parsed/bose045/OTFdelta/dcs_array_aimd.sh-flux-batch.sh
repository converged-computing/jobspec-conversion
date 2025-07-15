#!/bin/bash
#FLUX: --job-name=stanky-banana-3199
#FLUX: --priority=16

iter=$1
folderIter=$(printf "%04d" $iter)
cd ./${folderIter}/AIMD
run_dir=$(sed -n "${SLURM_ARRAY_TASK_ID}p" valid_run_dirs.txt)
sysNum=$(echo "$run_dir" | cut -d'/' -f1)
runFol=$(echo "$run_dir" | cut -d'/' -f2)
numericPart=${sysNum#sys}
if [[ $numericPart -ge 0 ]] && [[ $sysNum -le 4 ]]; then
    jobFile="../../../../pybash/jdftx-gpu.job"
elif [[ $numericPart -ge 5 ]] && [[ $sysNum -le 7 ]]; then
    jobFile="../../../../pybash/jdftx-gpu-2.job"
else
    jobFile="../../../../pybash/jdftx-gpu.job"
fi
cd $sysNum/$runFol
cp ../../../../pybash/md.in .
sbatch $jobFile $sysNum $(echo "$runFol" | sed 's/\///g')
cd ../..
