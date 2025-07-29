#!/bin/bash
#SBATCH --job-name=phyluce_trinity_ab
#SBATCH --mail-user=jsatler@iastate.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --time=5-00:00:00

source activate phyluce
module unuse /opt/rit/spack-modules/lmod/linux-rhel7-x86_64/Core
module use /opt/rit/modules
module load java/1.7.0_55
module load bowtie/1.1.2
phyluce_assembly_assemblo_trinity \
    --conf /ptmp/LAS/phylo-lab/jsatler/phyluce/assembly_conf/assembly_rd23_ab.conf \
    --output /ptmp/LAS/phylo-lab/jsatler/phyluce/trinity-assemblies \
    --clean \
    --cores 16
