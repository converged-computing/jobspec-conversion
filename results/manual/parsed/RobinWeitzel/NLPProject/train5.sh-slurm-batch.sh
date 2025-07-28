#!/bin/bash
#FLUX: --job-name=train5_job
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

module load python/3.6.3
module load gcc-7.1.0
python -m allennlp.run train training_config/bidaf_elmo_embedding.jsonnet -s output_elmo_embedding -f
