#!/bin/bash
#SBATCH --job-name=equiformer
#SBATCH --output=outslurm/slurm-%j.txt
#SBATCH --error=outslurm/slurm-%j.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=2000
#SBATCH --time=1-06:00:00

export SCRIPTDIR='${HOME_DIR}/equilibrium-forcefields/equiformer'

echo `date`: Job $SLURM_JOB_ID is allocated resources.
echo "Inside slurm_launcher.slrm ($0). received arguments: $@"
HOME_DIR=/home/andreasburger
export SCRIPTDIR=${HOME_DIR}/equilibrium-forcefields/equiformer
if [[ $1 == *"test"* ]]; then
    echo "Found test in the filename. Changing the scriptdir to equilibrium-forcefields/tests"
    export SCRIPTDIR=${HOME_DIR}/equilibrium-forcefields/tests
elif [[ $1 == *"deq"* ]]; then
    echo "Found deq in the filename. Changing the scriptdir to equilibrium-forcefields/scripts"
    export SCRIPTDIR=${HOME_DIR}/equilibrium-forcefields/scripts
fi
echo "Submitting ${SCRIPTDIR}/$@"
${HOME_DIR}/miniforge3/envs/deq/bin/python ${SCRIPTDIR}/"$@"
