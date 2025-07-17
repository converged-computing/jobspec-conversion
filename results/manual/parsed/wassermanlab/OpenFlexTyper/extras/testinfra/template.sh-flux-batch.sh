#!/bin/bash
#FLUX: --job-name=loopy-malarkey-4550
#FLUX: --urgency=16

export QT_QPA_PLATFORM='offscreen'

export QT_QPA_PLATFORM='offscreen'
cd $PBS_O_WORKDIR
python tst_paper_results.py
