# Build Steps for `CONTACTS` Demo

This document breaks the implementation into clear, actionable steps. Perform them in order.

| Step | Action | Details |
|------|--------|---------|
| **1** | Confirm Plan | Review `contacts_plan.md`; adjust if needed. |
| **2** | Create Directory Structure | `mkdir -p src data`; ensure `plan` already exists. |
| **3** | Scaffold Source File | Create `src/contacts.cob` with program skeleton (IDENTIFICATION, ENVIRONMENT, DATA, PROCEDURE divisions). |
| **4** | Implement File & Data Sections | Add FILE-CONTROL, FD, and working-storage definitions for user input and loop control. |
| **5** | Implement Input Paragraphs | Code `GET-NAME`, `GET-EMAIL`, `GET-MESSAGE` paragraphs with blank-check validation loops. |
| **6** | Implement Main Logic | Add `OPEN-FILES`, `WRITE-RECORD`, `ASK-ANOTHER`, loop, and `CLEANUP`. |
| **7** | Compile | `cobc -x -o contacts src/contacts.cob` (GNU COBOL). |
| **8** | Manual Testing | Run `./contacts`, perform scenarios in test matrix. Inspect `data/CONTACTS.DAT`. |
| **9** | Optional Enhancements | Add simple email format check, message trimming, colors, etc. |

---

## Command Snippets
```bash
# Step 2
mkdir -p src data

# Step 7 – compile & run
cobc -x -o contacts src/contacts.cob
./contacts
```

---

> Keep these steps in sync with any future plan updates.
