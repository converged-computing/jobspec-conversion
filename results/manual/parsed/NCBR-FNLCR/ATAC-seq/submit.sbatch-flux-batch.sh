#!/bin/bash
#FLUX: --job-name=expressive-salad-6772
#FLUX: -n=2
#FLUX: --queue=norm
#FLUX: -t=345600
#FLUX: --urgency=16

module load snakemake/5.5.2
snakemake --jobname 's.{jobid}.{rulename}' --latency-wait 600 -j 100 --rerun-incomplete --keep-going --restart-times 1 --stats snakemake.stats --printshellcmds --cluster-config cluster.json --cluster "sbatch --partition={cluster.partition} --gres={cluster.gres} --ntasks={cluster.threads} --mem={cluster.mem}  --time={cluster.time}" >& snakemake.log
test -d slurmfiles || mkdir slurmfiles
mv slurm-*out slurmfiles/
