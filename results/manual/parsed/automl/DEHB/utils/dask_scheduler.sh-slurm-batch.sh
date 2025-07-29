#!/bin/bash
#SBATCH --job-name=scheduler
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:0
#SBATCH --mem=0
#SBATCH --time=6-00:00:00

while getopts f:e: flag
do
    case "${flag}" in
        f) filename=${OPTARG};;  # specified as -f
        e) envname=${OPTARG};;   # specified as -e
        *) echo "usage: $0 [-f] [-e]"
           echo "  -f: filename of scheduler file"
           echo "  -e: name of conda environment"
           exit 1 ;;
    esac
done
source "$HOME/anaconda3/bin/activate" "$envname"
PYTHONPATH=$PWD dask-scheduler --scheduler-file "$filename"
