#!/bin/bash
#FLUX: --job-name=chunky-animal-8621
#FLUX: --queue=general,zhanglab
#FLUX: -t=3600
#FLUX: --urgency=16

module load python3/3.4.1
module load CAMISIM/1.1.0-foss-2016b-Python-2.7.12
if [ "$#" -ne 3 ]; then
    echo "Usage: ./createFiles.sh [Folder Name] [Genome ID File] [Coverage]"
    exit 2
fi
FOLDER=$1
GENOMEFILE=$2
COVERAGE=$3
Path="/data/zhanglab/esameth/"
INI="default_config.ini"
Genomes="/data/zhanglab/cecile_cres/RefSeq-03-07-2020/RefSeq-03-07-2020"
if [ ! -f "$GENOMEFILE" ]; then
    echo "$GENOMEFILE does not exist"
    exit 2
fi
function createFolder {
    if [ ! -d "$1" ]; then
        mkdir "$1"
    fi
}
function genomeSize {
    size_gbp=$(python3 genomeSize.py "$FILE" "$Path$FOLDER/$SPECIES" "$COVERAGE")
    echo "Genome size: $size_gbp"
}
function CAMISIMfiles {
    ID=$(grep "$SPECIES" "/data/zhanglab/cecile_cres/RefSeq-03-07-2020/assembly_summary.txt" | awk -F'\t' '{print $6}')
    echo "genome_ID OTU novelty_category    NCBI_ID source" > "$Path$FOLDER/$SPECIES"/metadata.tsv
    echo "$SPECIES  0   known strain    $ID " >> "$Path$FOLDER/$SPECIES"/metadata.tsv
    echo "$SPECIES  "$Path$FOLDER/$SPECIES"/genomeWOplasmids.fna" > "$Path$FOLDER/$SPECIES"/genome_to_id.tsv
    cp $Path$INI $Path$FOLDER/$SPECIES/$INI
    # Replace the output_directory, metadata, and id_to_genome_file paths to the correct path, and update gbp
    sed -i "/^output_directory=/ c\output_directory="$Path$FOLDER/$SPECIES/"output" $Path$FOLDER/$SPECIES/$INI
    sed -i "/^metadata=/ c\metadata="$Path$FOLDER/$SPECIES/"metadata.tsv" $Path$FOLDER/$SPECIES/$INI
    sed -i "/^id_to_genome_file=/ c\id_to_genome_file="$Path$FOLDER/$SPECIES/"genome_to_id.tsv" $Path$FOLDER/$SPECIES/$INI
    sed -i "/^size=/ c\size="$size_gbp"" $Path$FOLDER/$SPECIES/$INI
}
function unzip {
    file=$(find $Path$FOLDER/$SPECIES -name "anonymous_reads.fq.gz")
    gzip -d $file
}
function speciesTsv {
    name=$(grep "$SPECIES" "/data/zhanglab/cecile_cres/RefSeq-03-07-2020/assembly_summary.txt" | cut -f8)
    echo "$name	1	$SPECIES	$size_gbp	Complete" >> "$Path$FOLDER"/Species.tsv
}
createFolder $FOLDER
while IFS= read -r line; do
    # Get the species name and create a folder for it
    SPECIES=$line
    echo "$SPECIES"
    createFolder $Path$FOLDER/$SPECIES
    # Get the name of the fna file for the species
    FILE=$(find $Genomes -name "$SPECIES"*.fna)
    echo "$FILE"
    genomeSize
    speciesTsv
    # Run CAMISIM
    CAMISIMfiles
    /opt/software/CAMISIM/1.1.0-foss-2016b-Python-2.7.12/bin/metagenomesimulation.py $Path$FOLDER/$SPECIES/$INI
    unzip
done < $GENOMEFILE
