#!/bin/bash
#SBATCH --job-name=alBERTo_met
#SBATCH --account=ai4bio2023
#SBATCH --output=slurm-%j.out
#SBATCH --error=slurm-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=50G
#SBATCH --time=1-00:00:00
#SBATCH --constraint=gpu_P100_16G|gpu_RTX6000_24G|gpu_RTX5000_16G|gpu_A40_48G|gpu_RTXA5000_24G

export PYTHONPATH='/usr/local/anaconda3/bin/python' # Modifica percorso Python se necessario'

__conda_setup="$('/usr/local/anaconda3' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup" # Esegue il comando restituito da conda init
else # Se conda non è installato, modifica il PATH con il percorso di Anaconda
    if [ -f "/usr/local/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/usr/local/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/usr/local/anaconda3/bin/:$PATH"
    fi 
fi
unset __conda_setup
conda activate AIE
export PYTHONPATH='/usr/local/anaconda3/bin/python' # Modifica percorso Python se necessario
python train.py
