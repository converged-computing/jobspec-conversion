#!/bin/bash
#FLUX: --job-name=parrot
#FLUX: -c=8
#FLUX: -t=21600
#FLUX: --urgency=16

echo "hostname:" `hostname`
echo "file: " $FILE
singularity exec --nv --overlay ~/labshare/Parrot_Paraphraser/overlay-50G-10M.ext3:ro /scratch/work/public/singularity/cuda11.6.124-cudnn8.4.0.27-devel-ubuntu20.04.4.sif  /bin/bash -c "
source /ext3/env.sh
conda activate parrot
python parrot/paraphrase.py $FILE
"
