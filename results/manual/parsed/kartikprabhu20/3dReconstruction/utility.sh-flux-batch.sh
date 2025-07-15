#!/bin/bash
#FLUX: --job-name=faux-cat-3667
#FLUX: -c=10
#FLUX: -t=604740
#FLUX: --urgency=16

exec 2>&1      # send errors into stdout stream
echo "DEBUG: host=$(hostname) pwd=$(pwd) ulimit=$(ulimit -v) \$1=$1 \$2=$2"
scontrol show Job $SLURM_JOBID  # show slurm-command and more for DBG
programROOT=/nfs1/kprabhu/3dReconstruction2
pythonMain=utility.py
echo $programROOT
echo $pythonMain
if [ $# -gt 0 ]; then
    if [ $# == 1 ]; then
        pythonMain=$1
    fi
    if [ $# == 2 ]; then
        pythonMain=$1
        programROOT=/nfs1/kprabhu/3dReconstruction/$2
    fi
fi
pyFullPath=$programROOT/$pythonMain
source /nfs1/kprabhu/anaconda3/etc/profile.d/conda.sh
conda activate 3dscene
srun python $pyFullPath
