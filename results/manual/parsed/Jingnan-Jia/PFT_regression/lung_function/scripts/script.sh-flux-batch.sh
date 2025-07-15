#!/bin/bash
#FLUX: --job-name=carnivorous-plant-3715
#FLUX: --queue=amd-gpu-long
#FLUX: --priority=16

export PATH='$PATH:"/cm/shared/easybuild/GenuineIntel/software/git/2.38.1-GCCcore-12.2.0-nodocs/bin/git'

module load Miniconda3
module load git
eval "$(conda shell.bash hook)"
conda activate py38
job_id=$SLURM_JOB_ID
slurm_dir=results/logs
echo job_id is $job_id
scontrol write batch_script ${job_id} ${slurm_dir}/slurm-${job_id}_args.sh
ssh -tt jjia@nodelogin01 /bin/bash << ENDSSH
echo "Hello, I an in nodelogin01 to do some git operations."
echo $job_id
jobs="$(squeue -u jjia --sort=+i | grep [^0-9]0:[00-60] | awk '{print $1}')"  # "" to make sure multi lines assigned
echo "Total jobs in one minutes:"
echo \$jobs
accu=0
for i in \$jobs; do
    if [[ \$i -eq $job_id ]]; then
    echo start sleep ...
    sleep \$accu
    echo sleep \$accu seconds
    fi
    echo \$i
    ((accu+=5))  # self increament
    echo \$accu
done
cd data/lung_function
echo $job_id
scontrol write batch_script "${job_id}" lung_function/scripts/current_script.sh  # for the git commit latter
git add -A
sleep 2  # avoid error: fatal: Could not parse object (https://github.com/Shippable/support/issues/2932)
git rm --cached *mlrunsdb.db-journal*
git commit -m "jobid is ${job_id}"
sleep 2
git push origin master
sleep 2
exit
ENDSSH
echo "Hello, I am back in $(hostname) to run the code"
conda activate py38
root_dir="/home/jjia/data/lung_function"
cd ${root_dir}
script_dir=${root_dir}/lung_function/scripts
pwd
which conda
conda info --envs
conda list
export PATH=$PATH:"/cm/shared/easybuild/GenuineIntel/software/git/2.38.1-GCCcore-12.2.0-nodocs/bin/git"
idx=0; export CUDA_VISIBLE_DEVICES=$idx; stdbuf -oL python -u ${script_dir}/run.py 2>${script_dir}/${slurm_dir}/slurm-${job_id}_${idx}_err.txt 1>${script_dir}/${slurm_dir}/slurm-${job_id}_${idx}_out.txt --hostname="$(hostname)" --jobid=${job_id} --epochs=100 --remark="change first conv layer and all 1,2,2, conv layer to have 2048,2,2,2 final hidden features, 100 epochs"
