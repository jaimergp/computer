#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "utils.sh" \
    && . "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#!/bin/bash

PKG_VERSION="1.13.1"

[[ $ARCH = 32 ]] && echo "32-bit builds are not supported anymore" && exit 1;

_file="chimera-${PKG_VERSION}-linux_x86_64.bin"
_filepath="linux_x86_64/${_file}"
_hash="80d2c95f78c603da3acda42f4bbceca0" # v1.13.1
_agent="Mozilla/5.0 (X11; Linux x86_64; rv:64.0) Gecko/20100101 Firefox/64.0"


_downloader="https://www.rbvi.ucsf.edu/chimera/cgi-bin/secure/chimera-get.py"

download(){
  _download=$(command curl -A "${_agent}" -F file=${_filepath} -F choice=Accept "${_downloader}" | grep href | sed -E 's/.*href="(.*)">/\1/');
  sleep 3;
  command curl -A "${_agent}" "https://www.cgl.ucsf.edu${_download}" -o "${_file}";
}

download_retry(){
  n=0;
  until [ $n -ge 10 ]; do
    download;
    echo "${_hash}  ${_file}" | md5sum -c --strict --quiet && break;
    n=$((n+1));
    sleep 3;
  done;
  echo "${_hash}  ${_file}" | md5sum -c --strict --quiet || exit 1;
}

installation_linux() {
  chmod +x "${_file}";
  echo "$1/UCSF-Chimera-${PKG_VERSION}" | sudo "./${_file}";
}


set +x
echo 'IMPORTANT: By downloading you accept the UCSF Chimera Non-Commercial Software License Agreement!'
echo 'IMPORTANT: The license agreement can be found here: http://www.cgl.ucsf.edu/chimera/license.html'
echo 'IMPORTANT: If you do not agree, please press Ctrl-C now.'
echo 'IMPORTANT: Downloading in 10 seconds...'
sleep 10
set -x

download_retry
installation_linux "/opt"
sudo ln -s "/opt/UCSF-Chimera-${PKG_VERSION}/bin/chimera" "/usr/local/bin/chimera"
