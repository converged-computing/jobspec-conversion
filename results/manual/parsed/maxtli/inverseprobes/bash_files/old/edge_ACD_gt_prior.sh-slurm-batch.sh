#!/bin/bash
#SBATCH --job-name=prior-$var-gt-edge_pruning
#SBATCH --output=prog_files/gtprio-pre_$var-%j.out
#SBATCH --error=prog_files/gtprio-pre_$var-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --mem=32000
#SBATCH --time=00:12:00

for strength in "0.3"
do
for prior in "2e-3"
do
for var in "$@"
do
sbatch <<EOT
module load Anaconda2
conda activate take2
python3 edge_pruning_vertex_gt_prior.py --lamb $var --prior $prior --strength $strength
EOT
done
done
done
