# Migration Plan: Gemini Commands to Antigravity CLI Skills

This plan details the migration of your custom Gemini CLI commands in [.gemini/commands](file:///home/clark/dev/sps_env/.gemini/commands) to be compatible with **Antigravity CLI** (.agents/skills format).

## 1. Directory Structure Mapping
In Antigravity, commands are structured as **Skills**. Each skill resides in its own subdirectory under `.agents/skills/` named after the command (using `sps-<group>-<name>` naming convention), with a `SKILL.md` file inside containing metadata and prompt instructions.

All skills are prefixed with `sps-` to enable easy discovery and autocomplete in the CLI when typing `/sps`.

Here is the proposed mapping of files:

| Original File | Target Location | Skill ID / Frontmatter Name | Description |
| :--- | :--- | :--- | :--- |
| [setup.toml](file:///home/clark/dev/sps_env/.gemini/commands/setup.toml) | `.agents/skills/sps-setup/SKILL.md` | `sps-setup` | Initialize project structure and documentation |
| [discovery/architecture.toml](file:///home/clark/dev/sps_env/.gemini/commands/discovery/architecture.toml) | `.agents/skills/sps-discovery-architecture/SKILL.md` | `sps-discovery-architecture` | Architecture & Technical Discovery (Socratic) |
| [discovery/design.toml](file:///home/clark/dev/sps_env/.gemini/commands/discovery/design.toml) | `.agents/skills/sps-discovery-design/SKILL.md` | `sps-discovery-design` | UX/UI Design Discovery (Socratic) |
| [discovery/product.toml](file:///home/clark/dev/sps_env/.gemini/commands/discovery/product.toml) | `.agents/skills/sps-discovery-product/SKILL.md` | `sps-discovery-product` | Product Discovery (Socratic) |
| [engineer/doc.toml](file:///home/clark/dev/sps_env/.gemini/commands/engineer/doc.toml) | `.agents/skills/sps-engineer-doc/SKILL.md` | `sps-engineer-doc` | Sync code changes back to documentation |
| [engineer/plan.md.toml](file:///home/clark/dev/sps_env/.gemini/commands/engineer/plan.md.toml) | `.agents/skills/sps-engineer-plan/SKILL.md` | `sps-engineer-plan` | Generate a production-ready engineering plan |
| [engineer/test.toml](file:///home/clark/dev/sps_env/.gemini/commands/engineer/test.toml) | `.agents/skills/sps-engineer-test/SKILL.md` | `sps-engineer-test` | Enforce TDD and verify test coverage |
| [engineer/ux.toml](file:///home/clark/dev/sps_env/.gemini/commands/engineer/ux.toml) | `.agents/skills/sps-engineer-ux/SKILL.md` | `sps-engineer-ux` | Generate a UX/UI concept proposal |
| [review/asksenior.toml](file:///home/clark/dev/sps_env/.gemini/commands/review/asksenior.toml) | `.agents/skills/sps-review-asksenior/SKILL.md` | `sps-review-asksenior` | Generate a report for external senior review |
| [review/audit.toml](file:///home/clark/dev/sps_env/.gemini/commands/review/audit.toml) | `.agents/skills/sps-review-audit/SKILL.md` | `sps-review-audit` | Conduct a security, best practice, and performance audit |
| [review/dblchk.toml](file:///home/clark/dev/sps_env/.gemini/commands/review/dblchk.toml) | `.agents/skills/sps-review-dblchk/SKILL.md` | `sps-review-dblchk` | Verify logic, assumptions, and edge cases |
| [utils/commit.toml](file:///home/clark/dev/sps_env/.gemini/commands/utils/commit.toml) | `.agents/skills/sps-utils-commit/SKILL.md` | `sps-utils-commit` | Conventional commit workflow with doc sync |
| [utils/draft-post.toml](file:///home/clark/dev/sps_env/.gemini/commands/utils/draft-post.toml) | `.agents/skills/sps-utils-draft-post/SKILL.md` | `sps-utils-draft-post` | Draft a blog post (Migrated & renamed) |
| [utils/explain.toml](file:///home/clark/dev/sps_env/.gemini/commands/utils/explain.toml) | `.agents/skills/sps-utils-explain/SKILL.md` | `sps-utils-explain` | Explain the next steps before proceeding |
| [utils/stepback.toml](file:///home/clark/dev/sps_env/.gemini/commands/utils/stepback.toml) | `.agents/skills/sps-utils-stepback/SKILL.md` | `sps-utils-stepback` | Analyze the bigger picture when stuck |

---

## 2. File Format and Frontmatter Specifications
Each `.toml` file will be parsed and converted into a `SKILL.md` file.

### TOML Structure (Old)
```toml
description = "Description of command"
prompt = """
Instructions go here.
"""
```

### Markdown Skill Structure (New)
```markdown
---
name: sps-<skill-name>
description: <description-of-skill>
---
# <Command Name Title>

Instructions go here.
```

---

## 3. Administrative and Setup File Updates

We will update the repository's configuration files to reference the new structure and framework:

### A. [install.sh](file:///home/clark/dev/sps_env/install.sh)
- Update `TARGET_DIR` to point to `.agents/skills`.
- Update the download copy block to clone and copy `.agents/skills/` instead of `.gemini/commands/`.
- Update gitignore message and CLI feedback messages to refer to "Skills" instead of "Commands".
- Update autocomplete prefix recommendations.

### B. [README.md](file:///home/clark/dev/sps_env/README.md)
- Re-brand the repository from "Gemini CLI - Generalized Command Suite" to "Antigravity CLI - Generalized Skill Suite".
- Update the directory structure overview to show `.agents/skills/` and explain the new layout.
- Update description of commands to reference skills like `sps-setup`, `sps-discovery-architecture`, etc.

### C. [BOOTSTRAP.md](file:///home/clark/dev/sps_env/BOOTSTRAP.md)
- Update the "Bootstrap Prompt" to check for `.agents/skills` instead of `.gemini/commands`.
- Update the target directory name and instructions for how the user or AI agents install and use these skills.

### D. [link.sh](file:///home/clark/dev/sps_env/link.sh)
- Created a new script to symlink skills locally from `sps_env` to any target project directory, facilitating instant updates during local development.

---

## 4. Post-Migration Cleanup
Once the migration is complete and verified, we will:
1. Delete the legacy `.gemini` folder to keep the repository clean.
2. Delete the legacy `.agents/skills/utils-draft-post` folder (since it is replaced by `sps-utils-draft-post`).
3. Confirm the installation script runs correctly.

> [!IMPORTANT]
> Since skills are context-injected by Antigravity rather than called as `/command` in bash, they are documented to agents automatically in their system prompts/identity blocks.

## 5. Migration Execution Status
- [x] All 15 custom commands converted to markdown skills under `.agents/skills/sps-*`
- [x] Frontmatter metadata generated matching the requested format
- [x] Prefix `sps-` applied to all folders and files for autocomplete compatibility
- [x] Legacy `.gemini/` and old non-prefixed `.agents/skills/utils-draft-post/` folders deleted
- [x] `install.sh`, `README.md`, and `BOOTSTRAP.md` administrative files updated to reference the new structure
- [x] Created `link.sh` to allow local symlinking of skills into other repositories
