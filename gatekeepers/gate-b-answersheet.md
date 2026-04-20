# Gate B — Answer Sheet

## Instructions

* Areas marked `<insert here>` are where you write your answers.
* Areas marked `![screenshot]` are where you paste screenshots.
* **Tip — pasting screenshots:** Use the [Paste Image](https://marketplace.visualstudio.com/items?itemName=mushan.vscode-paste-image) VS Code extension (Built into container).
* **Tip — export to PDF:** Use the [Markdown PDF](https://marketplace.visualstudio.com/items?itemName=yzane.markdown-pdf) VS Code extension. Export and submit the PDF to Brightspace (Built into container).
* **Gate B requires both sections below to be complete before your sign-off conversation.**

---

## Student Info

**Name:** `<insert here>`
**Class:** `<insert here>`
**Teacher:** `<insert here>`

---

# Part 1 — Dogs: Trustworthy Staging Data

**Exercise:** `student-preload → gatekeepers/gate-b-dogs`

---

## 1.1 — Source Configuration

Describe what you added to `sources.yml` to register the `breeds` table.

**What you added (paste relevant section of sources.yml):**

```yaml
<insert here>
```

---

## 1.2 — Staging Model

**File created:** `models/staging/stg_dogs.sql`

Paste your completed staging model below:

```sql
<insert SQL here>
```

**Explain your key decisions (in your own words):**

* What columns did you rename or standardise, and why?
* Were any columns removed or cast to a different type? Why?

`<insert explanation here>`

---

## 1.3 — Data Quality Tests

**Paste the relevant section of `schema.yml` covering `stg_dogs`:**

```yaml
<insert here>
```

**Test severity choice:**

Which test did you configure with an explicit severity (`error` or `warn`)?

`<insert test name here>`

**Why did you choose that severity for that test?**

`<insert explanation here>`

**What kind of data issue does it represent?**

`<insert explanation here>`

---

## 1.4 — Custom SQL Test

**File created:** `tests/<insert filename here>.sql`

**Paste your custom test SQL:**

```sql
<insert SQL here>
```

**Which rule from `data_dictionary.md` does this test validate?**

`<insert here>`

**What does a returned row mean (i.e. what counts as invalid)?**

`<insert here>`

---

## 1.5 — Handling Failing Tests

Did any tests fail or warn when you ran `dbt test`?

`<insert: yes / no>`

**If yes — what failed, and what did you decide to do about it?**

`<insert decision and reasoning here>`

---

## 1.6 — Documentation

**Screenshot — dbt docs showing stg_dogs model, tests visible, and lineage from source → staging:**

![screenshot]

---

## 1.7 — dbt Run Result

**Screenshot — terminal output of `dbt run` succeeding:**

![screenshot]

---

# Part 2 — Student Enrolment: Phase 2 (Intermediate Model)

**Exercise:** `student-preload → gatekeepers/gate-bc-student-enrolment`

---

## 2.1 — Analytical Question

**Your analytical question:**

`<insert here>`

**Justification — why is this question aligned with the user story?**

`<insert here>`

---

## 2.2 — Foundation

**Staging models required:**

`<insert here>`

**Join key used to combine them:**

`<insert here>`

**Base fields carried forward:**

`<insert here>`

---

## 2.3 — Added Fields

For each added field, complete the table below:

| Field name            | Type (Calculated / Categorical) | How it is derived or defined                                 | Why it is needed  |
| --------------------- | ------------------------------- | ------------------------------------------------------------ | ----------------- |
| `days_before_start` | Calculated                      | `start_date - enrolment_date`                              | `<insert here>` |
| `enrolment_period`  | Categorical                     | early / on_time / late — derived from `days_before_start` | `<insert here>` |

Add any additional fields you chose to include:

| Field name   | Type         | How derived  | Why needed   |
| ------------ | ------------ | ------------ | ------------ |
| `<insert>` | `<insert>` | `<insert>` | `<insert>` |

---

## 2.4 — Intermediate Model Design (DBML)

**Screenshot of your `int_enrolments` DBML diagram (from dbdiagram.io or VS Code extension):**

![screenshot]

---

## 2.5 — Implementation

**File created:** `models/intermediate/int_enrolments.sql`

**Screenshot — `dbt run` succeeding with `int_enrolments` built:**

![screenshot]
