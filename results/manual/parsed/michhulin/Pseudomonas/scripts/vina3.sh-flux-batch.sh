#!/bin/bash
#FLUX: --job-name=swampy-salad-2287
#FLUX: -t=864000
#FLUX: --priority=16

Usage='vina.sh <input pdbqt> <config> <output dir> <ligand directory>'
f=$1
c=$2
o=$3
lig=$4
singularity exec --overlay /tsl/scratch/hulin/pseudomonas/analysis/autodock/ad_overlay.img /tsl/scratch/hulin/pseudomonas/analysis/autodock/autodock.img vina --receptor $f --ligand $lig   --config $c  --exhaustiveness=32 --out $o
