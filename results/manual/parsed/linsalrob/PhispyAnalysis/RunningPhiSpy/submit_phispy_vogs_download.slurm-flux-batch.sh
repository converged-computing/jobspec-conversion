#!/bin/bash
#FLUX: --job-name=gloopy-bits-4985
#FLUX: -c=4
#FLUX: -t=432000
#FLUX: --priority=16

DATE=20220606
ASS=$DATE/assembly_summary_$DATE.txt.gz
VOGS=/home/edwa0468/VOGs/vog99/VOGs.hmm
NEED=0000$SLURM_ARRAY_TASK_ID
NEED=${NEED:(-4)}
snakemake -s ~/GitHubs/PhispyAnalysis/RunningPhiSpy/phispy_vogs_download.snakefile --config filelist=$DATE/needed/x$NEED gbk=$DATE/gbk output=$DATE/phispy assembly=$ASS vogs=$VOGS --profile slurm_small
