#!/bin/bash

# PBS Directives, assuming PBSpro
#PBS -A st-wasserww-1
#PBS -V
#PBS -N SetupSTR_Sim_complex
#PBS -m bea
#PBS -M prichmond@cmmt.ubc.ca
#PBS -l select=1:ncpus=32:mem=100gb
#PBS -l walltime=24:0:0



# Simulation approach to create synthetic STR expansions
# This script will take in a table of pathogenic STRs, and simulate STR fastas and cutout bed files
# Then it will generate reads and map them to a corresponding reference genome
# Phillip Richmond
# August 19th 2019
# Updated October 28th 2019
# Updated November 22nd 2019

# 0. Initialize 
## Assumes you have bedtools, pysam, bwa, and python3
## This should be in the setup instructions
source activate STR_environment

# Variables which you need to set
GENOME_FASTA=/project/st-wasserww-1/GENOME/GRCh37/GRCh37-lite.fa
BWA_INDEX=/project/st-wasserww-1/GENOME/GRCh37/GRCh37-lite.fa
## Where is the github repo cloned to
STR_ANALYSIS_DIR=/scratch/st-wasserww-1/STR_Analysis/
STR_TABLE=$STR_ANALYSIS_DIR/CompareSTRDatabases/PathogenicLoci_Complex_GRCh37_20191122_table.tsv

# Some variables for script names (no need to alter)
SIMFASTA=$STR_ANALYSIS_DIR/STR_Simulation/SimFasta.py
CUTOUTPYTHON=$STR_ANALYSIS_DIR/STR_Simulation/CreateCutoutBed.py

# ART variables, relevant to the simulation you want to perform, matching to Polaris 2x150
ART=art_illumina
READLENGTH=150
DEPTH_HOMO=36
DEPTH_HET=18
DEPTHS=( $DEPTH_HOMO $DEPTH_HET )
# Calculated with samtools stats on the human genome BAM file from Polaris
FRAGMENT_LENGTH=460
FRAGMENT_STDEV=115

# BWA option for threads
THREADS=8

##################################################

### GRCh37 ###

# 1. Generate Fasta files of the regions

FASTADIR=${STR_ANALYSIS_DIR}STR_Simulation/str_fastas/GRCh37_Complex_20191122/
mkdir -p $FASTADIR
## NOTE: These Fasta files were made using Egor's tool
## with the JSON here: str_complex/locus_specs.json
#
#python $SIMFASTA \
#	-C \
#	-F $GENOME_FASTA \
#	-D $FASTADIR \
#	-T $STR_TABLE \
#	-S 0 \
#	-W 2000
## 2. Create Cutout BED files for the FASTA files you just generated
#
#CHROM_LENGTHS=${STR_ANALYSIS_DIR}STR_Simulation/ReferenceFiles/GRCh37-lite.chrom.sizes
#Files=(${FASTADIR}*fasta)
#for fasta in ${Files[@]}
#do
#       echo $fasta
#       IFS='/' read -a array <<< $fasta
#       SampleFasta=${array[-1]}
#       IFS='.' read -a array2 <<< "$SampleFasta"
#       SAMPLE_ID_BASE=${array2[0]}
#       echo $SAMPLE_ID_BASE
#       IFS='_' read -a array3 <<< $SAMPLE_ID_BASE
#       GENE=${array3[0]}
#       
#       if [ ! -f $FASTADIR${GENE}*bed ]; then
#
#       python $CUTOUTPYTHON -S $SAMPLE_ID_BASE -C $CHROM_LENGTHS -O $FASTADIR${SAMPLE_ID_BASE}.GRCh37.cutout.bed
#       fi
#done

# 3. Simulate the fasta files into reads and map them with BWAmem

BAMDIR=$STR_ANALYSIS_DIR/STR_Simulation/str_bams/GRCh37_Complex_20191122/
mkdir -p $BAMDIR
WORKING_DIR=$BAMDIR
cd $WORKING_DIR

for fasta in $(ls ${FASTADIR}*fasta)
do
        echo $fasta
        IFS='/' read -a array <<< $fasta
        SampleFasta=${array[-1]}
        IFS='.' read -a array2 <<< "$SampleFasta"
        SAMPLE_ID_BASE=${array2[0]}
        echo $SAMPLE_ID_BASE

        for DEPTH in ${DEPTHS[@]}
        do
                echo $DEPTH
                SAMPLE_ID=${SAMPLE_ID_BASE}_${DEPTH}x
                echo $SAMPLE_ID
                $ART -l $READLENGTH \
                        -f $DEPTH \
                        -o ${SAMPLE_ID}. \
                        -m $FRAGMENT_LENGTH \
                        -s $FRAGMENT_STDEV \
                        -i $fasta

                ###  Map the simulated reads, and convert to bam
                FASTQR1=$WRITE_DIR$SAMPLE_ID.1.fq
                FASTQR2=$WRITE_DIR$SAMPLE_ID.2.fq

                ## Map with BWA
                bwa mem $BWA_INDEX -t $THREADS -R "@RG\tID:STR_SIM\tSM:STR_SIM\tPL:illumina" -M $FASTQR1 $FASTQR2 > $WORKING_DIR$SAMPLE_ID.sam
                samtools view -@ $THREADS -ubS $WORKING_DIR$SAMPLE_ID'.sam' \
                        | samtools sort - -@ $THREADS  -T $WORKING_DIR$SAMPLE_ID'.sorted' -O BAM -o $WORKING_DIR$SAMPLE_ID'.sorted.bam'
                samtools index $WORKING_DIR$SAMPLE_ID'.sorted.bam'

        done

done

