#!/bin/bash
#FLUX: --job-name=bumfuzzled-despacito-6619
#FLUX: --urgency=16

my_fasta=5ZE6_1.fasta
my_output_dir=output
mkdir -p $my_output_dir
my_model_type=monomer
my_max_date="2100-01-01"
singularity run --nv --env TF_FORCE_UNIFIED_MEMORY=1,XLA_PYTHON_CLIENT_MEM_FRACTION=4.0,OPENMM_CPU_THREADS=$SLURM_CPUS_PER_TASK,LD_LIBRARY_PATH=/usr/local/cuda-11.1/targets/x86_64-linux/lib/ --bind /n/holylfs04-ssd2/LABS/FAS/alphafold_database:/data /n/singularity_images/FAS/alphafold/alphafold_2.3.1.sif \
--data_dir=/data/ \
--bfd_database_path=/data/bfd/bfd_metaclust_clu_complete_id30_c90_final_seq.sorted_opt \
--db_preset=full_dbs \
--fasta_paths=$my_fasta \
--max_template_date=$my_max_date \
--mgnify_database_path=/data/mgnify/mgy_clusters_2022_05.fa \
--model_preset=$my_model_type \
--obsolete_pdbs_path=/data/pdb_mmcif/obsolete.dat \
--output_dir=$my_output_dir \
--pdb70_database_path=/data/pdb70/pdb70 \
--template_mmcif_dir=/data/pdb_mmcif/mmcif_files \
--uniref30_database_path=/data/uniref30/UniRef30_2021_03 \
--uniref90_database_path=/data/uniref90/uniref90.fasta \
--use_gpu_relax=True
