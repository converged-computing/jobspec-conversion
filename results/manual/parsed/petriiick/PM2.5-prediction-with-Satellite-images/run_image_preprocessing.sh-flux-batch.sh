#!/bin/bash
#FLUX: --job-name=img_prep
#FLUX: --urgency=15

srun singularity exec --nv --bind /work/ld243 /datacommons/carlsonlab/Containers/multimodal_gp.simg python Image_Preprocessing_1.py
