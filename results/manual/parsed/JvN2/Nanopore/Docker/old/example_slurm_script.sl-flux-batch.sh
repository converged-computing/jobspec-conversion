#!/bin/bash
#FLUX: --job-name=purple-pedo-3792
#FLUX: --queue=gpuq
#FLUX: -t=36000
#FLUX: --urgency=16

module load singularity
module load cuda
srun -n 1 --export=all --gres=gpu:1 \
singularity exec --nv /PATH/TO/megalodon_guppy_latest.sif megalodon /PATH/TO/FAST5/FOLDER/ \
--guppy-server-path /home/ont-guppy/bin/guppy_basecall_server \
--guppy-params "-d /PATH/TO/rerio/basecall_models/ --chunk_size 1000" \
--guppy-config res_dna_r941_min_modbases_5mC_CpG_v001.cfg \
--outputs mod_mappings mods \
--reference /PATH/TO/REFERENCE.fasta \
--mod-motif m CG 0 \
--output-directory /PATH/FOR/MEGALODON/OUTPUT \
--overwrite \
--sort-mappings \
--devices cuda:all
