#!/bin/bash
#FLUX: --job-name=HP RAG
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=7200
#FLUX: --urgency=16

srun singularity exec --nv containers/container-rag.sif python src/hp_rag.py
