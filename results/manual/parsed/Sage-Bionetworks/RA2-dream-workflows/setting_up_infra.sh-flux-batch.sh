#!/bin/bash
#FLUX: --job-name=test
#FLUX: --queue=pascalnodes
#FLUX: -t=7200
#FLUX: --urgency=16

export WES_API_HOST='localhost:8082'
export WES_API_AUTH='Header: value'
export WES_API_PROTO='http'

module load Anaconda3
conda create --name cwl python=3
source activate cwl
pip install wes-service --user
pip install cwltool --user
pip install Cython --user
pip install pyslurm --user
screen -S wes
source ~/.bash_profile
source activate cwl
export WES_API_HOST=localhost:8082
export WES_API_AUTH='Header: value'
export WES_API_PROTO=http
wes-server --backend=wes_service.cwl_runner --opt runner=cwltool --opt extra=--singularity --opt extra=--cachedir=$USER_DATA/cache_workflows/ --port 8082
git clone https://github.com/common-workflow-language/workflow-service.git
cd workflow-service
wes-client --info
wes-client --attachments="testdata/dockstore-tool-md5sum.cwl,testdata/md5sum.input" testdata/md5sum.cwl testdata/md5sum.cwl.json --no-wait
wes-client --attachments="testtool.cwl,testtool.json" testtool.cwl testtool.json --no-wait
wes-client --list
git clone https://github.com/Sage-Bionetworks/ChallengeWorkflowTemplates.git
cd ChallengeWorkflowTemplates
wes-client scoring_harness_workflow.cwl scoring_harness_workflow.yaml  --attachments="download_submission_file.cwl,validate_email.cwl,validate.cwl,score.cwl,score_email.cwl,download_from_synapse.cwl,check_status.cwl,annotate_submission.cwl" --no-wait
screen -S syn
source ~/.bash_profile
source ~/.env
java -jar WorkflowOrchestrator-1.0-SNAPSHOT-jar-with-dependencies.jar 
module load Singularity/2.6.1-GCC-5.4.0-2.26
singularity exec --net --no-home --bind /cm/local/apps/cuda/libs --nv -B /data/project/RA2_DREAM/train:/train:ro -B /data/project/RA2_DREAM/test_leaderboard:/test:ro -B $HOME/test:/output:rw docker://docker.synapse.org/syn20545112/example-model@sha256:6cc6dd92462b946fe5fbe0020055e63ce712c70e70fc327207cca6b26954b823 /run.sh
