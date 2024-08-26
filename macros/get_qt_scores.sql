{% macro get_qt_scores(scores, prefix) %}

    {#
    Macro to parse a string of numeric scores, separate them into individual columns, and compute their total.

    Args:
        scores (str): A string of numeric values separated by commas and enclosed in square brackets (e.g., '[20, 23, 27, 26, 0]').
        prefix (str): A prefix to prepend to the resulting column names.
    #}

    {% set score_list = "regexp_substr_all(" ~ scores ~ ", '[0-9]+')" %}

    {{ score_list}}[0]::numeric as {{ prefix }}_q1_score
    ,{{ score_list }}[1]::numeric as {{ prefix }}_q2_score
    ,{{ score_list }}[2]::numeric as {{ prefix }}_q3_score
    ,{{ score_list }}[3]::numeric as {{ prefix }}_q4_score
    ,{{ score_list }}[4]::numeric as {{ prefix }}_ot_1_score
    ,{{ score_list }}[5]::numeric as {{ prefix }}_ot_2_score

{% endmacro %}