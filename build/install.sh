#!/usr/bin/env bash
set -e

# Create and use the Python venv
# No --system-site-packages used here because it creates issues with
# packages not being found.
python3 -m venv --system-site-packages /venv

# Clone the git repo of TTS WebUI and set version
git clone https://github.com/rsxdalv/TTS-WebUI.git
cd /TTS-WebUI
git checkout ${TTS_TAG}

# Install the Python dependencies for TTS WebUI
source /venv/bin/activate

# pip > 24.0 is broken due to fairseq
pip3 install --no-cache-dir --upgrade pip==24.0 setuptools

pip3 install --no-cache-dir torch==${TORCH_VERSION} torchaudio torchvision --extra-index-url ${INDEX_URL}
pip3 install --no-cache-dir xformers==${XFORMERS_VERSION}
pip3 install --no-cache-dir torch==$TORCH_VERSION -r requirements.txt
pip3 install --no-cache-dir torch==$TORCH_VERSION git+https://github.com/rsxdalv/extension_bark_voice_clone@main
pip3 install --no-cache-dir torch==$TORCH_VERSION git+https://github.com/rsxdalv/extension_rvc@main
pip3 install --no-cache-dir torch==$TORCH_VERSION git+https://github.com/rsxdalv/extension_audiocraft@main
pip3 install --no-cache-dir torch==$TORCH_VERSION git+https://github.com/rsxdalv/extension_styletts2@main
pip3 install --no-cache-dir torch==$TORCH_VERSION git+https://github.com/rsxdalv/extension_vall_e_x@main
pip3 install --no-cache-dir torch==$TORCH_VERSION git+https://github.com/rsxdalv/extension_maha_tts@main
pip3 install --no-cache-dir torch==$TORCH_VERSION git+https://github.com/rsxdalv/extension_stable_audio@main
pip3 install --no-cache-dir torch==$TORCH_VERSION nvidia-ml-py
deactivate

# Install the NodeJS dependencies for the TTS WebUI
apt -y purge nodejs libnode*
curl -sL https://deb.nodesource.com/setup_22.x -o nodesource_setup.sh
bash nodesource_setup.sh
apt -y install nodejs
cd /TTS-WebUI/react-ui

# Modify package.json to use port 3006
sed -i 's/"start": "next start"/"start": "next start -p 3006"/' package.json
sed -i 's/"start": "next start -p [0-9]*"/"start": "next start -p 3006"/' package.json

npm install
npm run build
