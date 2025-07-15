#!/bin/bash
#FLUX: --job-name=AlphaFold_GPU_example
#FLUX: --queue=gpu
#FLUX: -t=604800
#FLUX: --priority=16

module purge
module load apptainer
apptainer run -B /work/HCC/BCRF/app_specific/alphafold/2.0.0/:/data -B .:/etc \
    --pwd /app/alphafold docker://unlhcc/alphafold:2.0.0 \
    # --fasta_paths should be set to the absolute path to the input fasta file
    --fasta_paths=input.fasta \
    # --output_dir should be set to the absolute path to the output directory
    --output_dir=output_directory \
    --model_names=model_1,model_2,model_3,model_4,model_5 \
    --preset=casp14 \
    --max_template_date=2021-09-09 \
    --data_dir=/data \
    --uniref90_database_path=/data/uniref90/uniref90.fasta \
    --mgnify_database_path=/data/mgnify/mgy_clusters.fa \
    --uniclust30_database_path=/data/uniclust30/uniclust30_2018_08/uniclust30_2018_08 \
    --bfd_database_path=/data/bfd/bfd_metaclust_clu_complete_id30_c90_final_seq.sorted_opt \
    --pdb70_database_path=/data/pdb70/pdb70 \
    --template_mmcif_dir=/data/pdb_mmcif/mmcif_files \
    --obsolete_pdbs_path=/data/pdb_mmcif/obsolete.dat
