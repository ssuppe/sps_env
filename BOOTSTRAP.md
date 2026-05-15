# How to Install sps_env Commands

If you are an agent or a user wanting to import these commands into your current project, follow this prompt.

### The Bootstrap Prompt

> "I want to install the 'sps_env' Gemini command suite. 
> 
> 1. First, check if `.gemini/commands` already exists in this project.
> 2. Then, download the installation script: `curl -fsSL https://raw.githubusercontent.com/ssuppe/sps_env/main/install.sh -o install_gemini.sh`.
> 3. Check if this is a public repository or if I would prefer to keep these commands private. Ask me if I want to add `.gemini/commands` to `.gitignore`.
> 4. If `.gemini/commands` exists, ask me for permission to overwrite it. 
> 5. Execute the script: `bash install_gemini.sh`. Use `-f` if overwriting, and `-i` if I want to add it to `.gitignore`.
> 6. After installation, remove the `install_gemini.sh` file and run the `/setup` command to initialize the project documentation."

### Manual Installation
...
*To overwrite existing commands:*
```bash
curl -fsSL https://raw.githubusercontent.com/ssuppe/sps_env/main/install.sh | bash -s -- --force
```

*To automatically add to .gitignore:*
```bash
curl -fsSL https://raw.githubusercontent.com/ssuppe/sps_env/main/install.sh | bash -s -- --ignore
```

```

*To overwrite existing commands:*
```bash
curl -fsSL https://raw.githubusercontent.com/ssuppe/sps_env/main/install.sh | bash -s -- --force
```
