       >>SOURCE FORMAT FREE

       IDENTIFICATION DIVISION.
       PROGRAM-ID. CONTACTS.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
      *> TODO: Define file assignments in Step 4
           SELECT CONTACT-FILE ASSIGN TO "data/CONTACTS.DAT"
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS CONTACT-STATUS.

       DATA DIVISION.
       FILE SECTION.
      *> TODO: Flesh out FD in Step 4
       FD  CONTACT-FILE.
       01  CONTACT-REC.
           05  NAME-FIELD     PIC X(30).
           05  EMAIL-FIELD    PIC X(50).
           05  MESSAGE-FIELD  PIC X(200).

       WORKING-STORAGE SECTION.
      *> TODO: Expand working storage in Step 4 & 5
       77  CONTACT-STATUS     PIC 99.
       77  ANOTHER-FLAG       PIC X VALUE "Y".
       77  NAME-IN            PIC X(30).
       77  EMAIL-IN           PIC X(50).
       77  MESSAGE-IN         PIC X(200).

       PROCEDURE DIVISION.

       MAIN-LOGIC.
           DISPLAY "*** Contact Us Form ***".
           PERFORM OPEN-FILES
           PERFORM ASK-FIRST
           PERFORM UNTIL ANOTHER-FLAG = "N"
               PERFORM GET-NAME
               PERFORM GET-EMAIL
               PERFORM GET-MESSAGE
               PERFORM WRITE-RECORD
               PERFORM ASK-ANOTHER
           END-PERFORM
           DISPLAY "Done.".
           PERFORM CLEANUP
           STOP RUN.

       OPEN-FILES.
           OPEN EXTEND CONTACT-FILE.
           IF CONTACT-STATUS = 35 OR CONTACT-STATUS = 97
               OPEN OUTPUT CONTACT-FILE
           END-IF
           IF CONTACT-STATUS NOT = 00
               DISPLAY "File open error, status " CONTACT-STATUS
               STOP RUN
           END-IF.

       GET-NAME.
           MOVE SPACES TO NAME-IN
           PERFORM UNTIL FUNCTION LENGTH(FUNCTION TRIM(NAME-IN)) > 0
               DISPLAY "Name    : " WITH NO ADVANCING
               ACCEPT NAME-IN
           END-PERFORM.

       GET-EMAIL.
           MOVE SPACES TO EMAIL-IN
           PERFORM UNTIL FUNCTION LENGTH(FUNCTION TRIM(EMAIL-IN)) > 0
               DISPLAY "Email   : " WITH NO ADVANCING
               ACCEPT EMAIL-IN
           END-PERFORM.

       GET-MESSAGE.
           MOVE SPACES TO MESSAGE-IN
           PERFORM UNTIL FUNCTION LENGTH(FUNCTION TRIM(MESSAGE-IN)) > 0
               DISPLAY "Message : " WITH NO ADVANCING
               ACCEPT MESSAGE-IN
           END-PERFORM.

       WRITE-RECORD.
           MOVE NAME-IN    TO NAME-FIELD
           MOVE EMAIL-IN   TO EMAIL-FIELD
           MOVE MESSAGE-IN TO MESSAGE-FIELD
           WRITE CONTACT-REC
           IF CONTACT-STATUS NOT = 00
               DISPLAY "Write error, status " CONTACT-STATUS
           END-IF.

       ASK-FIRST.
           DISPLAY "Would you like to enter a contact? (Y/N): " WITH NO ADVANCING
           ACCEPT ANOTHER-FLAG
           MOVE FUNCTION UPPER-CASE(ANOTHER-FLAG(1:1)) TO ANOTHER-FLAG
           IF ANOTHER-FLAG NOT = "Y"
               MOVE "N" TO ANOTHER-FLAG
           END-IF.

       ASK-ANOTHER.
           DISPLAY "Add another contact? (Y/N): " WITH NO ADVANCING
           ACCEPT ANOTHER-FLAG
           MOVE FUNCTION UPPER-CASE(ANOTHER-FLAG(1:1)) TO ANOTHER-FLAG
           IF ANOTHER-FLAG NOT = "Y"
               MOVE "N" TO ANOTHER-FLAG
           END-IF.

       CLEANUP.
           CLOSE CONTACT-FILE.
