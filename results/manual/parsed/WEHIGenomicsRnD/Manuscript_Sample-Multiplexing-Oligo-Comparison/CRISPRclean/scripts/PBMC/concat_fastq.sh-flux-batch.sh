#!/bin/bash
#FLUX: --job-name=downsample
#FLUX: -c=8
#FLUX: --queue=regular
#FLUX: -t=43200
#FLUX: --priority=16

module load gcc
module load anaconda3
eval "$(conda shell.bash hook)"
conda activate ~/scratchHOME/ngsQC
DOWNSAMPLE=199000000;
INPUT_DIR="/stornext/Projects/score/GenomicsRnD/DB/NN265/fastq/AAAL25YHV";
OUTPUT_DIR="/stornext/Projects/score/GenomicsRnD/DB/NN265/fastq/AAAL25YHV/concat/";
seqtk sample -2 -s100 concat/R010_LMO_JPC_GEX_S1_L001_I1_001.fastq.gz $DOWNSAMPLE | gzip >  downsample/R010_LMO_JPC_GEX_S1_L001_I1_001.fastq.gz;
seqtk sample -2 -s100 concat/R010_LMO_JPC_GEX_S1_L001_R1_001.fastq.gz $DOWNSAMPLE | gzip >  downsample/R010_LMO_JPC_GEX_S1_L001_R1_001.fastq.gz;
seqtk sample -2 -s100 concat/R010_LMO_JPC_GEX_S1_L001_R2_001.fastq.gz $DOWNSAMPLE | gzip >  downsample/R010_LMO_JPC_GEX_S1_L001_R2_001.fastq.gz;
seqtk sample -2 -s100 concat/R010_LMO_UTD_GEX_S5_L001_I1_001.fastq.gz $DOWNSAMPLE | gzip >  downsample/R010_LMO_UTD_GEX_S5_L001_I1_001.fastq.gz;
seqtk sample -2 -s100 concat/R010_LMO_UTD_GEX_S5_L001_R1_001.fastq.gz $DOWNSAMPLE | gzip >  downsample/R010_LMO_UTD_GEX_S5_L001_R1_001.fastq.gz;
seqtk sample -2 -s100 concat/R010_LMO_UTD_GEX_S5_L001_R2_001.fastq.gz $DOWNSAMPLE | gzip >  downsample/R010_LMO_UTD_GEX_S5_L001_R2_001.fastq.gz;
cat concat/R010_LMO_JPC_GEX_S1_L001_I1_001.fastq.gz concat/R010_LMO_UTD_GEX_S5_L001_I1_001.fastq.gz \
    > concat/R010_PBMC_UTD-JPC_LMO_GEX_I1.fastq.gz;
cat concat/R010_LMO_JPC_GEX_S1_L001_R1_001.fastq.gz concat/R010_LMO_UTD_GEX_S5_L001_R1_001.fastq.gz \
    > concat/R010_PBMC_UTD-JPC_LMO_GEX_R1.fastq.gz;
cat concat/R010_LMO_JPC_GEX_S1_L001_R2_001.fastq.gz concat/R010_LMO_UTD_GEX_S5_L001_R2_001.fastq.gz \
    > concat/R010_PBMC_UTD-JPC_LMO_GEX_R2.fastq.gz;
