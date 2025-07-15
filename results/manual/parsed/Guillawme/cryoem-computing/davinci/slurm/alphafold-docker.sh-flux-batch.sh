#!/bin/bash
#FLUX: --job-name=alphafold
#FLUX: -c=16
#FLUX: --queue=cryoem
#FLUX: --priority=16

source $HOME/opt/slurm/slurm-start.sh
FASTA=lysozyme.fasta
MODEL=monomer # options are: monomer, monomer_casp14, monomer_ptm, multimer
MAX_TEMPLATE_DATE=2024-01-01
DB_PRESET=reduced_dbs # options are: reduced_dbs, full_dbs
RELAX_PREDICTED_MODEL=best # options are: best, all, none
RELAX_ON_GPU=true # default is true, faster but possibly less numerically stable than relaxing on CPU (set to false for this)
DATA_DIR=/scratch/burst/alphafold_data_2.3.1 # where the databases have been downloaded (installation-specific)
OUTPUT_DIR=run-01
module purge
module load AlphaFold/2.3.2
srun python3 /scratch/burst/alphafold-2.3.2/docker/run_docker.py \
	--fasta_paths=$FASTA \
	--max_template_date=$MAX_TEMPLATE_DATE \
	--model_preset=$MODEL \
	--db_preset=$DB_PRESET \
	--data_dir=$DATA_DIR \
	--output_dir=$OUTPUT_DIR \
	--models_to_relax=$RELAX_PREDICTED_MODEL \
	--enable_gpu_relax=$RELAX_ON_GPU
source $HOME/opt/slurm/slurm-completion.sh
