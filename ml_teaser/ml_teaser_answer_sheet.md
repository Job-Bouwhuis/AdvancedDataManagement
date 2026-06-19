# ML Teaser — Answer Sheet

Complete this file and submit it alongside your dbt models.

---

## 1. Feature Selection

Which 4 features did you choose? Fill in the original column name and your reason for each.

| Alias | Column name | Why you chose it |
|---|---|---|
| feature_1 | months_as_customer | Newer customers are more likely to leave because they haven’t built a habit; tenure is a strong churn indicator. |
| feature_2 | hours_watched_last_month | Low engagement (few hours watched) signals disinterest, a direct leading indicator of churn. |
| feature_3 | days_since_last_login | Long inactivity suggests the customer has already disengaged; the longer since last login, the higher churn risk. |
| feature_4 | support_calls_last_month | Multiple support calls often indicate frustration or problems, which correlate with leaving. |

---

## 2. Feature Justification

In 3–5 sentences, explain your feature choices as a business decision. Why do these four columns predict whether a customer will leave?

> I selected `months_as_customer` because new customers have the highest churn risk before establishing a usage habit. `hours_watched_last_month` and `days_since_last_login` directly measure engagement - customers who watch little content or haven't logged in recently are already disengaging from the service. `support_calls_last_month` captures frustration. customers who contact support multiple times are often experiencing issues that may lead to cancellation. Together, these four features provide a balanced view of churn risk across engagement, tenure, and satisfaction dimensions.

---

## 3. Model Results

After running `dbt run`, paste your results below.

**Accuracy score:**

```
accuracy_score = 0.705299973487854
```

**New customer prediction:**

```
predicted_will_leave = 1 
confidence_score     = 0.6000000238418579
```

---

## 4. Understanding Questions

Answer each question in 2–3 sentences in your own words.

**Q1. What does your accuracy score mean for the business? Is it a good result?**

> 0.705299973487854% means the model gets 70 out of 100 predictions correct. This is decent - the company can use it to target at-risk customers with offers, saving money compared to guessing randomly.

---

**Q2. Why is it important to normalise features before calculating distances?**

> Without normalisation, features with bigger numbers (like months_as_customer) would dominate smaller ones (like support_calls). Normalising puts everything on the same 0-1 scale so all features contribute equally.

---

**Q3. The model uses K = 5. What would happen to the prediction if K were increased to 15? Would it become more or less reliable, and why?**

> K=15 would look at more neighbours, making predictions smoother and less sensitive to outliers. But it might also include customers who aren't very similar, potentially reducing accuracy on the specific prediction.

---

**Q4. Based on the confidence score, how certain is the model about the new customer prediction? What action would you recommend the business take?**

> With 0.6000000238418579% confidence, the model is moderately certain the customer will leave. The company should send a discount offer because its highly likely that a user that is considering leaving may stay for longer if they get a discount/bonus deal
