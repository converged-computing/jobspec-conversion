#!/bin/bash
#FLUX: --job-name=MACS2_FE
#FLUX: -t=3600
#FLUX: --urgency=16

module purge
module load macs2/intel/2.1.1
echo "#####################################################"
echo ""
echo "Running: $SLURM_JOB_NAME"
echo "JobID is: $SLURM_JOBID"
echo ""
cd /scratch/$USER
if [[ $FLDR != "" ]]; then
    cd $FLDR
else
    cd $SLURM_SUBMIT_DIR
fi
DIR=$PWD
echo "working in $DIR"
echo "Treatment file is: $TREAT"
echo "Control file is: $CONTROL"
echo "Output folder is: $FOLDER"
echo "Experiment ID is: $M2FILE"
echo ""
PEAK=$(echo $PEAK | tr '[:lower:]' '[:upper:]')
GENSIZE=1.2e7
if [[ $BDG == "" ]]; then
    if [[ $WIG == "" ]]; then
	BDG="FALSE"
    else
	BDG=$WIG
    fi
fi
if [[ $BDG =~ ^[Rr] ]]; then
    DUP="all"
else
    DUP="auto"
fi
FOLDER=$FOLDER-MACS2
if [[ ! $M2FILE =~ "W3" ]]; then
    M2FILE="${M2FILE}_W3_MACS2"
else
    M2FILE="${M2FILE}_MACS2"
fi
if [[ $BDG =~ [fF] ]]; then
    # if wiggle files do not need to be created, don't make bedgraphs
    # currently not ensuring that files are not already created before running functions
    if [[ $PEAK == "NARROW" || $PEAK == "BOTH" ]]; then
	    macs2 callpeak -t $TREAT -c $CONTROL -n $M2FILE \
		--outdir $FOLDER -g $GENSIZE --extsize 200 \
		--SPMR --keep-dup=$DUP --nomodel
    fi
    if [[ $PEAK == "BROAD" || $PEAK == "BOTH" ]]; then
	macs2 callpeak -t $TREAT -c $CONTROL -n $M2FILE \
	    --outdir $FOLDER -g $GENSIZE --extsize 200 \
	    --SPMR --keep-dup=$DUP --nomodel --broad
    fi
else
    if [[ $PEAK == "NARROW" || $PEAK == "" ]]; then
	macs2 callpeak -t $TREAT -c $CONTROL -n $M2FILE \
	    --outdir $FOLDER -B -g $GENSIZE --extsize 200 \
	    --SPMR --keep-dup=$DUP --nomodel
    elif [[ $PEAK == "BROAD" ]]; then
	macs2 callpeak -t $TREAT -c $CONTROL -n $M2FILE \
	    --outdir $FOLDER -B -g $GENSIZE --extsize 200 \
	    --SPMR --keep-dup=$DUP --nomodel --broad
    elif [[ $PEAK == "BOTH" ]]; then
	macs2 callpeak -t $TREAT -c $CONTROL -n $M2FILE \
	    --outdir $FOLDER -B -g $GENSIZE --extsize 200 \
	    --SPMR --keep-dup=$DUP --nomodel
	macs2 callpeak -t $TREAT -c $CONTROL -n $M2FILE \
	    --outdir $FOLDER -g $GENSIZE --extsize 200 \
	    --SPMR --keep-dup=$DUP --nomodel --broad
    else
	echo "Do not recognize method chosen for PEAK"
	exit 1
    fi
    echo ""
    echo "working in $FOLDER"
    cd $FOLDER
    # get fold-enrichment normalized bedgraphs
    macs2 bdgcmp -t ${M2FILE}_treat_pileup.bdg \
	-c ${M2FILE}_control_lambda.bdg \
	-o ${M2FILE}_FE.bdg -m FE
    if [[ $WIG =~ ^[TtRr] ]]; then
	# convert bedgraphs created by MACS2 into wiggle files
	if [ ! -f ~/ChIPseq_Pipeline_v3/Bedgraph2VariableStepWiggle.py ]; then
	    echo "Cannot find Bedgraph2VariableStepWiggle.py"
	    echo "This file should be located in ~/ChIPseq_Pipeline_v3"
	    exit 1
	else
	    if [ -d ${M2FILE}_FE ]; then
		echo "Already converted ${M2FILE}_FE.bdg into wiggle"
	    else
		module purge
		module load python3/intel/3.5.3
		echo "Converting ${M2FILE}_FE.bdg into wiggle"
		python3 ~/ChIPseq_Pipeline_v3/Bedgraph2VariableStepWiggle.py \
		    -b ${M2FILE}_FE.bdg
		cd $DIR/$FOLDER
		if [ -d ${M2FILE}_FE ]; then
		    gzip ${M2FILE}_FE/*.wig
		else
		    gzip $M2FILE*.wig
		fi
	    fi
	fi
    fi
    gzip $M2FILE*.bdg
fi
echo "complete"
date
echo ""
