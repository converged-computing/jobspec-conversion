#!/bin/bash
#FLUX: --job-name=eprior
#FLUX: -c=8
#FLUX: -t=43200
#FLUX: --urgency=16

module purge
module load Miniconda3/22.11.1-1
source ${EBROOTMINICONDA3}/etc/profile.d/conda.sh
conda deactivate &>/dev/null
conda init bash
conda activate /projects/ec12/jinyueg/conda/envs/eprior
cd /projects/ec12/jinyueg/eprior-RAVE/eprior/scripts
python run.py --config_path ../eprior/configs/VCTK_novelty.gin
