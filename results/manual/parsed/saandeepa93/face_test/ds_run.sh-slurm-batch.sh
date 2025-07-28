#!/bin/bash
#FLUX: --job-name=webds_writer
#FLUX: -c=16
#FLUX: --queue=rra_con2020
#FLUX: -t=259200
#FLUX: --urgency=16

module load apps/anaconda
source /apps/anaconda3/5.3.1/etc/profile.d/conda.sh
conda activate torch_faces
srun python ./trainer/filter_tars.py --config briar_8
