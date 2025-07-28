#!/bin/bash
#FLUX: --job-name=alBERTo_met
#FLUX: -c=8
#FLUX: --queue=all_usr_prod
#FLUX: -t=86400
#FLUX: --urgency=16

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
