#!/bin/bash
#FLUX: --job-name=AlphaFold_GPU_example
#FLUX: --queue=gpu
#FLUX: -t=604800
#FLUX: --urgency=16

module purge
module load apptainer
 apptainer run -B /work/HCC/BCRF/app_specific/alphafold/2.3.2/:/data -B .:/etc \
     --pwd /app/alphafold docker://unlhcc/alphafold:2.3.2 \
     # --fasta_paths should be set to the absolute path to the input fasta file
     --fasta_paths=input.fasta \
     # --output_dir should be set to the absolute path to the output directory
     --output_dir=output_directory \
     --model_preset=multimer \
     --max_template_date=2023-10-10 \
     --data_dir=/data \
     --use_gpu_relax \
     --db_preset=reduced_dbs \
     --uniref90_database_path=/data/uniref90/uniref90.fasta \
     --mgnify_database_path=/data/mgnify/mgy_clusters_2022_05.fa \
     --template_mmcif_dir=/data/pdb_mmcif/mmcif_files \
     --obsolete_pdbs_path=/data/pdb_mmcif/obsolete.dat \
     --pdb_seqres_database_path=/data/pdb_seqres/pdb_seqres.txt \
     --uniprot_database_path=/data/uniprot/uniprot_sprot.fasta \
     --small_bfd_database_path=/data/small_bfd/bfd-first_non_consensus_sequences.fasta
