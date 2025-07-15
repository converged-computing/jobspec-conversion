#!/bin/bash
#FLUX: --job-name=eddy_segmenter
#FLUX: -n=4
#FLUX: --queue=main
#FLUX: -t=604800
#FLUX: --priority=16

INPUT_FILE=""
source /etc/profile.d/lmod.sh
nvidia-smi
pwd
eval "$(conda shell.bash hook)"
conda activate emirdlp
echo ""
echo "======================================================================================"
env
echo "======================================================================================"
echo ""
echo "======================================================================================"
echo "Setting stack size to unlimited..."
ulimit -s unlimited
ulimit -l unlimited
ulimit -a
echo
echo "Running Example Job...!"
echo "==============================================================================="
echo "Running Python script..."
python main.py
