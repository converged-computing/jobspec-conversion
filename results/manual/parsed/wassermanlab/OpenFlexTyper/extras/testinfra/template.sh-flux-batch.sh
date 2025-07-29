#!/bin/bash
#FLUX --job-name=pusheena-bike-8774
#FLUX --urgency=16

export QT_QPA_PLATFORM='offscreen'

export QT_QPA_PLATFORM='offscreen'
cd $PBS_O_WORKDIR
python tst_paper_results.py
