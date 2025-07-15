#!/bin/bash
#FLUX: --job-name=hello-banana-0077
#FLUX: --priority=16

export MINICONDA_DIR='/home/"$USER"/miniconda3'
export PROJ_DIR='/home/"$USER"/alphafold_non_docker'
export DATA_DIR='/home/"$USER"/alphafold_databases'
export OUTPUT_DIR='/home/"$USER"/alphafold_outputs'
export MAX_TEMPLATE_DATE='2020-05-14'
export USE_GPU='false'
export REMOVE_MSAS_AFTER_USE='true'

export MINICONDA_DIR=/home/"$USER"/miniconda3
export PROJ_DIR=/home/"$USER"/alphafold_non_docker
export DATA_DIR=/home/"$USER"/alphafold_databases
export OUTPUT_DIR=/home/"$USER"/alphafold_outputs
source "$MINICONDA_DIR"/bin/activate
conda activate alphafold_non_docker
export MAX_TEMPLATE_DATE=2020-05-14
export USE_GPU=false
export REMOVE_MSAS_AFTER_USE=true
for f in *.fasta;
  do srun -n1 -N1 -c32 --cpu-bind=cores --exclusive bash "$PROJ_DIR"/run_alphafold.sh -d "$DATA_DIR" -o "$OUTPUT_DIR" -f "$f" -t "$MAX_TEMPLATE_DATE" -g "$USE_GPU" -r "$REMOVE_MSAS_AFTER_USE" &
done;
wait
