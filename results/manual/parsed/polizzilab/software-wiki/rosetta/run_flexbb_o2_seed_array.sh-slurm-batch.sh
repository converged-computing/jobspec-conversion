#!/bin/bash
#SBATCH --output=slurm.%x.%A.%a.out
#SBATCH --error=slurm.%x.%A.%a.err
#SBATCH --mail-user=jodymou@mit.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G
#SBATCH --time=00:01:00
#SBATCH --array=1-5

module load gcc/4.8.5
module load rosetta 
PDB="ABCD.pdb"
LIG_PARAMS="LIG.params"
XML_SCRIPT="flexbb.xml"
RESFILE="resfile.txt"
OUTDIR="./"
NSTRUCT=1
/n/app/rosetta/3.13/source/bin/rosetta_scripts.default.linuxgccrelease \
    -database /n/app/rosetta/3.13/database/ \
    -s $PDB \
    -nstruct $NSTRUCT \
    -run:constant_seed \
    -run:jran ${SLURM_ARRAY_TASK_ID} \
    -extra_res_fa $LIG_PARAMS \
    -parser:protocol $XML_SCRIPT \
    -packing:resfile $RESFILE \
    -packing:multi_cool_annealer 10 \
    -packing:linmem_ig 10 \
    -out:path:all $OUTDIR \
    -out:pdb \
    -overwrite \
    -ignore_waters false \
    -beta \
    -water_hybrid_sf \
