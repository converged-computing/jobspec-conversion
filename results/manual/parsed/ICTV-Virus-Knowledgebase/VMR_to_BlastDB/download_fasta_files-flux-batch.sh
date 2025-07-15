#!/bin/bash
#FLUX: --job-name=ICTV_NCBI_efetch_fasta_files
#FLUX: --queue=amd-hdr100 --time=00-12:00:00
#FLUX: --priority=16

VMR_XLSX=$(ls -rt VMRs/VMR_MSL*.xlsx | tail -1)
if [ ! -z "$1" ]; then 
    VMR_XLSX=$1
fi
echo VMR_XLSX=$VMR_XLSX
if [ -z "$(which conda 2>/dev/null)" ]; then
    echo module load Anaconda3
    module load Anaconda3
fi
if [[ "$(which python 2>/dev/null)" != *$PWD/conda* ]]; then
    echo conda activate conda/vmr_openpyxl3
    conda activate conda/vmr_openpyxl3
fi
echo "### parse VMR ###"
echo ./VMR_to_fasta.py -verbose -mode VMR   -ea e -email $USER@uab.edu -VMR_file_name $VMR_XLSX
./VMR_to_fasta.py -verbose -mode VMR   -ea e -email $USER@uab.edu -VMR_file_name $VMR_XLSX
echo "### fetch FASTA for E###"
echo ./VMR_to_fasta.py -verbose -mode fasta -ea e -email $USER@uab.edu -VMR_file_name processed_accessions_e.xlsx
./VMR_to_fasta.py -verbose -mode fasta -ea e -email $USER@uab.edu -VMR_file_name processed_accessions_e.xlsx
