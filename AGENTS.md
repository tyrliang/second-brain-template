# Knowledge Base — Vault Conventions

## Vault Structure
- /raw — source material, clipped articles, research (the input zone)
- /wiki — LLM-compiled knowledge base (see Wiki System below)
- /output — query results and generated reports
- /scripts — utility scripts for automation and processing

## Wiki System
You are the librarian of the wiki/ folder. You write and maintain everything in it.

### Structure
- wiki/_master-index.md is the entry point — lists every topic with a one-line description.
- Each topic gets its own subfolder with its own _index.md listing all articles.

### Compiling
When I say "compile" or dump new material in raw/:
1. Read each raw file (skip any already prefixed with `.compiled_`)
2. Decide which topic it belongs to (or create a new topic folder)
3. Write a wiki article with key takeaways and [[wiki links]] to related concepts
4. Update that topic's _index.md
5. Update wiki/_master-index.md
6. If a raw file spans multiple topics, create articles in both and cross-link
7. Rename the raw file with a `.compiled_` prefix (e.g. `foo.md` → `.compiled_foo.md`) to mark it as done

### PDF Processing
When encountering PDF files in raw/:
1. Use pdf-extraction skill to extract text from the PDF
2. Save extracted text as `<filename>.compiled.md` in raw/
3. Compile the .compiled.md file as normal (steps 1-6 above)
4. Move the original PDF to archive/ folder
5. The .compiled.md file remains in raw/ as the searchable source

### Querying
When answering questions against the knowledge base:
1. Read wiki/_master-index.md first to find the right topic
2. Read that topic's _index.md to find relevant articles
3. Read the specific articles
4. Synthesize the answer

### Auditing
When I say "audit" or "lint", review the wiki for:
- Inconsistent or contradictory information
- Missing cross-links between related concepts
- Gaps in coverage
- Suggest improvements, but don't make changes without confirmation

## Conventions
- Always use [[wiki links]] when referencing other notes
- File names: lowercase with hyphens (e.g., ai-agent-overview.md)
- Keep articles concise — bullet points over paragraphs
- Always include a ## Key Takeaways section in wiki articles
