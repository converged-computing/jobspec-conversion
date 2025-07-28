#!/bin/bash
#FLUX: --job-name=runPGSTK
#FLUX: -t=8100
#FLUX: --urgency=16

                                                                    # or ALL (equivalent to BEGIN, END, FAIL, INVALID_DEPEND, REQUEUE, and STAGE_OUT), 
                                                                    # Multiple type values may be specified in a comma separated list. 
PROJECTDIR="/hpc/dhl_ec/svanderlaan/projects/"
PGSDIR="/hpc/dhl_ec/svanderlaan/projects/polygenicscores"
PGS_CAD="${PGSDIR}/Inouye_bioRxiv_2018"
PGS_CAD_UKBB="${PGSDIR}/UKBB_GWAS1KG_2017"
SOFTWARE="/hpc/local/CentOS7/dhl_ec/software"
BGENIX="/hpc/local/CentOS7/dhl_ec/bin/bgenix"
PLINK="${SOFTWARE}/plink2_linux_x86_64_20200124_alpha_v2.3_final/plink2"
AEGSDATADIR="/hpc/dhl_ec/data/_ae_originals/"
AEGSDIR="${AEGSDATADIR}/AEGS_COMBINED_EAGLE2_1000Gp3v5HRCr11"
echo ""
echo "Converting VCF to bgen."
echo ""
echo "Creating variant lists."
echo ""
echo "Concatenating variant list."
echo ""
echo "Calculating frequencies."
echo ""
echo "Creating input for PGSToolKit."
echo ""
echo "Running PGSToolKit."
																	# or ALL (equivalent to BEGIN, END, FAIL, INVALID_DEPEND, REQUEUE, and STAGE_OUT), 
																	# Multiple type values may be specified in a comma separated list. 
sbatch --job-name=pgsTK_CAD --output=${PROJECTDIR}/PGS/pgsTK_CAD.log --error=${PROJECTDIR}/PGS/pgsTK_CAD.errors  \
--time=12:15:00 --mem=48G --gres=tmpspace:128G \
--mail-user=s.w.vanderlaan-2@umcutrecht.nl --mail-type=FAIL \
${SOFTWARE}/PGSToolKit/pgstoolkit.sh ${PROJECTDIR}/PGS/pgstoolkit.cad.config
