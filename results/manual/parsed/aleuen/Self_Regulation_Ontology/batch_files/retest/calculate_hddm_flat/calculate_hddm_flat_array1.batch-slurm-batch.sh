#!/bin/bash
#SBATCH --job-name=hddm_flat
#SBATCH --output=/oak/stanford/groups/russpold/users/ieisenbe/Self_Regulation_Ontology/behavioral_data/mturk_retest_output/hddm_flat/.out/%A-%a.out
#SBATCH --error=/oak/stanford/groups/russpold/users/ieisenbe/Self_Regulation_Ontology/behavioral_data/mturk_retest_output/hddm_flat/.err/%A-%a.err
#SBATCH --mail-user=zenkavi@stanford.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=4G
#SBATCH --time=04:00:00
#SBATCH --qos=russpold
#SBATCH --array=1-900%10

source /home/zenkavi/.bash_profile
source activate SRO
eval $( sed "${SLURM_ARRAY_TASK_ID}q;d" xaa )
