# Codeling CLI Installer

This repository contains the installation script for the [Codeling](https://codeling.dev) CLI.

The CLI allows you to submit lessons and run tests for local courses straight from your terminal.

## Installation

### 1. Install the CLI

To install the Codeling CLI, run the following command in your terminal:

```bash
curl -sSL https://raw.githubusercontent.com/codelingdotdev/cli_installer/refs/heads/main/src/install.sh | bash
```

### 2. Verify installation

After installation completes, verify it's working by running:

```bash
codeling version
```

You should see the current CLI version printed to your terminal.

### 3. Login

Run `codeling login` to authenticate your Codeling account.

You'll be prompted to enter your auth key which you an find on your [Codeling Profile](https://app.codeling.dev/profile).

## Usage

While working on any local Codeling Course, navigate to the project folder, eg:

```bash
cd my_projects/course_rest_design_python_init/
```

When you're ready to submit a lesson:
- run `codeling submit` which will run tests against your code.
- If the tests pass, the lesson will be marked as complete in your Codeling account.
- If the tests fail, read the test output to determine what needs to be fixed in your code.

Once the tests have passed, you can move to the next lesson on the [Codeling Platform](https://app.codeling.dev).

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

Then restart your terminal or `source` your configuration file as outlined above.