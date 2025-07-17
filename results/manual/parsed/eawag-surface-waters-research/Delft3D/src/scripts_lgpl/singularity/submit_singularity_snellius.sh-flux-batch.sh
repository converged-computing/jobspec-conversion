#!/bin/bash
#FLUX: --job-name=tst
#FLUX: --exclusive
#FLUX: --queue=thin
#FLUX: -t=3600
#FLUX: --urgency=16

                                #or when a user wants to use all RAM available on the node. In many cases this option can be omitted.
                                #Use of this option makes sense only for multi-node jobs. (See below for more information.)
echo "---Load modules..."
module purge
module load 2022
module load intel/2022a
module load Delft3DFM/2023.01-intel-2022a
modelFolder=${PWD}/../../..
dimrconfigFolder=${PWD}
mdufileFolder=${PWD}
dimrFile=dimr_config.xml
singularityFolder=${EBROOTDELFT3DFM}/bin
PROCESSSTR="$(seq -s " " 0 $((SLURM_NTASKS-1)))"
sed -i "s/\(<process.*>\)[^<>]*\(<\/process.*\)/\1$PROCESSSTR\2/" $dimrFile
mduFile="$(sed -n 's/\r//; s/<inputFile>\(.*\).mdu<\/inputFile>/\1/p' $dimrFile)".mdu
echo ""
echo "Partitioning..."
cd $mdufileFolder
$singularityFolder/execute_singularity_snellius.sh $modelFolder run_dflowfm.sh --partition:ndomains=$SLURM_NTASKS:icgsolver=6 $mduFile
echo ""
echo "Simulation..."
cd $dimrconfigFolder
$singularityFolder/execute_singularity_snellius.sh $modelFolder run_dimr.sh -m $dimrFile
