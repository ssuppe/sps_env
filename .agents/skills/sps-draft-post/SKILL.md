---
name: sps-draft-post
description: Draft a new blog post in the workspace's posts directory using structured user input.
---
# Draft Blog Post

1. Check the local time and timezone offset to determine the current date.
2. Ask the user for the blog post information (Post Title, Project Tag, and Key Highlights/Outline). Use the `ask_question` tool if available, or ask directly in the chat.
3. Determine the correct output file path under `content/posts/YYYY-MM-DD-slug.md` (where YYYY-MM-DD is today's local date and slug is a URL-friendly version of the title).
4. Create the new file with standard Frontmatter:
   ```yaml
   ---
   title: "Post Title"
   date: YYYY-MM-DDTHH:MM:SSZ
   tags: ["project-tag"]
   draft: true
   ---
   ```
5. Write an initial draft for the post using the key highlights, maintaining a clean, engaging tone.
6. Present the drafted content to the user for review.
