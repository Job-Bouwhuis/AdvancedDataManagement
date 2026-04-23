# ML Teaser — Answer Sheet

Complete this file and submit it alongside your dbt models.

---

## 1. Feature Selection

Which 4 features did you choose? Fill in the original column name and your reason for each.

| Alias | Column name | Why you chose it |
|---|---|---|
| feature_1 | | |
| feature_2 | | |
| feature_3 | | |
| feature_4 | | |

---

## 2. Feature Justification

In 3–5 sentences, explain your feature choices as a business decision. Why do these four columns predict whether a customer will leave?

> *Write your answer here.*

---

## 3. Model Results

After running `dbt run`, paste your results below.

**Accuracy score:**

```
accuracy_score =
```

**New customer prediction:**

```
predicted_will_leave =
confidence_score     =
```

---

## 4. Understanding Questions

Answer each question in 2–3 sentences in your own words.

**Q1. What does your accuracy score mean for the business? Is it a good result?**

> *Write your answer here.*

---

**Q2. Why is it important to normalise features before calculating distances?**

> *Write your answer here.*

---

**Q3. The model uses K = 5. What would happen to the prediction if K were increased to 15? Would it become more or less reliable, and why?**

> *Write your answer here.*

---

**Q4. Based on the confidence score, how certain is the model about the new customer prediction? What action would you recommend the business take?**

> *Write your answer here.*
