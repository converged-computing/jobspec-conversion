#!/bin/bash
#FLUX: --job-name=conspicuous-muffin-1235
#FLUX: --queue=short
#FLUX: -t=60
#FLUX: --urgency=16

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
