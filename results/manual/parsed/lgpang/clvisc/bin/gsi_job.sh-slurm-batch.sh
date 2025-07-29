#!/bin/bash
#SBATCH --job-name=clvisc
#SBATCH --output=log/%a_%j.out
#SBATCH --error=log/%a_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --mem-per-cpu=4096
#SBATCH --time=2-00:00:00
#SBATCH --constraint=hawaii
#SBATCH --chdir=/lustre/nyx/hyihp/lpang/PyVisc/bin/

export PATH='/lustre/nyx/hyihp/lpang/anaconda/bin:$PATH'
export PYTHONPATH='/lustre/nyx/hyihp/lpang/anaconda/lib/python/:$PYTHONPATH'
export TMPDIR='/lustre/nyx/hyihp/lpang/tmp/'

echo "Start time: $date"
unset DISPLAY
export PATH="/lustre/nyx/hyihp/lpang/anaconda/bin:$PATH"
export PYTHONPATH="/lustre/nyx/hyihp/lpang/anaconda/lib/python/:$PYTHONPATH"
export TMPDIR="/lustre/nyx/hyihp/lpang/tmp/"
python ebe.py auau200 20_50 0.08 0 &
python ebe.py auau62p4 20_50 0.08 1 &
python ebe.py auau39 20_50 0.08 2 &
python ebe.py auau19p6 20_50 0.08 3 &
wait
echo "End time: $date"
