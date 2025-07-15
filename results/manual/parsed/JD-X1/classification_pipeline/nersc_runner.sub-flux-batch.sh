#!/bin/bash
#FLUX: --job-name=buttery-puppy-3550
#FLUX: --priority=16

module load python
mamba env create -n Titania -f envs/Titania.yaml
conda activate Titania
DIR="./resources/eukccdb"
if [ -d $DIR ]
then
    echo "eukccdb directory exists"
    cd resources/eukccdb
    export EUKCC2_DB=$(realpath eukcc2_db_ver_1.1)
    cd ../..
else
    echo "eukccdb directory does not exist"
    echo "Fetching eukccdb directory"
    mkdir resources/eukccdb
    cd resources/eukccdb
    wget http://ftp.ebi.ac.uk/pub/databases/metagenomics/eukcc/eukcc2_db_ver_1.1.tar.gz
    tar -xzvf eukcc2_db_ver_1.1.tar.gz
    export EUKCC2_DB=$(realpath eukcc2_db_ver_1.1)
    cd ../..
fi
DIR="./resources/4CAC"
if [ -d $DIR ]
then
    echo "4CAC directory exists"
else
    echo "4CAC directory does not exist"
    echo "Fetching 4CAC directory"
    git clone https://github.com/Shamir-Lab/4CAC.git
    mv 4CAC/ resources/.
fi
snakemake --cores 240 --use-conda --snakefile rules/mag_stats.smk
