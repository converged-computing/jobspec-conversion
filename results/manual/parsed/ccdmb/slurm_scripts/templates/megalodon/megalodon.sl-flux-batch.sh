#!/bin/bash
#FLUX: --job-name=swampy-banana-9331
#FLUX: --queue=gpuq
#FLUX: -t=86400
#FLUX: --urgency=16

module load singularity
module load cuda
srun -n 1 --export=all --gres=gpu:1 \
singularity exec --nv /group/y95/jdebler/meg234_guppy_5011_latest.sif megalodon /scratch/y95/username/folder_with_fast5_files/ \
--guppy-server-path /home/ont-guppy/bin/guppy_basecall_server \
--guppy-params "--chunk_size 1000" \
--guppy-config dna_r9.4.1_450bps_modbases_5mc_hac.cfg \
--outputs mod_mappings mods \
--reference /scratch/y95/username/reference/genome.fasta \
--mod-motif m CG 0 \
--output-directory /scratch/y95/username/megalodon_output \
--overwrite \
--sort-mappings \
--mod-map-emulate-bisulfite \
--mod-map-base-conv C T --mod-map-base-conv m C \
--devices cuda:all \
--processes 16
