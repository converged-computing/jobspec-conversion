#!/bin/bash
#FLUX: --job-name=bricky-mango-5129
#FLUX: --urgency=16

module load bioinfo-tools
module load snakemake/5.10.0
module load hmmer/3.2.1-intel
module load blast/2.9.0+
make slurm-run
>&2 echo ""
>&2 echo ""
>&2 echo "bs2-run job should now have been submitted to cluster."
>&2 echo "Submission details, and any possible errors, are in the bs2-run.err file."
>&2 echo "Monitor submitted jobs with with the 'jobinfo' command."
>&2 echo "When all processing are finished, you should see outfiles"
>&2 echo "in folder birdscanner2/results."
>&2 echo ""
>&2 echo "Reached the end of the bs2-run slurm script."
