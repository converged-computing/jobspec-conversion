#!/bin/bash
#FLUX: --job-name=purple-platanos-4676
#FLUX: --priority=16

export QT_QPA_PLATFORM='offscreen'

export QT_QPA_PLATFORM='offscreen'
cd $PBS_O_WORKDIR
python tst_paper_results.py
