#!/bin/bash
#SBATCH --job-name=3dscene
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=5500
#SBATCH --time=6-23:59:00
#SBATCH --constraint=ntasks-per-node=1

exec 2>&1      # send errors into stdout stream
echo "DEBUG: host=$(hostname) pwd=$(pwd) ulimit=$(ulimit -v) \$1=$1 \$2=$2"
scontrol show Job $SLURM_JOBID  # show slurm-command and more for DBG
programROOT=/nfs1/kprabhu/3dReconstruction1
pythonMain=executor.py
echo $programROOT
echo $pythonMain
if [ $# -gt 0 ]; then
    if [ $# == 1 ]; then
        pythonMain=$1
    fi
    if [ $# == 2 ]; then
        pythonMain=$1
        programROOT=/nfs1/kprabhu/3dReconstruction1/$2
    fi
fi
pyFullPath=$programROOT/$pythonMain
source /nfs1/kprabhu/anaconda3/etc/profile.d/conda.sh
conda activate 3dscene
srun python $pyFullPath
