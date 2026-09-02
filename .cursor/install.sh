#!/usr/bin/env bash
###############################################################################
# Cloud Agent install script for the racf-cert-manager operator collection.
#
# Idempotent bootstrap of the Ansible development toolchain:
#   * an isolated virtualenv with pinned ansible-core, ansible-lint, yamllint
#   * the collection dependencies from collections/requirements.yml
#   * the venv exposed on PATH for interactive shells via ~/.bashrc
###############################################################################
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VENV_DIR="${VENV_DIR:-$HOME/.venv/racf}"

echo "==> Ensuring python venv support is available"
if ! python3 -c "import ensurepip" >/dev/null 2>&1; then
  sudo apt-get update -qq
  sudo apt-get install -y -qq python3-venv "python$(python3 -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')-venv"
fi

echo "==> Creating virtualenv at ${VENV_DIR}"
if [ ! -x "${VENV_DIR}/bin/python" ]; then
  python3 -m venv "${VENV_DIR}"
fi

echo "==> Installing pinned Python dev tooling"
# shellcheck disable=SC1091
source "${VENV_DIR}/bin/activate"
pip install --quiet --upgrade pip
pip install --quiet -r "${REPO_ROOT}/.cursor/requirements-dev.txt"

echo "==> Exposing venv on PATH for interactive shells"
MARKER="# >>> racf-cert-manager venv >>>"
if ! grep -qF "${MARKER}" "$HOME/.bashrc" 2>/dev/null; then
  {
    echo ""
    echo "${MARKER}"
    echo "export PATH=\"${VENV_DIR}/bin:\$PATH\""
    echo "# <<< racf-cert-manager venv <<<"
  } >> "$HOME/.bashrc"
fi

echo "==> Installing collection dependencies"
ansible-galaxy collection install -r "${REPO_ROOT}/collections/requirements.yml"

echo "==> Verifying toolchain"
ansible --version | head -1
ansible-lint --version | head -1
yamllint --version

echo "==> install.sh complete"
