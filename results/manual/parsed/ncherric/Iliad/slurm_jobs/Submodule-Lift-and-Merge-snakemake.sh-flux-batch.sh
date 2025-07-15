#!/bin/bash
#FLUX: --job-name=evasive-fudge-0403
#FLUX: -t=131400
#FLUX: --priority=16

sbcmd="sbatch --ntasks=1 --cpus-per-task={threads} --mem={resources.mem_mb}"
sbcmd+=" --time={resources.runtime} --output=[Working Iliad Directory]/logs/{rule}.{wildcards}.o"
sbcmd+=" --error=[Working Iliad Directory]/logs/{rule}.{wildcards}.e"
sbcmd+=" --mail-user= --mail-type=ALL,TIME_LIMIT"
snakemake -p --cores 1 --jobs 8 --use-singularity --use-conda --snakefile workflow/Lift-and-Merge_Snakefile --default-resource=mem_mb=10000 --cluster "$sbcmd"
