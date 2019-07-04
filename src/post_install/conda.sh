#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Configuring conda\n\n"

. /opt/miniconda/etc/profile.d/conda.sh

execute "conda activate" "Activate base environment"
execute "sudo /opt/miniconda/bin/conda update -q -y --all" "Update base packages"
execute "sudo /opt/miniconda/bin/conda install -q -y jupyterlab matplotlib pandas numpy scipy" \
    "Install PyData packages"