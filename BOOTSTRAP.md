# How to Install sps_env Skills

If you are an agent or a user wanting to import these skills into your current project, follow this prompt.

### The Bootstrap Prompt

> "I want to install the 'sps_env' Antigravity skill suite. 
> 
> 1. First, check if `.agents/skills` already exists in this project.
> 2. Then, download the installation script: `curl -fsSL https://raw.githubusercontent.com/ssuppe/sps_env/main/install.sh -o install_skills.sh`.
> 3. Check if this is a public repository or if I would prefer to keep these skills private. Ask me if I want to add `.agents/skills` to `.gitignore`.
> 4. If `.agents/skills` exists, ask me for permission to overwrite it. 
> 5. Execute the script: `bash install_skills.sh`. Use `-f` if overwriting, and `-i` if I want to add it to `.gitignore`.
> 6. After installation, remove the `install_skills.sh` file and run the `sps-setup` skill to initialize the project documentation."

### Manual Installation

To install this suite into an existing project, run the following command in your project's root directory:

```bash
curl -fsSL https://raw.githubusercontent.com/ssuppe/sps_env/main/install.sh | bash
```

*To overwrite existing skills:*
```bash
curl -fsSL https://raw.githubusercontent.com/ssuppe/sps_env/main/install.sh | bash -s -- --force
```

*To automatically add to .gitignore:*
```bash
curl -fsSL https://raw.githubusercontent.com/ssuppe/sps_env/main/install.sh | bash -s -- --ignore
```

### Local Symlinking (Development Mode)

If you are developing locally and want changes made in the `sps_env` repo to be immediately reflected in your project without having to re-install, run the `link.sh` script from the root of your target project:

```bash
cd ../myproject
bash /home/clark/dev/sps_env/link.sh
```
