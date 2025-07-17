#!/bin/bash
#FLUX: --job-name=train4_job
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

module load python/3.6.3
module load gcc-7.1.0
python -m allennlp.run train training_config/bidaf_elmo_dropout.jsonnet -s output_elmo_dropout -f
