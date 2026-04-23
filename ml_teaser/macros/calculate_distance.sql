-- macros/calculate_distance.sql
-- Calculates Euclidean distance between a test and training customer
-- using the four normalised feature columns (feature_1_n … feature_4_n).
--
-- Usage:
--   {{ calculate_distance('t', 'tr') }} AS distance
--
-- Where 't' and 'tr' are the table aliases in your FROM / CROSS JOIN.
{% macro calculate_distance(test_alias, train_alias) %}
    SQRT(
        POWER({{ test_alias }}.feature_1_n - {{ train_alias }}.feature_1_n, 2) +
        POWER({{ test_alias }}.feature_2_n - {{ train_alias }}.feature_2_n, 2) +
        POWER({{ test_alias }}.feature_3_n - {{ train_alias }}.feature_3_n, 2) +
        POWER({{ test_alias }}.feature_4_n - {{ train_alias }}.feature_4_n, 2)
    )
{% endmacro %}
