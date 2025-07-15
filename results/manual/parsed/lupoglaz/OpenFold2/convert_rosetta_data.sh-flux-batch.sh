#!/bin/bash
#FLUX: --job-name=DatasetConvert
#FLUX: --queue=cpu
#FLUX: -t=108000
#FLUX: --urgency=16

module load gpu/cuda-11.3
conda activate torch
python convert_rosetta_data.py \
-rosetta_data_dir /gpfs/gpfs0/g.derevyanko/tRosettaDataset \
-fasta_dir /gpfs/gpfs0/g.derevyanko/OpenFold2Dataset/Sequences \
-pdb_dir /gpfs/gpfs0/g.derevyanko/OpenFold2Dataset/Structures \
-output_msa_dir /gpfs/gpfs0/g.derevyanko/OpenFold2Dataset/Alignments \
-output_feat_dir /gpfs/gpfs0/g.derevyanko/OpenFold2Dataset/Features \
-data_dir /gpfs/gpfs0/datasets/AlphaFold \
\
-hhsearch_binary_path /trinity/home/g.derevyanko/miniconda3/bin/hhsearch \
-hhblits_binary_path /trinity/home/g.derevyanko/miniconda3/bin/hhblits
