# Gate A — Answer Sheet

## Instructions

* Areas marked `<insert here>` are where you write your answers.
* Areas marked `![screenshot]` are where you paste screenshots.
* **Tip — pasting screenshots:** Use the [Paste Image](https://marketplace.visualstudio.com/items?itemName=mushan.vscode-paste-image) VS Code extension (Built into container).
* **Tip — export to PDF:** Use the [Markdown PDF](https://marketplace.visualstudio.com/items?itemName=yzane.markdown-pdf) VS Code extension. Export and submit the PDF to Brightspace (Built into container).

---

## Student Info

**Name:** `<insert here>`
**Class:** `<insert here>`
**Teacher:** `<insert here>`

---

# Part 1 — Pizza Normalization

**Exercise:** `student-preload → gatekeepers/gate-a-pizza`

---

## Improved ERD

Design your improved schema in [dbdiagram.io](https://dbdiagram.io/) starting from the provided `pizza.dbml`.

**Screenshot of your improved ERD:**

![screenshot]

---

## Justification

Explain your design choices in your  **own words** . For each change you made, answer:

* What did you change?
* Why did you change it? (What problem does it solve?)

`<insert justification here>`

---

# Part 2 — StackExchange Optimization

**Exercise:** `student-preload → gatekeepers/gate-a-stackexchange`

---

## Part 2.1 — Baseline Performance

### Query 1 — Search

Find questions or answers that mention the word `postgres` in the title or body.

**SQL:**

```sql
<insert SQL here>
```

**Explanation (in your own words):**
`<insert here>`

**Screenshot — Query Plan:**
![screenshot]

**Screenshot — First 3 Records:**
![screenshot]

---

### Query 2 — Questions Overview

Show all questions sorted by date descending, including the first 200 characters of the content, the number of answers, and the username of the author.

**SQL:**

```sql
<insert SQL here>
```

**Explanation (in your own words):**
`<insert here>`

**Screenshot — Query Plan:**
![screenshot]

**Screenshot — First 3 Records:**
![screenshot]

---

### Query 3 — Insert Answer

Insert a new answer for an existing question.

**SQL:**

```sql
<insert SQL here>
```

**Explanation (in your own words):**
`<insert here>`

**Screenshot — Query Plan (if applicable):**
![screenshot]

---

## Part 2.2 — Optimize

### Indexes

**SQL to create indexes:**

```sql
<insert SQL here>
```

**Explanation — why these columns, why these index types:**
`<insert here>`

---

### Denormalization & Triggers

**SQL — Alter table (add denormalized column):**

```sql
<insert SQL here>
```

**SQL — Populate the new column:**

```sql
<insert SQL here>
```

**SQL — Trigger(s) to keep it in sync:**

```sql
<insert SQL here>
```

**Explanation — what you denormalized and why:**
`<insert here>`

---

## Part 2.3 — Compare Results

### Query 1 — Search (Optimized)

**SQL:**

```sql
<insert optimized SQL here>
```

**Explanation — what changed and what impact did it have:**
`<insert here>`

**Screenshot — Query Plan:**
![screenshot]

**Screenshot — First 3 Records:**
![screenshot]

---

### Query 2 — Questions Overview (Optimized)

**SQL:**

```sql
<insert optimized SQL here>
```

**Explanation — what changed and what impact did it have:**
`<insert here>`

**Screenshot — Query Plan:**
![screenshot]

**Screenshot — First 3 Records:**
![screenshot]

---

### Query 3 — Insert Answer (Optimized)

**SQL:**

```sql
<insert optimized SQL here>
```

**Explanation — what changed and what impact did it have:**
`<insert here>`

**Screenshot — Query Plan:**
![screenshot]

**Screenshot — First 3 Records:**
![screenshot]
