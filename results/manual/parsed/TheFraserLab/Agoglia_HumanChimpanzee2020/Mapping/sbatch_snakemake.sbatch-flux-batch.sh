#!/bin/bash
#FLUX: --job-name=snake
#FLUX: --queue=hns,normal,hbfraser
#FLUX: -t=360000
#FLUX: --urgency=16

module load conda
source activate fraserconda
srun snakemake --unlock
srun snakemake --jobs 100 --cluster-config cluster_config.json --rerun-incomplete --keep-going --allowed-rules count_ase --use-conda --conda-prefix /home/groups/hbfraser/modules/packages/conda/4.6.14/envs/ --cluster "sbatch --mem={cluster.memory} --partition={cluster.partition} --nodes=1 --ntasks-per-node=1 --cpus-per-task={cluster.cpus} --time={cluster.time}" 
