#!/usr/bin/env bash
set -e

# Create and use the Python venv
# No --system-site-packages used here because it creates issues with
# packages not being found.
python3 -m venv /venv

# Clone the git repo of TTS WebUI and set version
git clone https://github.com/rsxdalv/TTS-WebUI.git
cd /TTS-WebUI
git checkout ${TTS_TAG}

# Install the Python dependencies for TTS WebUI
source /venv/bin/activate

pip3 install --no-cache-dir --upgrade pip setuptools wheel

pip3 install --no-cache-dir torch==${TORCH_VERSION} torchaudio==${TORCH_VERSION} torchvision --extra-index-url ${INDEX_URL}
pip3 install --no-cache-dir xformers==${XFORMERS_VERSION}
pip3 install --no-cache-dir torch==$TORCH_VERSION -r requirements.txt
pip3 install --no-cache-dir "tts-webui-extension.bark_voice_clone>=0.0.2" --extra-index-url https://tts-webui.github.io/extensions-index/
pip3 install --no-cache-dir "tts-webui-extension.rvc>=0.0.6" --extra-index-url https://tts-webui.github.io/extensions-index/
pip3 install --no-cache-dir "tts-webui-extension.styletts2>=0.1.0" --extra-index-url https://tts-webui.github.io/extensions-index/
deactivate

# Install the NodeJS dependencies for the TTS WebUI
apt -y purge nodejs libnode*
curl -sL https://deb.nodesource.com/setup_22.x -o nodesource_setup.sh
bash nodesource_setup.sh
apt -y install nodejs
cd /TTS-WebUI/react-ui

npm install
npm run build
