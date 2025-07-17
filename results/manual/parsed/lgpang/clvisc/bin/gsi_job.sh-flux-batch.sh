#!/bin/bash
#FLUX: --job-name=clvisc
#FLUX: -n=4
#FLUX: --queue=lcsc
#FLUX: -t=172800
#FLUX: --urgency=16

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
