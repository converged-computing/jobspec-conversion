#!/bin/bash
#SBATCH --job-name=phyluce_trinity_ba
#SBATCH --mail-user=kevinq@iastate.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=50G
#SBATCH --time=9-00:00:00
#SBATCH --constraint=ntasks-per-node=16

source activate phyluce162
​
module unuse /opt/rit/spack-modules/lmod/linux-rhel7-x86_64/Core
module use /opt/rit/modules
​
module load java/1.7.0_55
module load bowtie/1.1.2
​
​
phyluce_assembly_assemblo_trinity \
    --conf /ptmp/kevinq/assembly_conf/assembly_Feb2020_ba.conf \
    --output /ptmp/kevinq/trinity-assemblies \
    --log /ptmp/kevinq/logs \
    --clean \
    --cores 16
