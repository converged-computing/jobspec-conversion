#!/bin/bash
#FLUX: --job-name=A14run3-2ndcenter-oneshot-np150-pa3
#FLUX: -N=5
#FLUX: --queue=bdw
#FLUX: -t=360000
#FLUX: --urgency=16

module purge
source /home/oyildiz/mohan/pythia/pythia8-diy-master/install/bin/latest-160522/rivetenv.sh
spack env activate test
MAESTROLOC="/home/mkrishnamoorthy/maestro"
WD="/lcrc/project/PEDAL/mkrishnamoorthy/maestro/a14app/A14run3-2ndcenter-oneshot-np150-pa3"
WFLOC="/home/mkrishnamoorthy/maestro/workflow/a14app"
PCB="/home/mkrishnamoorthy/maestro/parameter_config_backup/a14app"
rm -rf $WD/log
mkdir -p $WD
mkdir -p $WD/conf
cp $WFLOC/decaf-henson.json $WD/decaf-henson.json
cp /home/oyildiz/mohan/pythia/pythia8-diy-master/install/bin/latest-160522/decaf-henson_python $WD/.
cp $PCB/*.cmnd $WD/conf/.
cp $PCB/data.json $WD/conf/.
cp $PCB/weights $WD/conf/.
cp $MAESTROLOC/maestro/optimizationtask $WD/optimizationtask.py
cp $PCB/algoparams_oneshot.json $WD/conf/algoparams.json
cp $PCB/config_workflow.json $WD/conf/config.json
cd $WD || exit
srun -n 180 ./decaf-henson_python
