#!/bin/bash
#FLUX: --job-name=alphafold2
#FLUX: --queue=caslake
#FLUX: -t=1800
#FLUX: --priority=16

module load alphafold/2.2.0 cuda/11.3
conda activate alphafold-2.3
usage() {
        echo ""
        echo "Please make sure all required parameters are given"
        echo "Usage: $0 <OPTIONS>"
        echo "Required Parameters:"
        echo "-o <output_dir>       Path to a directory that will store the results."
        echo "-f <fasta_paths>      Path to FASTA files containing sequences. If a FASTA file contains multiple sequences, then it will be folded as a multimer. To fold more sequences one after another, write the files separated by a comma"
        echo ""
        exit 1
}
while getopts ":d:o:f:t:g:r:e:n:a:m:c:p:l:b:" i; do
        case "${i}" in
        o)
                output_dir=$(realpath $OPTARG)
        ;;
        f)
                fasta_path=$(realpath $OPTARG)
        ;;
        t)
        ;;
        esac
done
if [[ "$output_dir" == "" || "$fasta_path" == ""  ]] ; then
    usage
fi
ALPHAFOLD_DIR=~/alphafold-2.3.1
ALPHAFOLD_EXE=$ALPHAFOLD_DIR/run_alphafold.sh
data_dir=/scratch/midway3/gideonm/alphafold-database/
echo "Alphafold executable: $ALPHAFOLD_EXE"
echo "Data directory: $data_dir"
echo "Output directory: $output_dir"
echo "Fasta files: $fasta_path"
cd $ALPHAFOLD_DIR
$ALPHAFOLD_EXE \
        -f $fasta_path \
        -t 2020-05-14 \
        -m monomer \
        -g true \
        -c reduced_dbs \
        -d $data_dir \
        -o $output_dir
