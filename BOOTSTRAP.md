# How to Install sps_env Commands

If you are an agent or a user wanting to import these commands into your current project, follow this prompt.

### The Bootstrap Prompt

> "I want to install the 'sps_env' Gemini command suite. 
> 
> 1. First, check if `.gemini/commands` already exists in this project.
> 2. Then, download the installation script: `curl -fsSL https://raw.githubusercontent.com/ssuppe/sps_env/main/install.sh -o install_gemini.sh`.
> 3. If `.gemini/commands` exists, ask me for permission to overwrite it. If I agree, or if it doesn't exist, execute the script: `bash install_gemini.sh` (use `-f` if overwriting).
> 4. After installation, remove the `install_gemini.sh` file and run the `/setup` command to initialize the project documentation."

### Manual Installation

Alternatively, you can run this command directly in your terminal:

```bash
curl -fsSL https://raw.githubusercontent.com/ssuppe/sps_env/main/install.sh | bash
```

*To overwrite existing commands:*
```bash
curl -fsSL https://raw.githubusercontent.com/ssuppe/sps_env/main/install.sh | bash -s -- --force
```
