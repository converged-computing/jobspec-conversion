#!/bin/bash
#SBATCH --job-name=ICTV_NCBI_efetch_fasta_files_A
#SBATCH --output=logs/log.%J.%x.out
#SBATCH --error=logs/log.%J.%x.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1000
#SBATCH --time=12:00:00
#SBATCH --partition=amd-hdr100

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
echo ./VMR_to_fasta.py -verbose -mode VMR   -ea a -email $USER@uab.edu -VMR_file_name $VMR_XLSX
./VMR_to_fasta.py -verbose -mode VMR   -ea a -email $USER@uab.edu -VMR_file_name $VMR_XLSX
echo "### fetch FASTA ###"
echo ./VMR_to_fasta.py -verbose -mode fasta -ea a -email $USER@uab.edu -VMR_file_name processed_accessions_a.xlsx
./VMR_to_fasta.py -verbose -mode fasta -ea a -email $USER@uab.edu -VMR_file_name processed_accessions_a.xlsx
