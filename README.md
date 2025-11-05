# Codeling CLI Installer

This repository contains the installation script for the Codeling CLI.

## Installation

To install the Codeling CLI, run the following command in your terminal:

```bash
curl -sSL https://raw.githubusercontent.com/codelingdotdev/cli_installer/refs/heads/main/src/install.sh | bash
```

After installation completes, verify it's working by running:

```bash
codeling version
```

You should see the current CLI version printed to your terminal.

## Usage

The Codeling CLI provides the following commands:

### submit

Running submit in a Codeling course folder will run tests against your current lesson for that course. If all tests pass, the lesson will be flagged as complete within the Codeling Web Platform.

```bash
codeling submit
```

### version

Outputs the current CLI version. When a new version is available, you will be prompted to install it.

```bash
codeling version
```

## Troubleshooting

### Command not found after installation

If you see `command not found: codeling` after installation, the CLI binary is installed but your shell hasn't loaded the updated PATH yet. Try one of these solutions:

**Option 1: Restart your terminal**

Close and reopen your terminal window.

**Option 2: Source your shell configuration**

For **zsh** (default on macOS):
```bash
source ~/.zshrc
```

For **bash** on macOS:
```bash
source ~/.bash_profile
```

For **bash** on Linux (including Windows Subsystem for Linux):
```bash
source ~/.bashrc
```

After sourcing or restarting, try running `codeling version` again.

### Verify installation location

The CLI is installed to `~/codeling/bin/codeling`. You can verify it exists:

```bash
ls -la ~/codeling/bin/codeling
```

If the file exists but the command still doesn't work, manually add it to your PATH by adding this line to your shell configuration file:

```bash
export PATH="$HOME/codeling/bin:$PATH"
```