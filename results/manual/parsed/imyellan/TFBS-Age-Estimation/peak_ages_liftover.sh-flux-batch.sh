#!/bin/bash
#FLUX: --job-name=bloated-hobbit-7376
#FLUX: -c=3
#FLUX: -t=259200
#FLUX: --urgency=16

export proj_dir='/home/iyellan/scratch/peak_ages'

module load StdEnv/2020 gcc/9.3.0 hal/2.2 kentutils/453
export proj_dir=/home/iyellan/scratch/peak_ages
mkdir -p "${proj_dir}"
genome_list="${proj_dir}"/genome_list.txt
genome_list_arr=($(cat "${genome_list}"))
mkdir -p "${proj_dir}"/liftover_results/ght
mkdir -p "${proj_dir}"/liftover_results/chs
find "${proj_dir}"/ght_tmp_beds/ -name "*.bed" \
| parallel -j ${SLURM_CPUS_PER_TASK} --compress --tmpdir "${SLURM_TMPDIR}" \
bash ~/scripts/run_liftover.sh {} "${genome_list_arr[$SLURM_ARRAY_TASK_ID]}" \
/home/iyellan/scratch/tfbs_ages/241-mammalian-2020v2.hal "${proj_dir}"/liftover_results/ght
find "${proj_dir}"/chs_tmp_beds/ -name "*.bed" \
| parallel -j ${SLURM_CPUS_PER_TASK} --compress --tmpdir "${SLURM_TMPDIR}" \
bash ~/scripts/run_liftover.sh {} "${genome_list_arr[$SLURM_ARRAY_TASK_ID]}" \
/home/iyellan/scratch/tfbs_ages/241-mammalian-2020v2.hal "${proj_dir}"/liftover_results/chs
