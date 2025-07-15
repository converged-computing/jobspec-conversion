#!/bin/bash
#FLUX: --job-name="nlp-project"
#FLUX: --queue=gpu
#FLUX: -t=43200
#FLUX: --priority=16

singularity exec --nv docker://pytorch/pytorch:1.13.1-cuda11.6-cudnn8-runtime pip install tensorboard
singularity exec --nv docker://pytorch/pytorch:1.13.1-cuda11.6-cudnn8-runtime pip install -U scikit-learn
singularity exec --nv docker://pytorch/pytorch:1.13.1-cuda11.6-cudnn8-runtime pip install datasets
singularity exec --nv docker://pytorch/pytorch:1.13.1-cuda11.6-cudnn8-runtime pip install transformers
singularity exec --nv docker://pytorch/pytorch:1.13.1-cuda11.6-cudnn8-runtime pip install matplotlib
singularity exec --nv docker://pytorch/pytorch:1.13.1-cuda11.6-cudnn8-runtime pip install pandas
singularity exec --nv docker://pytorch/pytorch:1.13.1-cuda11.6-cudnn8-runtime pip install spacy
singularity exec --nv docker://pytorch/pytorch:1.13.1-cuda11.6-cudnn8-runtime pip install nltk
singularity exec --nv docker://pytorch/pytorch:1.13.1-cuda11.6-cudnn8-runtime pip install ftfy regex tqdm 
singularity exec --nv docker://pytorch/pytorch:1.13.1-cuda11.6-cudnn8-runtime python3 project_split_rows_with_pp.py
