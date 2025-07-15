#!/bin/bash
#FLUX: --job-name=muffled-train-9943
#FLUX: --priority=16

AF_PATH=/fsx/alphafold2/alphafold/
DB_PATH=/fsx/alphafold2/database/
OUTPUT_PATH=/fsx/alphafold2/job/${SLURM_JOB_ID}/output/
INPUT_PATH=/fsx/alphafold2/job/input/
INPUT_PATH_COPIED=/fsx/alphafold2/job/${SLURM_JOB_ID}/input/
INPUT_FILE_NO_EXTENSION=$(echo $1 | sed -e s/\.fasta//)
TEMPLATE_DATE=$(date '+%Y-%m-%d')
mkdir -p $OUTPUT_PATH
mkdir -p $INPUT_PATH_COPIED
sudo cp ${INPUT_PATH}$1 ${INPUT_PATH_COPIED}
python3 --version # make sure the version matches the pip version
pip3 install -r ${AF_PATH}docker/requirements.txt --user
sudo docker build -f ${AF_PATH}docker/Dockerfile -t alphafold ${AF_PATH}
python3 ${AF_PATH}docker/run_docker.py \
        --fasta_paths=${INPUT_PATH}$1 \
        --max_template_date=$TEMPLATE_DATE \
        --data_dir=$DB_PATH \
        --output_dir=$OUTPUT_PATH \
        --docker_user=0
sudo mv ${OUTPUT_PATH}${INPUT_FILE_NO_EXTENSION}/* ${OUTPUT_PATH}
