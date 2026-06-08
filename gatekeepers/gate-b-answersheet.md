# Gate B — Answer Sheet

## Instructions

* Areas marked `<insert here>` are where you write your answers.
* Areas marked `![screenshot]` are where you paste screenshots.
* **Tip — pasting screenshots:** Use the [Paste Image](https://marketplace.visualstudio.com/items?itemName=mushan.vscode-paste-image) VS Code extension (Built into container).
* **Tip — export to PDF:** Use the [Markdown PDF](https://marketplace.visualstudio.com/items?itemName=yzane.markdown-pdf) VS Code extension. Export and submit the PDF to Brightspace (Built into container).
* **Gate B requires both sections below to be complete before your sign-off conversation.**

---

## Student Info

**Name:** `Job Bouwhuis`
**Class:** `2-Sb`
**Teacher:** `Melanie Bonnes`

---

# Part 1 — Dogs: Trustworthy Staging Data

**Exercise:** `student-preload → gatekeepers/gate-b-dogs`

---

## 1.1 — Source Configuration

Describe what you added to `sources.yml` to register the `breeds` table.

**What you added (paste relevant section of sources.yml):**

```yaml
      - name: breeds
        description: "Table loaded directly from source containing information about dog breeds."
```

---

## 1.2 — Staging Model

**File created:** `models/staging/stg_dogs.sql`

Paste your completed staging model below:

```sql
WITH source AS (
    SELECT *
    FROM {{ source('dogs', 'breeds') }}
),

renamed AS (
    SELECT
        lower(trim(breed)) AS breed,
        "group" AS breed_group,
        score,
        longevity,
        purchase_price,
        grooming,
        size,
        weight,
        height
    FROM source
)

SELECT *
FROM renamed
```

**Explain your key decisions (in your own words):**

* What columns did you rename or standardise, and why?
* Were any columns removed or cast to a different type? Why?

`I renamed group to breed_group because group is a SQL keyword and the new name is clearer. I also standardized breed and size by trimming whitespace and converting them to lowercase to ensure consistent values for analysis.`

---

## 1.3 — Data Quality Tests

**Paste the relevant section of `schema.yml` covering `stg_dogs`:**

```yaml
  - name: stg_breeds
    description: "Staging table for dogs data"
    docs:
      node_color: "maroon"
    columns:
      - name: breed
        description: "Breed name of the dog (standardized)"
        data_type: "STRING"
        tests:
          - not_null:
              config:
                severity: error
          - unique:
                config:
                    severity: warn
```

**Test severity choice:**

Which test did you configure with an explicit severity (`error` or `warn`)?

`a doggo must have a breed, otherwise its magic. therefor no breed is error`

**Why did you choose that severity for that test?**

`a breed without breed`

**What kind of data issue does it represent?**

`corrupt data for that specific breed`

---

## 1.4 — Custom SQL Test

**File created:** `tests/test_breed_size.sql`

**Paste your custom test SQL:**

```sql
{{ config(severity='warn') }}

select *
from {{ ref('stg_breeds') }}
where size not in ('small', 'medium', 'large')
```

**Which rule from `data_dictionary.md` does this test validate?**

`the one about size`

**What does a returned row mean (i.e. what counts as invalid)?**

`a returned row means said row is invalid. in this case, that the size column does not have the value "small", "medium", or "large"`

---

## 1.5 — Handling Failing Tests

Did any tests fail or warn when you ran `dbt test`?

`no`

**If yes — what failed, and what did you decide to do about it?**

`n.a`

---

## 1.6 — Documentation

**Screenshot — dbt docs showing stg_dogs model, tests visible, and lineage from source → staging:**

![alt text](image-6.png)

---

## 1.7 — dbt Run Result

**Screenshot — terminal output of `dbt run` succeeding:**

![alt text](image-7.png)

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
