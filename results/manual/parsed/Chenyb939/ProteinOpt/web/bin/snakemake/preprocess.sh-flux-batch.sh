#!/bin/bash
#FLUX: --job-name=preprocess
#FLUX: --priority=16

snakemake -s preprocess.smk -j 32
