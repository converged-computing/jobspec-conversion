#!/bin/bash
#FLUX: --job-name=1_MSA
#FLUX: -c=36
#FLUX: -t=21600
#FLUX: --urgency=16

export LD_LIBRARY_PATH='${ALPHAFOLD_HOME}/lib:${LD_LIBRARY_PATH}'
export TMPDIR='${JOB_SHMTMPDIR}'
export TF_FORCE_UNIFIED_MEMORY='1'
export XLA_PYTHON_CLIENT_MEM_FRACTION='4'
export NUM_THREADS='${SLURM_CPUS_PER_TASK}'
export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'

set -e
module purge
module load alphafold/2.3.1
module load cuda/11.4
source 01_user_parameters.inc
if [ ! -d ${ALPHAFOLD_DATA} ]; then
  echo "Could not find ${ALPHAFOLD_DATA}. STOP."
  exit 1
fi
mkdir -p ${OUTPUT_DIR}
export LD_LIBRARY_PATH=${ALPHAFOLD_HOME}/lib:${LD_LIBRARY_PATH}
export TMPDIR=${JOB_SHMTMPDIR}
export TF_FORCE_UNIFIED_MEMORY=1
        # Enable jax allocation tweak to allow for larger models, note that
        # with unified memory the fraction can be larger than 1.0 (=100% of single GPU memory):
        # https://jax.readthedocs.io/en/latest/gpu_memory_allocation.html
        # When using 3 GPUs:
export XLA_PYTHON_CLIENT_MEM_FRACTION=4
export NUM_THREADS=${SLURM_CPUS_PER_TASK}
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
DOWNLOAD_DIR=${ALPHAFOLD_DATA}
uniref90_database_path=${DOWNLOAD_DIR}/uniref90/uniref90.fasta
mgnify_database_path=/raven/ri/public_sequence_data/alphafold2/git-v2.3.1/data/mgnify/mgy_clusters_2022_05.fa
uniprot_database_path=${DOWNLOAD_DIR}/uniprot/uniprot.fasta
bfd_database_path=${DOWNLOAD_DIR}/bfd/bfd_metaclust_clu_complete_id30_c90_final_seq.sorted_opt
small_bfd_database_path=${DOWNLOAD_DIR}/small_bfd/bfd-first_non_consensus_sequences.fasta
pdb_seqres_database_path=${DOWNLOAD_DIR}/pdb_seqres/pdb_seqres.txt
uniclust30_database_path=${DOWNLOAD_DIR}/uniclust30/uniclust30_2018_08/uniclust30_2018_08
pdb70_database_path=${DOWNLOAD_DIR}/pdb70/pdb70
template_mmcif_dir=${DOWNLOAD_DIR}/pdb_mmcif/mmcif_files
obsolete_pdbs_path=${DOWNLOAD_DIR}/pdb_mmcif/obsolete.dat
srun ${ALPHAFOLD_HOME}/bin/python3 -u $AF_DIR/run_af2c_fea.py \
        --output_dir="${OUTPUT_DIR}" \
        --fasta_paths="${FASTA_PATHS}" \
        --db_preset="${PRESET}" \
        --data_dir=${DOWNLOAD_DIR} \
	--small_bfd_database_path=${small_bfd_database_path} \
        --uniref90_database_path=${uniref90_database_path} \
        --mgnify_database_path=${mgnify_database_path} \
        --pdb70_database_path=${pdb70_database_path} \
        --template_mmcif_dir=${template_mmcif_dir} \
        --obsolete_pdbs_path=${obsolete_pdbs_path} \
        --max_template_date="2023-01-01"
