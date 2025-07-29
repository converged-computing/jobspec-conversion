#!/bin/bash
#SBATCH --job-name=bootstrap_demog
#SBATCH --output=/oak/stanford/groups/russpold/users/ieisenbe/Self_Regulation_Ontology/behavioral_data/mturk_retest_output/bootstrap_output/.out/bootstrap_demog.job.out
#SBATCH --error=/oak/stanford/groups/russpold/users/ieisenbe/Self_Regulation_Ontology/behavioral_data/mturk_retest_output/bootstrap_output/.err/bootstrap_demog.job.err
#SBATCH --mail-user=zenkavi@stanford.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=04:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=1-10%10

source activate SRO
eval $( sed "${SLURM_ARRAY_TASK_ID}q;d" bootstrap_demog_tasklist )
