#!/bin/bash
#SBATCH --job-name=jupyter-notebook
#SBATCH --output=jupyter-log-%j.txt
#SBATCH --error=jupyter-log-%j.txt
#SBATCH --mail-user=xxx.yyy@isae.fr
#SBATCH --mail-type=FAIL,END
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=16

export XDG_RUNTIME_DIR=''

module load python/3.7
source activate dask
ipnport=$(shuf -i8000-9999 -n1)
ipnip=$(hostname -i)
cd $SLURM_SUBMIT_DIR
echo  "
    Copy/Paste this in your local terminal to ssh tunnel with remote
    -----------------------------------------------------------------
    ssh -N -L $ipnport:$ipnip:$ipnport $USER@rainman
    -----------------------------------------------------------------
    Then open a browser on your local machine to the following address
    ------------------------------------------------------------------
    localhost:$ipnport  (prefix w/ https:// if using password)
    ------------------------------------------------------------------
    "
export XDG_RUNTIME_DIR=""
jupyter-notebook --no-browser --port=$ipnport --ip=$ipnip
