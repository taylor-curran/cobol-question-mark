# CONTACTS COBOL Program – Implementation Plan

## 1. Objective
Create a simple interactive COBOL program named `CONTACTS` that collects a person’s **Name**, **Email**, and **Message** from the console, validates that no field is blank, appends the data as a fixed-length record to `CONTACTS.DAT`, and optionally loops for another entry.

---

## 2. Directory / File Structure
```
cobol-question-mark/
├── plan/
│   └── contacts_plan.md
├── src/
│   └── contacts.cob       ← program source (to be created)
├── data/
│   └── CONTACTS.DAT       ← runtime-generated flat-file
```
*`src` and `data` will be created later.*

---

## 3. High-Level Program Flow
1. Display header `*** Contact Us Form ***`.
2. Prompt user for each field:
   - `Name    : ` (30‐char max)
   - `Email   : ` (50‐char max)
   - `Message : ` (200‐char max)
3. After each prompt, re-prompt if the entry is blank.
4. When all fields are non-blank:
   1. Pad/truncate fields to fixed length.
   2. `WRITE` record to `CONTACTS.DAT` (LINE SEQUENTIAL; open EXTEND).
   3. Display confirmation.
5. Ask `Enter another? (Y/N)` → if `Y` loop; else exit.

---

## 4. Data & File Definitions
| Field   | PIC clause | Bytes |
|---------|------------|-------|
| NAME    | X(30)      | 30    |
| EMAIL   | X(50)      | 50    |
| MESSAGE | X(200)     | 200   |

```
SELECT CONTACT-FILE ASSIGN TO "data/CONTACTS.DAT"
       ORGANIZATION IS LINE SEQUENTIAL.

FD  CONTACT-FILE.
01  CONTACT-REC.
    05 C-NAME     PIC X(30).
    05 C-EMAIL    PIC X(50).
    05 C-MESSAGE  PIC X(200).
```

---

## 5. PROCEDURE Division Skeleton
```
OPEN-FILES.
    OPEN EXTEND CONTACT-FILE.

MAIN-LOOP.
    PERFORM GET-NAME
    PERFORM GET-EMAIL
    PERFORM GET-MESSAGE
    PERFORM WRITE-RECORD
    PERFORM ASK-ANOTHER
    IF ANOTHER = "Y" GO TO MAIN-LOOP.

CLEANUP.
    CLOSE CONTACT-FILE.
    STOP RUN.
```
Each `GET-xxx` paragraph handles accept + blank validation.

---

## 6. Validation Strategy
Use `FUNCTION LENGTH(field) > 0`; otherwise display `(required)` and re-prompt.

---

## 7. Manual Test Matrix
| Scenario | Expected |
|----------|----------|
| Valid entry | Record written; thank-you; ask again |
| Blank name  | Re-prompt for name |
| Blank email | Re-prompt email only |
| Blank message | Re-prompt message only |
| Multiple records | File grows each loop |
| Exit with N | Program ends cleanly |

---

## 8. Compile & Run (GNU COBOL)
```bash
# Compile
cobc -x -o contacts src/contacts.cob

# Run
./contacts
```

---

## 9. Next Steps
1. Scaffold `src/contacts.cob` per sections above.
2. Implement + test.
3. Deliver final program.
