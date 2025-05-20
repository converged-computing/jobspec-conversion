#!/bin/bash

#FLUX: -n 1
#FLUX: --cpus-per-task=1
#FLUX: --resource=mem=4000M
#FLUX: --time-limit=120h
# FLUX: --job-name=scansnv_job # Optional: sets a job name

# Note on original Slurm options:
# #SBATCH -p priopark: Slurm partition. Flux uses queues. If 'priopark' maps to a specific
#                     Flux queue, you might add '#FLUX: --queue=queuename'. Otherwise,
#                     this is typically handled by site policy or default Flux queue.
# #SBATCH -A park_contrib: Slurm account. In Flux, accounting/project is often specified
#                         via 'flux submit --project <name>' or environment variables,
#                         not typically as a script directive.

# The main application command:
/n/data1/hms/dbmi/park/jluquette/pta/scan-snv2/bin/scansnv \
    --ref /n/data1/hms/dbmi/park/jluquette/genotyper1/paper/resources/human_g1k_v37_decoy.fasta \
    --dbsnp /home/ljl11/balance/resources/dbsnp_147_b37_common_all_20160601.vcf \
    --snakefile /n/data1/hms/dbmi/park/jluquette/pta/scan-snv2/snakemake/Snakefile \
    --scripts /n/data1/hms/dbmi/park/jluquette/pta/scan-snv2/scripts \
    --shapeit-panel /n/data1/hms/dbmi/park/jluquette/genotyper1/paper/resources/1000GP_Phase3 \
    --bam 5823-tempmusc-1b1_20170221-WGS /n/data1/bch/genetics/walsh-park/data/Aging/Alignment/20170420_Alignment/5823-tempmusc-1b1_20170221-WGS-final-all.bam \
    --bulk-sample 5823-tempmusc-1b1_20170221-WGS \
    --bam 5823_20160810-dg-1cp2E1_20170221-WGS /n/data1/bch/genetics/walsh-park/data/Aging/Alignment/20170420_Alignment/5823_20160810-dg-1cp2E1_20170221-WGS-final-all.bam \
    --bam 5823_20160810-dg-1cp3D11_20170221-WGS /n/data1/bch/genetics/walsh-park/data/Aging/Alignment/20170420_Alignment/5823_20160810-dg-1cp3D11_20170221-WGS-final-all.bam \
    --bam 5823_20160810-dg-1cp3H1_20170221-WGS /n/data1/bch/genetics/walsh-park/data/Aging/Alignment/20170420_Alignment/5823_20160810-dg-1cp3H1_20170221-WGS-final-all.bam \
    --bam 5823_20160824-pfc-1cp1F11_20170221-WGS /n/data1/bch/genetics/walsh-park/data/Aging/Alignment/20170420_Alignment/5823_20160824-pfc-1cp1F11_20170221-WGS-final-all.bam \
    --sc-sample 5823_20160824-pfc-1cp1F11_20170221-WGS \
    --bam 5823_20160824-pfc-1cp2E1_20170221-WGS /n/data1/bch/genetics/walsh-park/data/Aging/Alignment/20170420_Alignment/5823_20160824-pfc-1cp2E1_20170221-WGS-final-all.bam \
    --sc-sample