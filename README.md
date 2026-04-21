# Second Brain — Team Knowledge Base

An AI-powered personal knowledge base. Drop raw source material in `raw/`, tell your AI agent to **"compile"**, and it synthesises structured wiki articles, maintains indexes, and marks sources as done. Query the knowledge base in plain English at any time.

---

## Prerequisites

| Tool | Purpose |
|---|---|
| [Obsidian](https://obsidian.md) | Vault interface and note viewer |
| AI coding agent (OpenCode, Cursor, or Claude Code) | Compiles and queries the knowledge base |
| Python 3 + `pdfplumber` | Single-PDF extraction script |
| `poppler` (`pdftotext`) | Batch PDF extraction script |

---

## Setup

### 1. Clone and open the vault

```bash
git clone <your-repo-url> my-second-brain
```

Open Obsidian → **Open folder as vault** → select the cloned folder.

### 2. Install community plugins

In Obsidian: **Settings → Community plugins → Turn on community plugins → Browse**

Install and enable all four:

| Plugin ID | Name | Purpose |
|---|---|---|
| `terminal` | Obsidian Terminal | Built-in terminal inside Obsidian |
| `obsidian-tasks-plugin` | Tasks | Task management across notes |
| `obsidian-local-images-plus` | Local Images Plus | Downloads and localises web images |
| `marp-slides` | Marp Slides | Render Markdown notes as presentations |

### 3. Configure your AI agent

No extra configuration needed — the agent instructions live in `AGENTS.md` at the vault root.

| Agent | Reads |
|---|---|
| OpenCode, Cursor, and most agents | `AGENTS.md` automatically |
| Claude Code | `CLAUDE.md` → which imports `AGENTS.md` |

Open your agent from the vault root directory.

### 4. Set up PDF extraction (optional)

```bash
# Single-file extraction (Python)
pip install pdfplumber

# Batch extraction (shell)
brew install poppler   # macOS
```

---

## How to use

### Compile new content

1. Drop files (`.md`, `.txt`, `.pdf`) into `raw/`
2. Open your AI agent and say: **"compile"**
3. The agent will:
   - Read each unprocessed file in `raw/`
   - Categorise it into the right topic (or create a new one)
   - Write a wiki article under `wiki/<topic>/`
   - Update `wiki/<topic>/_index.md` and `wiki/_master-index.md`
   - Rename the raw file with a `.compiled_` prefix to mark it done

### Query the knowledge base

Ask your AI agent a question in plain English. It will navigate the wiki indexes and synthesise an answer from the relevant articles.

> "What are the trade-offs between Supabase Auth and Clerk?"
> "Summarise everything I know about multi-agent orchestration."

### Audit the wiki

Say **"audit"** or **"lint"** — the agent reviews the wiki for inconsistencies, missing cross-links, and gaps in coverage, then suggests improvements without making changes until you confirm.

### Process PDFs

**Option A** — drop the PDF in `raw/` and say "compile" (the agent uses the pdf-extraction skill).

**Option B** — run the batch extraction script:

```bash
# Extract all PDFs in raw/ to .md files
bash scripts/extract_pdfs.sh
```

**Option C** — extract a single PDF:

```bash
python scripts/extract_pdf.py raw/my-document.pdf
```

---

## Folder structure

```
raw/         ← Drop source material here (the inbox)
wiki/        ← AI-compiled knowledge base
  _master-index.md   ← entry point listing all topics
  <topic>/
    _index.md        ← topic table of contents
    <article>.md     ← individual articles
output/      ← Query results and generated reports
archive/     ← Original PDFs after text extraction
attachment/  ← Images and media (managed by Obsidian)
project/     ← Project-specific working folders
scripts/     ← Utility scripts for PDF extraction
```

---

## Wiki conventions

- Cross-reference related notes with `[[wiki links]]`
- File names: `lowercase-with-hyphens.md`
- Keep articles concise — bullet points over paragraphs
- Every article must have a `## Key Takeaways` section
- Each topic folder has its own `_index.md` listing all articles

---

## How files get marked as done

The `.compiled_` prefix is the agent's "done" marker. A file named `my-article.md` becomes `.compiled_my-article.md` after processing. The agent skips any file already prefixed with `.compiled_`.

This preserves the original source without deleting it, keeping it searchable.

---

## Credits

This system and prompts are based on:

- **Chase AI Community** — [Second Brain classroom lesson](https://www.skool.com/chase-ai-community/classroom/4fe79bd0?md=0f0e5f837fdc4760aa100b35a85c6498)
- **Andrei Karpathy** — [original concept post on X](https://x.com/karpathy/status/2039805659525644595)
