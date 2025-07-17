#!/bin/bash
#FLUX: --job-name=CBASS
#FLUX: --queue=scavenge
#FLUX: --urgency=16

export FOLDER='$(pwd) # Considering that the scheduler is in the same folder of the .m script being used, otherwise specify the path as '=/gpfs/ysm/home/ahf38/Documents/gamma_bouts/Demo/'
export ScriptName='CBASS_Call_Main_AF.m' # Matlab script to be used for the analysis'

<<COMMENT
This scheduler script allows the parallel deployment of several experimental conditions to be tested, such that each tested is assigned to an independent node of the cluster.
The settings that might need to be adjusted are listed below:
- 'FOLDER':         This variable indicates the path to the matlab script to be used for the analisys. By default, the scheduler script (this) and the matlab script are 
                    considered to be in the same directory, but it needs to be specified if otherwise.
- 'ScriptName':     It is specifies the Matlab script and specs of the processing node to be created for the analysis.
- 'String_' :       The list of experimental variables to be tested is passed as string arrays. These settings must be matching with the Matlab script. 
                    Thus, when using the bash scrit to deploy jobs, make sure to uncomment the approproate variables in the Matlab script. 
                    See /Demo/CBASS_Call_Main_AF.m for an example.
- 'cluster_test.sh': the scheduler calls for the 'cluster_test', which is responsible for creating and assigning the job to a node in the cluster. 
                    Check its heading for further details.
COMMENT
export FOLDER=$(pwd) # Considering that the scheduler is in the same folder of the .m script being used, otherwise specify the path as '=/gpfs/ysm/home/ahf38/Documents/gamma_bouts/Demo/'
export ScriptName='CBASS_Call_Main_AF.m' # Matlab script to be used for the analysis
FOLDER_LOGS="$FOLDER/Logs"
if [ ! -d "$FOLDER_LOGS" ]; then
    echo "creating $FOLDER_LOGS."
    mkdir -p $FOLDER_LOGS
fi
declare -a StringBandLabel=("Beta" "Gamma")
declare -a StringBands=("[15,30]" "[30,80]")
declare -a StringStateLabel=("Stim" "Running");  
declare -a StringcFormat=("complex" "polar");  
declare -a Stringcbl1ZScore=("true" "false");  
INDEX=0
for bandLabel in ${StringBandLabel[@]}; do
    for stateLabel in ${StringStateLabel[@]}; do
        for cFormat in ${StringcFormat[@]}; do
        	for bl1ZScore in ${Stringcbl1ZScore[@]}; do
	            OUT0=$(sbatch -p scavenge --requeue --chdir=${FOLDER_LOGS} --parsable -J $bandLabel$stateLabel$cFormat$bl1ZScore -o $bandLabel$stateLabel$cFormat$bl1ZScore.stdout.txt -e $bandLabel$stateLabel$cFormat$bl1ZScore.stderr.txt cluster_test.sh ${bandLabel} ${StringBands[$INDEX]} ${stateLabel} $cFormat $bl1ZScore) 
                #${folder_name} ${script_name})
	        done
        done
    done
    let INDEX=${INDEX}+1
done
sleep 1 # pause to be kind to the scheduler
