#!/bin/bash
#FLUX: --job-name=doopy-avocado-7285
#FLUX: --queue=gpuq
#FLUX: -t=36000
#FLUX: --urgency=16

module load singularity
module load cuda
srun -n 1 --export=all --gres=gpu:1 \
singularity exec --nv /group/y95/jdebler/guppy-gpu_6.1.3.sif guppy_basecaller \
-i /scratch/y95/jdebler/folder_with_fast5_files \
-s /scratch/y95/jdebler/output_folder \
--flowcell FLO-MIN106 \
--kit SQK-LSK109 \
--barcode_kits EXP-NBD104 \
--trim_barcodes \
--detect_mid_strand_barcodes \
--min_score_barcode_mid 60 \
--compress_fastq \
--fast5_out \
-x cuda:all
