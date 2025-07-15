#!/bin/bash
#FLUX: --job-name=mriqc
#FLUX: -N=2
#FLUX: -c=2
#FLUX: -t=28800
#FLUX: --priority=16

PROJECT_PATH=/imaging/correia/da05/workshops/2023-09-COGNESTIC/demo/FaceRecognition
SUBJECT_DIRS=("$PROJECT_PATH"/data/bids/sub-*)
SUBJECT_LIST=("${SUBJECT_DIRS[@]##*/}") 
subject=${SUBJECT_LIST[${SLURM_ARRAY_TASK_ID} - 1]}
singularity run --cleanenv -B "$PROJECT_PATH":/"$PROJECT_PATH" \
    /imaging/local/software/singularity_images/mriqc/mriqc-22.0.1.simg \
    "$PROJECT_PATH"/data/bids \
    "$PROJECT_PATH"/data/bids/derivatives/mriqc/ \
    --work-dir "$PROJECT_PATH"/data/work/mriqc/"$subject" \
    participant \
    --participant-label "${subject#sub-}" \
    --float32 \
    --n_procs 16 --mem_gb 24 --ants-nthreads 16 \
    --modalities T1w bold \
    --no-sub
