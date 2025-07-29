#!/bin/bash
#FLUX: --job-name=af-gpu-test
#FLUX: -c=16
#FLUX: --queue=gpu
#FLUX: -t=14400
#FLUX: --urgency=16

export TF_FORCE_UNIFIED_MEMORY='1'
export XLA_PYTHON_CLIENT_MEM_FRACTION='4.0'
export XLA_PYTHON_CLIENT_ALLOCATOR='platform'

module load cuda/11.3
source /software/python-anaconda-2020.11-el8-x86_64/etc/profile.d/conda.sh
conda activate alphafold-local
export TF_FORCE_UNIFIED_MEMORY='1'
export XLA_PYTHON_CLIENT_MEM_FRACTION='4.0'
export XLA_PYTHON_CLIENT_ALLOCATOR=platform
usage() {
        echo ""
        echo "Please make sure all required parameters are given"
        echo "Usage: $0 <OPTIONS>"
        echo "Required Parameters:"
        echo "-o <output_dir>       Path to a directory that will store the results."
        echo "-f <fasta_paths>      Path to FASTA files containing sequences. If a FASTA file contains multiple sequences, then it will be folded as a multimer. To fold more sequences one after another, write the files separated by a comma"
        echo "-t <max_template_date> Maximum template release date to consider (ISO-8601 format - i.e. YYYY-MM-DD). Important if folding historical test sets"
        echo ""
        exit 1
}
while getopts ":d:o:f:t:g:r:e:n:a:m:c:p:l:b:" i; do
        case "${i}" in
        d)
                data_dir=$OPTARG
        ;;
        o)
                output_dir=$(realpath $OPTARG)
        ;;
        f)
                fasta_path=$(realpath $OPTARG)
        ;;
        t)
                max_template_date=$OPTARG
        ;;
        esac
done
if [[ "$output_dir" == "" || "$fasta_path" == "" || "$max_template_date" == "" ]] ; then
    usage
fi
if [[ "$data_dir" == "" ]] ; then
    data_dir="/software/alphafold-data-2.3"
fi
if [[ "$model_preset" != "monomer" && "$model_preset" != "monomer_casp14" && "$model_preset" != "monomer_ptm" && "$model_preset" != "multimer" ]] ; then
    echo "Unknown model preset! Using default (' mutimer')"
    model_preset="multimer"
fi
DOWNLOAD_DATA_DIR=/software/alphafold-data-2.3
if [[ $model_preset == "multimer" ]]; then
    echo "RUNNING WITH MULTIMER"
	database_paths="--uniprot_database_path=$DOWNLOAD_DATA_DIR/uniprot/uniprot_sprot.fasta --pdb_seqres_database_path=$DOWNLOAD_DATA_DIR/pdb_seqres/pdb_seqres.txt"
else
	database_paths="--pdb70_database_path=$DOWNLOAD_DATA_DIR/pdb70/pdb70"
fi
echo "Running Alphafold with arguments: $command_args"
cd ~/alphafold-2.3.2
python run_alphafold.py  \
  --data_dir=$DOWNLOAD_DATA_DIR  \
  $database_paths \
  --uniref90_database_path=$DOWNLOAD_DATA_DIR/uniref90/uniref90.fasta  \
  --mgnify_database_path=$DOWNLOAD_DATA_DIR/mgnify/mgy_clusters_2022_05.fa  \
  --bfd_database_path=$DOWNLOAD_DATA_DIR/bfd/bfd_metaclust_clu_complete_id30_c90_final_seq.sorted_opt  \
  --uniref30_database_path=$DOWNLOAD_DATA_DIR/uniref30/UniRef30_2021_03 \
  --template_mmcif_dir=$DOWNLOAD_DATA_DIR/pdb_mmcif/mmcif_files  \
  --obsolete_pdbs_path=$DOWNLOAD_DATA_DIR/pdb_mmcif/obsolete.dat \
  --model_preset=$model_preset \
  --max_template_date=$max_template_date \
  --db_preset=full_dbs \
  --use_gpu_relax=true \
  --models_to_relax=all \
  --output_dir=$output_dir \
  --fasta_paths=$fasta_path
