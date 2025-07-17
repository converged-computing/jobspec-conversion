#!/bin/bash
#FLUX: --job-name=list_topic
#FLUX: -c=2
#FLUX: --queue=cascade
#FLUX: -t=36000
#FLUX: --urgency=16

module load foss/2022a
module load GCCcore/11.3.0; module load Python/3.10.4
module load  cuDNN/8.4.1.50-CUDA-11.7.0
module load TensorFlow/2.11.0-CUDA-11.7.0
source  ~/venvs/nlp_gpu/bin/activate
python3 news_create_list_of_topics.py ${SLURM_ARRAY_TASK_ID}
