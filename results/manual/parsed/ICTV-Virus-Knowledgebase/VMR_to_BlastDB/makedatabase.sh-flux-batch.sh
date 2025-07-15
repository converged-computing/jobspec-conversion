#!/bin/bash
#FLUX: --job-name=ICTV_VMR_makeblastdb_e
#FLUX: --queue=amd-hdr100
#FLUX: -t=43200
#FLUX: --urgency=16

ACCESSION_TSV=processed_accessions_e.tsv
ALL_FASTA=./fasta_new_vmr/vmr_e.fa
SRC_DIR=$(dirname $ALL_FASTA)
echo "# concatenate individual fasta's into all.fa"
if [[ ! -e "$ALL_FASTA" || "$(find $SRC_DIR -newer $ALL_FASTA|wc -l)" -gt 0 ]]; then
    echo "REBUILD $ALL_FASTA"
    rm $ALL_FASTA
    for FA in $(awk 'BEGIN{FS="\t";GENUS=5;ACC=3}(NR>1){print $GENUS"/"$ACC".raw"}' $ACCESSION_TSV); do
	echo "cat $SRC_DIR/$FA >> $ALL_FASTA"
	cat $SRC_DIR/$FA >> $ALL_FASTA
	wc -l $ALL_FASTA
    done
else
    echo "SKIP: $ALL_FASTA is up-to-date."
fi
echo "# Make the BLAST database"
if [ "$(which makeblastdb 2>/dev/null)" == "" ]; then 
    echo "module load BLAST"
    module load BLAST
fi
echo 'makeblastdb -in $ALL_FASTA -input_type "fasta" -title "ICTV VMR refseqs" -out "./blast/ICTV_VMR_e" -dbtype "nucl"'
makeblastdb -in $ALL_FASTA -input_type "fasta" -title "ICTV VMR refseqs" -out "./blast/ICTV_VMR_e" -dbtype "nucl"
echo "# Example usage:"
echo "# blastn -db ./blast/ICTV_VMR_e -query ./fasta_new_vmr/Eponavirus/MG711462.fa -out ./results/e/Eponavirus/MG711462.csv  -outfmt '7 delim=,'"
