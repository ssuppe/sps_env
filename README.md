# Antigravity CLI - Generalized Skill Suite

A collection of structured, lifecycle-aware skills for the Antigravity CLI agent. This repository provides a portable "toolbox" and "workshop" for software development, from product discovery to production-ready implementation.

All skills are prefixed with `sps-` to enable easy discovery and autocomplete in the CLI (simply type `/sps` to view them).

## 📂 Structure

The skills are organized by their stage in the Software Development Life Cycle (SDLC):

- **`sps-setup`**: Root skill to initialize a new repository with standardized `docs/` folders and a generalized development process.
- **`sps-letsgo`**: Context loader and implementation preparer.
- **`sps-uprdux`**: Documentation synchronization helper for main/design docs.
- **Discovery**: Socratic tools for interactive discovery of product requirements (`sps-product`), UX design (`sps-design`), and technical architecture (`sps-architecture`).
- **Execution**: Execution tools for technical planning (`sps-plan`), TDD enforcement (`sps-test`), UX concept generation (`sps-ux`), and documentation synchronization (`sps-doc`).
- **Verification**: Verification tools for security audits (`sps-audit`), logic double-checks (`sps-dblchk`), and generating reports for senior review (`sps-asksenior`).
- **Workflow Utilities**: Workflow utilities for conventional commits (`sps-commit`), blog post drafting (`sps-draft-post`), loop-breaking (`sps-stepback`), and forced explanations (`sps-explain`).

## 🚀 Quick Installation

To install this suite into an existing project, run the following command in your project's root directory:

```bash
curl -fsSL https://raw.githubusercontent.com/ssuppe/sps_env/main/install.sh | bash
```

For more detailed instructions and a prompt to help Antigravity automate the installation, see [BOOTSTRAP.md](./BOOTSTRAP.md).

### 🔗 Local Development (Symlinking)

If you are developing locally and want to reference these skills without downloading them into your project (so that modifications here are instantly reflected), run the helper script from the root of your target project:

```bash
cd ../myproject
bash /home/clark/dev/sps_env/link.sh
```

## 🛠 Documentation Standards

All skills are generalized to prioritize context from the following locations:
- `docs/pm/`: Product requirements and PRDs.
- `docs/design/`: UX concepts and interaction flows.
- `docs/eng/`: Technical designs and the development process.
- `README.md`: Project overview.

## 📜 Development Process

The suite enforces a high-standard development process including:
- **TDD (Test Driven Development)**
- **Conventional Commits**
- **Automated Quality Gates**
- **Security-First Audits**
