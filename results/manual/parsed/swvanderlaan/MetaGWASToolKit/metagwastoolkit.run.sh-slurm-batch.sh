#!/bin/bash
#SBATCH --job-name=metagwastoolkit
#SBATCH --output=path_to_projectdir/subdir/metagwastoolkit.prep.log
#SBATCH --error=path_to_projectdir/subdir/metagwastoolkit.prep.errors
#SBATCH --mail-user=s.w.vanderlaan-2@umcutrecht.nl
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=tmpspace:128G
#SBATCH --mem=8G
#SBATCH --time=01:00:00

                                                                    														# or ALL (equivalent to BEGIN, END, FAIL, INVALID_DEPEND, REQUEUE, and STAGE_OUT), 
                                                                    														# Multiple type values may be specified in a comma separated list. 
METAGWASTOOLKIT="/hpc/local/Rocky8/dhl_ec/software/MetaGWASToolKit"
RESOURCES="${METAGWASTOOLKIT}/RESOURCES"
SCRIPTS="${METAGWASTOOLKIT}/SCRIPTS"
PROJECTNAME="EXAMPLEPHENOTYPE"
PROJECTDIR="${METAGWASTOOLKIT}/EXAMPLE"
SUBPROJECTDIRNAME="MODEL1"
PYTHON3="/hpc/local/Rocky8/dhl_ec/software/mambaforge3/bin/python3"
METAMODEL="FIXED" # FIXED, SQRTN, or RANDOM. Should match "CLUMP_FIELD" variable from the .conf file.
echo ""
echo "                 PERFORM META-ANALYSIS OF GENOME-WIDE ASSOCIATION STUDIES"
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
echo "FIRST step: prepare GWAS."
${SCRIPTS}/metagwastoolkit.prep.sh ${PROJECTDIR}/metagwastoolkit.conf ${PROJECTDIR}/metagwastoolkit.files.list
echo ""
echo "SECOND step: prepare meta-analysis."
echo ""
echo "THIRD step: meta-analysis."
if [[ ${METAMODEL} = "FIXED" ]]; then
	BETA="BETA_FIXED"
	SE="SE_FIXED"
	BETA_LOWER="BETA_LOWER_FIXED"
	BETA_UPPER="BETA_UPPER_FIXED"
	ZSCORE="Z_FIXED"
	PVALUE="P_FIXED"
elif [[ ${METAMODEL} = "SQRTN" ]]; then
	BETA="BETA_FIXED"
	SE="SE_FIXED"
	BETA_LOWER="BETA_LOWER_FIXED"
	BETA_UPPER="BETA_UPPER_FIXED"
	ZSCORE="Z_SQRTN"
	PVALUE="P_SQRTN"
elif [[ ${METAMODEL} = "RANDOM" ]]; then
	BETA="BETA_RANDOM"
	SE="SE_RANDOM"
	BETA_LOWER="BETA_LOWER_RANDOM"
	BETA_UPPER="BETA_UPPER_RANDOM"
	ZSCORE="Z_RANDOM"
	PVALUE="P_RANDOM"
else
	echo "Incorrect or no METAMODEL variable specified, defaulting to a FIXED model."
	BETA="BETA_FIXED"
	SE="SE_FIXED"
	BETA_LOWER="BETA_LOWER_FIXED"
	BETA_UPPER="BETA_UPPER_FIXED"
	ZSCORE="Z_FIXED"
	PVALUE="P_FIXED"
fi
