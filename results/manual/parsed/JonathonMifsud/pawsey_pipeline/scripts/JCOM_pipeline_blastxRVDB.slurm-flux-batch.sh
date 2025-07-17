#!/bin/bash
#FLUX: --job-name=blastx_RVDB_array
#FLUX: --queue=work
#FLUX: --urgency=16

export library_run='${myarray["$SLURM_ARRAY_TASK_ID"]}'

module load singularity/3.11.4
function BlastxRVDB {
    singularity exec "$singularity_image" diamond blastx -q "$inpath"/"$library_id".contigs.fa -d "$db" -t "$tempdir" -o "$outpath"/"$library_id"_RVDB_blastx_results.txt -e 1E-10 -c1 -k 5 -b "$MEM" -p "$CPU" -f 6 qseqid qlen sseqid stitle pident length evalue --ultra-sensitive
}
function blastToFasta {
    grep -i ".*" "$outpath"/"$library_id"_RVDB_blastx_results.txt | cut -f1 | sort | uniq > "$outpath"/"$library_id""_temp_contig_names.txt" #by defult this will grab the contig name from every blast result line as I commonly use a custom protein database containing only viruses
	grep -A1 -I -Ff "$outpath"/"$library_id""_temp_contig_names.txt" "$inpath"/"$library_id".contigs.fa > "$outpath"/"$library_id"_RVDB_blastcontigs.fasta
    sed -i 's/--//' "$outpath"/"$library_id"_RVDB_blastcontigs.fasta # remove -- from the contigs
    sed -i '/^[[:space:]]*$/d' "$outpath"/"$library_id"_RVDB_blastcontigs.fasta # remove the white space
    sed --posix -i "/^\>/ s/$/"_$library_id"/" "$outpath"/"$library_id"_RVDB_blastcontigs.fasta # annotate the contigs
    rm "$outpath"/"$library_id""_temp_contig_names.txt"
}
readarray -t myarray < "$file_of_accessions"
export library_run=${myarray["$SLURM_ARRAY_TASK_ID"]}
library_run_without_path="$(basename -- $library_run)"
library_id=$(echo $library_run_without_path | sed 's/\.contigs.fa//g')
wd=/scratch/director2187/$user/"$root_project"/"$project"/blast_results
inpath=/scratch/director2187/$user/"$root_project"/"$project"/contigs/final_contigs   # location of reads and filenames
outpath=/scratch/director2187/$user/"$root_project"/"$project"/blast_results        # location of megahit output
tempdir=/scratch/director2187/$user/"$root_project"/
CPU=12
MEM=1       
cd "$wd" || exit
BlastxRVDB
blastToFasta
