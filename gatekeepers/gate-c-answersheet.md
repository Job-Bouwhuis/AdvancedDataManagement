# Gate C — Answer Sheet

## Instructions

* Areas marked `<insert here>` are where you write your answers.
* Areas marked `![screenshot]` are where you paste screenshots.
* **Tip — pasting screenshots:** Use the [Paste Image](https://marketplace.visualstudio.com/items?itemName=mushan.vscode-paste-image) VS Code extension (Built into container).
* **Tip — export to PDF:** Use the [Markdown PDF](https://marketplace.visualstudio.com/items?itemName=yzane.markdown-pdf) VS Code extension. Export and submit the PDF to Brightspace (Built into container).
* **Gate C sign-off covers Phase 3. Phase 4 (dashboard).**

---

## Student Info

**Name:** `<insert here>`
**Class:** `<insert here>`
**Teacher:** `<insert here>`

---

# Phase 3 — Star Model, Implementation

**Exercise:** `student-preload → gatekeepers/gate-bc-student-enrolment`

---

## 3.1 — Grain Definitions

Define the grain for each fact table. Write it as: *"Each row represents one … in one …"*

**Primary grain:**

`<insert grain statement here>`

**Roll-up grain:**

`<insert grain statement here>`

---

## 3.2 — Metrics Table

Complete the table below for  **each fact table** . Justify why you chose that statistical operation rather than an obvious alternative.

### Primary Grain Fact Table

**Fact table name:** `<insert here>`

| Metric name  | Source field | Statistical operation | Justification |
| ------------ | ------------ | --------------------- | ------------- |
| `<insert>` | `<insert>` | `<insert>`          | `<insert>`  |
| `<insert>` | `<insert>` | `<insert>`          | `<insert>`  |

### Roll-up Grain Fact Table

**Fact table name:** `<insert here>`

| Metric name  | Source field | Statistical operation | Justification |
| ------------ | ------------ | --------------------- | ------------- |
| `<insert>` | `<insert>` | `<insert>`          | `<insert>`  |
| `<insert>` | `<insert>` | `<insert>`          | `<insert>`  |

---

## 3.3 — Star Model Design (DBML)

**Screenshot of your full star model DBML diagram (fact tables + dimension tables + relationships):**

![screenshot]

---

## 3.4 — Implementation

**Files created:**

* `models/mart/dim_*.sql` — list the dimension models you created:

`<insert here>`

* `models/mart/fct_*.sql` — list the fact models you created:

`<insert here>`

**Screenshot — `dbt run` succeeding with all mart models built:**

![screenshot]

---

# Phase 4 — Dashboard Validation

---

## 4.1 — Dashboard Screenshot

**Screenshot of your Metabase dashboard:**

![screenshot]

---

## 4.2 — Grain Interpretation

In your own words, explain how changing the grain affects interpretation.

What does the **primary grain** reveal that the roll-up cannot?

`<insert here>`

What does the **roll-up grain** reveal that the primary grain cannot?

`<insert here>`
