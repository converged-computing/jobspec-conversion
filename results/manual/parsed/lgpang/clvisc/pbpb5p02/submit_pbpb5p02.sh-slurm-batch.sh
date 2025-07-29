#!/bin/bash
#SBATCH --job-name=clvisc
#SBATCH --output=log/%a_%j.out
#SBATCH --error=log/%a_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --mem-per-cpu=4096
#SBATCH --time=06:00:00
#SBATCH --constraint=hawaii
#SBATCH --chdir=/lustre/nyx/hyihp/lpang/PyVisc/pbpb5p02/

export PATH='/lustre/nyx/hyihp/lpang/anaconda/bin:$PATH'
export PYTHONPATH='/lustre/nyx/hyihp/lpang/anaconda/lib/python/:$PYTHONPATH'
export TMPDIR='/lustre/nyx/hyihp/lpang/tmp/'

echo "Start time: $date"
unset DISPLAY
export PATH="/lustre/nyx/hyihp/lpang/anaconda/bin:$PATH"
export PYTHONPATH="/lustre/nyx/hyihp/lpang/anaconda/lib/python/:$PYTHONPATH"
export TMPDIR="/lustre/nyx/hyihp/lpang/tmp/"
python pbpb.py 105 300 0 5 0 &
python pbpb.py 105 301 5 10 1 &
python pbpb.py 105 302 10 20 2 &
python pbpb.py 105 303 20 30 3 &
wait 
python pbpb.py 105 304 0 10 0 &
python pbpb.py 105 305 10 30 1 &
python pbpb.py 105 306 30 50 2 &
python pbpb.py 105 307 50 80 3 &
wait
python pbpb.py 105 308 0 80 0 &
python pbpb.py 105 309 30 40 1 &
python pbpb.py 105 310 40 50 2 &
python pbpb.py 105 311 50 60 3 &
wait
echo "End time: $date"
