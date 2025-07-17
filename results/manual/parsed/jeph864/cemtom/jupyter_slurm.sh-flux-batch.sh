#!/bin/bash
#FLUX: --job-name=topics_nb
#FLUX: -c=16
#FLUX: --queue=informatik-mind
#FLUX: -t=14400
#FLUX: --urgency=16

export TOKENIZERS_PARALLELISM='true'

module purge
module add nvidia
module load anaconda3/latest
. $ANACONDA_HOME/etc/profile.d/conda.sh
echo "activating the cemtom env"
conda activate cemtom
conda info
pip list
PROJECT="/scratch/$USER/thesis/tms/atlas"
cd $PROJECT
export TOKENIZERS_PARALLELISM=true
module list
nvidia-smi
node=$(hostname -s)
jupyter-notebook --no-browser  --ip=${node}
