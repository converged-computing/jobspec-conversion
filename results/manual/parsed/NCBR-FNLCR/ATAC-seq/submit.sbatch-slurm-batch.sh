#!/bin/bash
#SBATCH --mail-user=markowitzte@nih.gov
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4g
#SBATCH --time=4-00:00:00

module load snakemake/5.5.2
snakemake --jobname 's.{jobid}.{rulename}' --latency-wait 600 -j 100 --rerun-incomplete --keep-going --restart-times 1 --stats snakemake.stats --printshellcmds --cluster-config cluster.json --cluster "sbatch --partition={cluster.partition} --gres={cluster.gres} --ntasks={cluster.threads} --mem={cluster.mem}  --time={cluster.time}" >& snakemake.log
test -d slurmfiles || mkdir slurmfiles
mv slurm-*out slurmfiles/
