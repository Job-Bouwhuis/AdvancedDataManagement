SELECT
    a.accuracy_score,
    p.predicted_will_leave,
    p.confidence_score
FROM       ml_accuracy_score  a
CROSS JOIN ml_prediction       p;