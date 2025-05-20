#!/bin/bash

#FLUX: -N 1
#FLUX: -n 1
#FLUX: --tasks-per-node=1
#FLUX: --cpus-per-task=1
#FLUX: -t 120h
#FLUX: --requires=mem=4000M
#FLUX: -q priopark
# Note: Slurm's account '#SBATCH -A park_contrib' does not have a direct equivalent
# FLUX batch directive. Account/project information in Flux is often handled
# via site-specific configurations, environment variables (e.g., FLUX_PROJECT),
# or attributes set during submission by wrapper tools.

# The main application command.
# The --drmaa argument has been tentatively translated from Slurm syntax to Flux syntax.
# This assumes that the 'scansnv' application can flexibly interpret these options
# for its sub-job submissions, or that it can be configured to use Flux DRMAA
# or direct Flux submission commands.
# Specifically:
#   Slurm '-p park' becomes Flux '-q park' (queue).
#   Slurm '-A park_contrib' is omitted for sub-jobs as well (see note above).
#   Slurm '--mem={resources.mem}' becomes Flux '--requires=mem={resources.mem}M'
#     (assuming {resources.mem} is a value in MB).
#   Slurm '-t 5:00:00' becomes Flux '-t 5h'.
#   Slurm '-o %logdir/slurm-%A.log' becomes Flux '-o %logdir/flux-%j.log'
#     (using Flux job ID placeholder %j).

/n/data1/hms/dbmi/park/jluquette/pta/scan-snv2/bin/scansnv \
    --ref /n/data1/hms/dbmi/park/jluquette/genotyper1/paper/resources/human_g1k_v37_decoy.fasta \
    --dbsnp /home/ljl11/balance/resources/dbsnp_147_b37_common_all_20160601.vcf \
    --snakefile /n/data1/hms/dbmi/park/jluquette/pta/scan-snv2/snakemake/Snakefile \
    --scripts /n/data1/hms/dbmi/park/jluquette/pta/scan-snv2/scripts \
    --shapeit-panel /n/data1/hms/dbmi/park/jluquette/genotyper1/paper/resources/1000GP_Phase3 \
    --regions-file /n/data1/hms/dbmi/park/jluquette/genotyper1/paper/scan-snv/regions.noX.txt \
    --bam 936-hrt-1b1_20170221-WGS /n/data1/bch/genetics/walsh-park/data/Aging/Alignment/20170420_Alignment/936-hrt-1b1_20170221-WGS-final-all.bam \
    --bulk-sample 936-hrt-1b1_20170221-WGS \
    --bam 936_20141001-pfc-1cp1G11_20170221-WGS /n/data1/bch/genetics/walsh-park/data/Aging/Alignment/20170420_Alignment/936_20141001-pfc-1cp1G11_20170221-WGS-final-all.bam \
    --sc-sample 936_20141001-pfc-1cp1G11_20170221-WGS \
    --bam 936_20141001-pfc-1cp1H9_20170221-WGS /n/data1/bch/genetics/walsh-park/data/Aging/Alignment/20170420_Alignment/936_20141001-pfc-1cp1H9_20170221-WGS-final-all.bam \
    --sc-sample 936_20141001-pfc-1cp1H9_20170221-WGS \
    --bam 936_20141001-pfc-1cp2F6_20170221-WGS /n/data1/bch/genetics/walsh-park/data/Aging/Alignment/20170420_Alignment/936_20141001-pfc-1cp2F6_20170221-WGS-final-all.bam \
    --sc-sample 936_20141001-pfc-1cp2F6_20170221-WGS \
    --bam 936PFC-A /n/data1/bch/genetics/walsh-park/PTA/NewData/.PreProcessing/936PFC-A.b37.bam \
    --sc-sample 936PFC-A \
    --bam 936PFC-B /n/data1/bch/genetics/walsh-park/PTA/NewData/.PreProcessing/936PFC-B.b37.bam \
    --sc-sample 936PFC-B \
    --bam 936PFC-C /n/data1/bch/genetics/walsh-park/PTA/NewData/.PreProcessing/936PFC-C.b37.bam \
    --sc-sample 936PFC-C \
    --output-dir scansnv_fdr01_noX \
    --abmodel-chunks 4 \
    --abmodel-samples-per-chunk 5000 \
    --target-fdr 0.01 \
    --add-chr-prefix \
    --joblimit 1000 \
    --drmaa ' -q park --requires=mem={resources.mem}M -t 5h -o %logdir/flux-%j.log' \
    --somatic-indels \
    --somatic-indel-pon panel_52_pta_neurons_042521.partial_100pct.mmq60.indels.tab