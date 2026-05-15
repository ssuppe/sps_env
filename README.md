# Gemini CLI - Generalized Command Suite

A collection of structured, lifecycle-aware commands for the Gemini CLI agent. This repository provides a portable "toolbox" and "workshop" for software development, from product discovery to production-ready implementation.

## 📂 Structure

The commands are organized by their stage in the Software Development Life Cycle (SDLC):

- **`/setup`**: Root command to initialize a new repository with standardized `docs/` folders and a generalized development process.
- **`discovery/`**: Socratic tools for interactive discovery of product requirements, UX design, and technical architecture.
- **`engineer/`**: Execution tools for technical planning, TDD enforcement, UX concept generation, and documentation synchronization.
- **`review/`**: Verification tools for security audits, logic double-checks, and generating reports for senior review.
- **`utils/`**: Workflow utilities for conventional commits, loop-breaking, and forced explanations.
## 🚀 Quick Installation

To install this suite into an existing project, run the following command in your project's root directory:

```bash
curl -fsSL https://raw.githubusercontent.com/ssuppe/sps_env/main/install.sh | bash
```

For more detailed instructions and a prompt to help Gemini automate the installation, see [BOOTSTRAP.md](./BOOTSTRAP.md).

## 📂 Structure
## 🛠 Documentation Standards

All commands are generalized to prioritize context from the following locations:
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
