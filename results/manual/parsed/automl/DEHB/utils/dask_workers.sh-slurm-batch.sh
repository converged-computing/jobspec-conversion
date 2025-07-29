#!/bin/bash
#SBATCH --job-name=worker
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=0
#SBATCH --time=6-00:00:00

while getopts f:e:w: flag
do
    case "${flag}" in
        f) filename=${OPTARG};;    # specified as -f
        e) envname=${OPTARG};;     # specified as -e
        w) workername=${OPTARG};;  # specified as -w
        *) echo "usage: $0 [-f] [-e] [-w]"
           echo "  -f: filename of scheduler file"
           echo "  -e: name of conda environment"
           echo "  -w: name of worker"
           exit 1 ;;
    esac
done
source "$HOME/anaconda3/bin/activate" "$envname"
PYTHONPATH=$PWD dask-worker \
  --scheduler-file "$filename" \
  --name "$workername" \
  --resources "GPU=1" \
  --no-nanny
