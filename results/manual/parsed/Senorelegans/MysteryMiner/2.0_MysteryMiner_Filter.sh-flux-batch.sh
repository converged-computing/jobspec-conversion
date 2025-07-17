#!/bin/bash
#FLUX: --job-name=Filter
#FLUX: -n=10
#FLUX: --queue=long
#FLUX: -t=360300
#FLUX: --urgency=16

export PATH='~/.local:$PATH'

export PATH=~:$PATH
export PATH=~/.local/bin:$PATH
export PATH=~/.local:$PATH
module load sra/2.8.0
module load bedtools/2.25.0
module load gcc/7.1.0
module load seqkit/0.9.0
module load preseq/2.0.3
ml gcc/7.1.0
ml magicblast/1.3.0
ml bowtie/2.2.9
ml STAR/2.5.2b
ml ncbi-blast/2.7.1
MAIN=/RNAseq-Biome-master
PROJECT=${MAIN}"/NF_OUT"
BIN=${MAIN}/bin
BLASTXDB = "/scratch/Users/mame5141/2019/RNAseq-Biome-Nextflow/blastDB_all_protein/nr" 
python ${BIN}/nb_FilterDarkGenome.py \
--col_data ${MAIN}/sample_table.txt \
--Nextflow_Out ${PROJECT}  \
--cpus 32 \
--nr_db ${BLASTXDB}
python ${BIN}/nb_2.0-PileupNormalize.py --Nextflow_Out ${PROJECT}
python ${BIN}/nb_3.0-PileupDataFrame.py --Nextflow_Out ${PROJECT} --Nextflow_path ${MAIN}
python ${BIN}/nb_4.0-CountContigs.py --Nextflow_Out ${PROJECT} --col_data ${MAIN}/sample_table.txt
python ${BIN}/nb_5FilterTtest.py --Nextflow_Out ${PROJECT} --Nextflow_path ${MAIN}
