#!/bin/bash
#FLUX: --job-name=clvisc
#FLUX: -n=4
#FLUX: --queue=lcsc
#FLUX: -t=7200
#FLUX: --urgency=16

export PATH='/lustre/nyx/hyihp/lpang/anaconda/bin:$PATH'
export PYTHONPATH='/lustre/nyx/hyihp/lpang/anaconda/lib/python/:$PYTHONPATH'
export TMPDIR='/lustre/nyx/hyihp/lpang/tmp/'

echo "Start time: $date"
unset DISPLAY
export PATH="/lustre/nyx/hyihp/lpang/anaconda/bin:$PATH"
export PYTHONPATH="/lustre/nyx/hyihp/lpang/anaconda/lib/python/:$PYTHONPATH"
export TMPDIR="/lustre/nyx/hyihp/lpang/tmp/"
python pbpb.py 86 100 0 5 0 &
python pbpb.py 86 101 5 10 1 &
python pbpb.py 86 102 10 20 2 &
python pbpb.py 86 103 20 30 3 &
wait 
python pbpb.py 86 104 0 10 0 &
python pbpb.py 86 105 0 80 1 &
python pbpb.py 86 106 10 30 2 &
python pbpb.py 86 107 30 50 3 &
wait 
echo "End time: $date"
