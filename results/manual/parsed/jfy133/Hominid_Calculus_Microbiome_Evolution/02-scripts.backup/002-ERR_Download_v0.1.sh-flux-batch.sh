#!/bin/bash
#FLUX: --job-name=fuzzy-lentil-1535
#FLUX: --urgency=16

FILE="$(readlink -f $1)"
OUTDIR="$(readlink -f $2)"
CORES="$3"
download_err () {
	local DIR="$1"
	local LINE="$2"
	mkdir "$DIR"/$("echo $LINE")
	if [[ "$(echo "$LINE" | wc -m)" == 9 ]]; then
		wget -P "$DIR"/"$LINE"/ ftp://ftp.sra.ebi.ac.uk/vol1/fastq/"$(echo $LINE | cut -c1-6)"/"$LINE"/"$LINE"*.fastq.gz
	elif [[ "$(echo "$LINE" | wc -m)" == 10 ]]; then
		wget -P "$DIR"/"$LINE"/ ftp://ftp.sra.ebi.ac.uk/vol1/fastq/"$(echo $LINE | cut -c1-6)"/00"$(echo $LINE | cut -c1-6 | rev | cut -c1 |rev)"/"$LINE"/"$LINE"*.fastq.gz
	elif [[ "$(echo "$LINE" | wc -m)" == 11 ]]; then
		wget -P "$DIR"/"$LINE"/ ftp://ftp.sra.ebi.ac.uk/vol1/fastq/"$(echo $LINE | cut -c1-6)"/0"$(echo $LINE | cut -c1-6 | rev | cut -c1-2 |rev)"/"$LINE"/"$LINE"*.fastq.gz
	elif [[ "$(echo "$LINE" | wc -m)" == 12 ]]; then
		wget -P "$DIR"/"$LINE"/ ftp://ftp.sra.ebi.ac.uk/vol1/fastq/"$(echo $LINE | cut -c1-6)"/"$(echo $LINE | cut -c1-6 | rev | cut -c1-3 |rev)"/"$LINE"/"$LINE"*.fastq.gz
	else
		printf "\n $SAMPLE is not compatible with this script \n"
	fi
}
export -f download_err
if [[ "$#" -ne 3 ]]; then
	echo "Usage: SRR_ERR_download_script.sh <file_of_S/ERR codes>.txt /<out>/<dir> <no. avail cores>"
else 
	cat "$FILE" | parallel -j "$CORES" "download_err $OUTDIR $SAMPLE"
fi
