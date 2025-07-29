#!/bin/bash
#SBATCH --job-name=A14run3-2ndcenter-stfid10k-np150-pa3
#SBATCH --account=PEDAL
#SBATCH --output=/lcrc/project/PEDAL/mkrishnamoorthy/maestro/a14app/console/A14run3-2ndcenter-stfid10k-np150-pa3.out
#SBATCH --error=/lcrc/project/PEDAL/mkrishnamoorthy/maestro/a14app/console/A14run3-2ndcenter-stfid10k-np150-pa3.error
#SBATCH --mail-user=mkrishnamoorthy@anl.gov
#SBATCH --mail-type=ALL
#SBATCH --nodes=5
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=6-16:00:00
#SBATCH --partition=bdw
#SBATCH --constraint=ntasks-per-node=36

module purge
source /home/oyildiz/mohan/pythia/pythia8-diy-master/install/bin/latest-160522/rivetenv.sh
spack env activate test
MAESTROLOC="/home/mkrishnamoorthy/maestro"
WD="/lcrc/project/PEDAL/mkrishnamoorthy/maestro/a14app/A14run3-2ndcenter-stfid10k-np150-pa3"
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
cp $PCB/algoparams.json $WD/conf/algoparams.json
cp $PCB/config_workflow.json $WD/conf/config.json
cd $WD || exit
srun -n 180 ./decaf-henson_python
