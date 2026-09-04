# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Automated Docker image build workflow (`.github/workflows/build-docker-image.yml`) copied from `facefusion-docker` to build and push to `ghcr.io` on pushes to `main` that modify `docker-bake.hcl` and on manual dispatch (`workflow_dispatch`) at `.github/workflows/build-docker-image.yml:1`
- `RELEASE_SUFFIX` variable in `docker-bake.hcl:17` for optional tag suffixes (e.g. `-cuda128`) and updated default tag to `${RELEASE}${RELEASE_SUFFIX}` at `docker-bake.hcl:43`
- SBOM generation, provenance attestations, image verification, and job summary steps in the build workflow

### Changed
- Bumped GitHub Actions to latest major versions in `build-docker-image.yml`: `actions/checkout@v4` -> `@v7` (v7.0.1, 2026-07-20), `docker/setup-buildx-action@v3` -> `@v4` (v4.3.0, 2026-08-19), `docker/login-action@v3` -> `@v4` (v4.6.0, 2026-07-29), `actions/upload-artifact@v4` -> `@v7` (v7.0.1, 2026-04-10), retained `anchore/sbom-action@v0` (v0.24.2, 2026-08-28) on latest `v0` track
- `docker-bake.hcl` now supports `RELEASE_SUFFIX` handling consistent with `facefusion-docker`'s bake file for GHCR tagging via `docker-bake.override.hcl`

## [v1.5.1] - 2026-05-15

### Added
- Support for TTS-WebUI v1.5.1 with extended model coverage (Ace-Step, Kimi Audio, Piper TTS, GPT-SoVITS, CosyVoice, XTTSv2, DIA, Kokoro, OpenVoice, ParlerTTS, Stable Audio, MMS, StyleTTS2, MAGNet, AudioGen, MusicGen, Tortoise, RVC, Vocos, Demucs, SeamlessM4T, Bark)

### Changed
- Upgraded Torch to 2.11.0, xformers to 0.0.35, CUDA 12.8, Python 3.11.12, base image `ashleykza/runpod-base:2.4.19`
- Dropped `transformers<5.0.0` pin and removed orphan `tortoise` mkdir in `build/install.sh`

### Fixed
- `scripts/stop_tts.sh` now kills v1.5.1 ports 7767 and 7770
- `nginx/nginx.conf` forwards `X-Forwarded-Host` so Gradio builds correct file URLs
- Docs: wrap Docker Hub and Runpod badges with links and switch deploy URL to `console.runpod.io/explore`

## [v1.4.1] - 2026-04-27

### Changed
- Unified version variables and prefixed release with `v` tag (`v1.4.1`)

## [v1.1.0] - 2026-04-06

### Changed
- Upgraded TTS-WebUI to v1.1.0, PyTorch 2.11.0

### Fixed
- Pinned `transformers<5.0.0` for `tortoise-tts` compatibility

## [v0.3.0] - 2025-11-21

### Changed
- Bumped base image to 2.4.9
- Updated `tts_webui_extension.audiocraft` to 0.0.5 (fix for 0.0.4 regression)

## [2.4.8] - 2025-10-14

### Added
- Application Manager with React UI, persistent venv support, `ffmpeg` and audio libs (`libav*`, `pkg-config`) in `Dockerfile:10`
- Port fixes for app-manager and nginx

### Changed
- Base image 2.4.8

## [2.4.5] - 2025-09-29

### Added
- Content Security Policy `upgrade-insecure-requests`, persistent venv sync handling for Runpod network volumes

### Changed
- CUDA 12.8, Torch 2.7.0, xformers 0.0.30, base image 2.4.5

### Fixed
- Nginx mixed-content and config fixes, typo corrections

## [2.4.2] - 2025-05-18

### Changed
- CUDA 12.4, Python 3.11, Torch 0.0.29.post3, xformers 0.0.29.post3, Node.js 22, base image 2.4.2

## [2.2.3] - 2024-07-31

### Changed
- Base image 2.2.3, improved venv syncing, bumped TTS Generation WebUI to latest commit

## [2.2.1] - 2024-07-30

### Changed
- Torch 2.4.0, xformers 0.0.27.post2, base image 2.2.1

## [2.0.0] - 2024-07-15

### Changed
- Base image 2.0.0, latest TTS Generation WebUI commit, Stable Audio updates

## [1.7.0] - 2024-07-02

### Added
- `code-server`, keep venv on container disk instead of syncing

### Changed
- Base image 1.7.0

[Unreleased]: https://github.com/ashleykleynhans/tts-webui-docker/compare/v1.5.1...HEAD
[v1.5.1]: https://github.com/ashleykleynhans/tts-webui-docker/compare/v1.4.1...v1.5.1
[v1.4.1]: https://github.com/ashleykleynhans/tts-webui-docker/compare/v1.1.0...v1.4.1
[v1.1.0]: https://github.com/ashleykleynhans/tts-webui-docker/compare/5.1.3...v1.1.0
