#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

. /opt/miniconda/etc/profile.d/conda.sh

conda activate
conda update -q -y --all
conda install -q -y jupyterlab matplotlib pandas numpy scipy