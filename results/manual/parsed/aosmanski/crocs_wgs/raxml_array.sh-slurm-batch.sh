#!/bin/bash
#SBATCH --job-name=6.6_raxml
#SBATCH --output=%x.%j.out
#SBATCH --error=%x.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=48
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=36GB
#SBATCH --partition=nocona
#SBATCH --array=1-10715

NAMESFILE=/lustre/scratch/aosmansk/clean_out/croc_phylogeny/raxml/new_raxml_bestTrees/SCORTHO_6.6
SCORTHO=$(awk "NR==$SLURM_ARRAY_TASK_ID" $NAMESFILE)
cd /lustre/scratch/aosmansk/clean_out/croc_phylogeny/raxml/new_workdirs/"SCORTHO_${SCORTHO}_raxml"/
/lustre/work/aosmansk/apps/raxml/raxml-ng/build/bin/raxml-ng \
  --all \
  --msa "NEW_SCORTHO_${SCORTHO}.aln.fas" \
  --model GTR+G \
  --bs-trees 100 \
  --threads 36
