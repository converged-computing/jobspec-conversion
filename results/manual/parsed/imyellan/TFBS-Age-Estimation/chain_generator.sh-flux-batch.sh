#!/bin/bash
#FLUX: --job-name=fat-lizard-6604
#FLUX: -c=12
#FLUX: -t=86400
#FLUX: --urgency=16

module load StdEnv/2020 gcc/9.3.0 hal/2.2 kentutils/453
target_spec=$1
proj_dir=/home/iyellan/scratch/tfbs_ages
genomes_arr=($(cat "$proj_dir"/genome_list.txt))
target_spec="${genomes_arr[$SLURM_ARRAY_TASK_ID]}"
mkdir -p "$proj_dir"/split_bed
split -l 1 "$proj_dir"/Homo_sapiens.bed "$proj_dir"/split_bed
hal2fasta "$proj_dir"/241-mammalian-2020v2.hal "${target_spec}" \
| faToTwoBit stdin "$proj_dir"/genomes/"${target_spec}".2bit
find split_bed/ -type f \
| parallel -j $SLURM_CPUS_PER_TASK --compress --tmpdir "${SLURM_TMPDIR}" \
bash ~/scripts/run_chain_generator_liftover.sh {} "${target_spec}"
cat "$proj_dir"/chains/*_Homo_sapiens-to-"${target_spec}".psl \
| sort -k10,10 -k12,12n > "$proj_dir"/chains/"${target_spec}"_all_psl.psl
axtChain -psl -linearGap=loose "${proj_dir}"/chains/"${target_spec}"_all_psl.psl.gz \
"${proj_dir}"/genomes/"${target_spec}".2bit "${proj_dir}"/genomes/Homo_sapiens.2bit stdout \
| chainSwap stdin "${proj_dir}"/chains/Homo_sapiens-to-"${target_spec}".chain
