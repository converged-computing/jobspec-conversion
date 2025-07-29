#!/bin/bash
#SBATCH --job-name=ja_ex
#SBATCH --account=rrg-ggalex
#SBATCH --output=./slurm_runs/%j-%u-%x-%N.out
#SBATCH --error=./slurm_runs/%j-%u-%x-%N.err
#SBATCH --mail-user=gaox67@mcmaster.ca
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=44
#SBATCH --mem=3G
#SBATCH --time=08:00:00
#SBATCH --array=1-888

header_offset=1
module --force purge
module load StdEnv/2020 gcc/9.3.0 gdal/3.5.1 python/3.10.2
source /home/xinran22/projects/rrg-ggalex/shared/python_venvs/xinran_pcmci_2023-10-23/bin/activate
adjusted_task_id=$((SLURM_ARRAY_TASK_ID + header_offset))
line=$(sed -n "${adjusted_task_id}p" hl_search.csv)
index=$(echo $line | awk -F, '{print $1}')
begin_idx=$(echo $line | awk -F, '{print $2}')
end_idx=$(echo $line | awk -F, '{print $3}')
python main.py --index "$index" --begin_idx "$begin_idx" --end_idx "$end_idx"
