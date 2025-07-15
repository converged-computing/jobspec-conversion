#!/bin/bash
#FLUX: --job-name=prepare_data
#FLUX: --queue=m40-long # Partition to submit to
#FLUX: --priority=16

python -u copy_model/prepare_context.py original10.annoy original_bert.pkl train_embeddings10.pkl train_embeddings10.pkl train10.pkl scibert 4
exit
