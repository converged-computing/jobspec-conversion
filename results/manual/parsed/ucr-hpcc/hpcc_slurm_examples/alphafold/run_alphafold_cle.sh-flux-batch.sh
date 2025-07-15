#!/bin/bash
#FLUX: --job-name=eccentric-peas-6034
#FLUX: -n=24
#FLUX: -t=86400
#FLUX: --urgency=16

export SINGULARITY_BIND='${SCRATCH}:/tmp'

data_dir=/srv/projects/db/alphafold 
DOWNLOAD_DIR=$data_dir
output_dir="${PWD}/CLENT_006666_model"
model_names=model_1 
fasta_path="${PWD}/query.fasta"
max_template_date=2020-08-12 
use_gpu=true 
openmm_threads=24 
gpu_devices=0 
preset=full_dbs
benchmark=false 
bfd_database_path=$data_dir/bfd/bfd_metaclust_clu_complete_id30_c90_final_seq.sorted_opt
small_bfd_database_path=$data_dir/small_bfd/bfd-first_non_consensus_sequences.fasta
mgnify_database_path=$data_dir/mgnify/mgy_clusters_2018_12.fa
template_mmcif_dir=$data_dir/pdb_mmcif/mmcif_files/
obsolete_pdbs_path=$data_dir/pdb_mmcif/obsolete.dat
pdb70_database_path=$data_dir/pdb70/pdb70
uniclust30_database_path=$data_dir/uniclust30/uniclust30_2018_08/uniclust30_2018_08
uniref90_database_path=$data_dir/uniref90/uniref90.fasta
module load alphafold/2.1.2
module load workspace/scratch
export SINGULARITY_BIND="${SCRATCH}:/tmp"
singularity run --bind ${data_dir} --nv $ALPHAFOLD_SING \
    --bfd_database_path=$bfd_database_path \
    --mgnify_database_path=$mgnify_database_path \
    --template_mmcif_dir=$template_mmcif_dir \
    --obsolete_pdbs_path=$obsolete_pdbs_path \
    --pdb70_database_path=$pdb70_database_path \
    --uniclust30_database_path=$uniclust30_database_path \
    --uniref90_database_path=$uniref90_database_path \
    --data_dir=$data_dir \
    --output_dir=$output_dir \
    --fasta_paths=$fasta_path \
    --model_names=$model_names \
    --max_template_date=$max_template_date \
    --preset=$preset \
    --benchmark=$benchmark \
    --logtostderr
