#!/bin/bash
#FLUX: --job-name=preprocess
#FLUX: --urgency=16

snakemake -s preprocess.smk -j 32
