#!/bin/bash
#SBATCH --job-name=worker
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=0
#SBATCH --time=6-00:00:00
#SBATCH --partition=cluster-name

while getopts f:e:w: flag
do
    case "${flag}" in
        f) filename=${OPTARG};;    # specified as -f
        e) envname=${OPTARG};;     # specified as -e
        w) workername=${OPTARG};;  # specified as -w
    esac
done
source $HOME/anaconda3/bin/activate $envname
PYTHONPATH=$PWD dask-worker --scheduler-file $filename --name $workername --resources "GPU=1" --no-nanny
