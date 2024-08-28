{{ config(
    materialized="view"
) }}

with qt_scores as (
    select 
        id
        ,{{get_qt_scores('HOME_LINESCORE', "HOME")}}
        ,{{get_qt_scores('VISITORS_LINESCORE', "VISITORS")}}
    from {{ref('games')}}
)

, qt_scores_lead as (
    select 
        id
        ,home_q1_score
        ,home_q2_score
        ,home_q3_score
        ,home_q4_score
        ,home_ot_1_score
        ,home_ot_2_score
        ,visitors_q1_score
        ,visitors_q2_score
        ,visitors_q3_score
        ,visitors_q4_score
        ,visitors_ot_1_score
        ,visitors_ot_2_score
        ,abs(home_q1_score - visitors_q1_score) q1_diff
        ,abs(home_q2_score - visitors_q2_score) q2_diff
        ,abs(home_q3_score - visitors_q3_score) q3_diff
        ,abs(home_q4_score - visitors_q4_score) q4_diff
        ,abs(home_ot_1_score - visitors_ot_1_score) ot_1_diff
        ,abs(home_ot_2_score - visitors_ot_2_score) ot_2_diff
    from qt_scores
)


select  
    ARENA_CITY
    ,ARENA_COUNTRY
    ,ARENA_NAME
    ,ARENA_STATE
    ,DATE_DURATION
    ,DATE_END
    ,DATE_START
    ,HOME_LINESCORE
    ,home_q1_score
    ,home_q2_score
    ,home_q3_score
    ,home_q4_score
    ,home_ot_1_score
    ,home_ot_2_score
    ,HOME_LOSS
    ,HOME_POINTS
    ,HOME_SERIES_LOSS
    ,HOME_SERIES_WIN
    ,HOME_WIN
    ,g.ID
    ,LEADCHANGES
    ,LEAGUE
    ,NUGGET
    ,OFFICIALS
    ,PERIODS_CURRENT
    ,PERIODS_ENDOFPERIOD
    ,PERIODS_TOTAL
    ,SEASON
    ,STAGE
    ,STATUS_CLOCK
    ,STATUS_HALFTIME
    ,STATUS_LONG
    ,STATUS_SHORT
    ,SYNC_TIME
    ,TEAMS_HOME_CODE
    ,TEAMS_HOME_ID
    ,TEAMS_HOME_LOGO
    ,TEAMS_HOME_NAME
    ,TEAMS_HOME_NICKNAME
    ,TEAMS_VISITORS_CODE
    ,TEAMS_VISITORS_ID
    ,TEAMS_VISITORS_LOGO
    ,TEAMS_VISITORS_NAME
    ,TEAMS_VISITORS_NICKNAME
    ,TIMESTIED
    ,VISITORS_LINESCORE
    ,visitors_q1_score
    ,visitors_q2_score
    ,visitors_q3_score
    ,visitors_q4_score
    ,visitors_ot_1_score
    ,visitors_ot_2_score
    ,VISITORS_LOSS
    ,VISITORS_POINTS
    ,VISITORS_SERIES_LOSS
    ,VISITORS_SERIES_WIN
    ,VISITORS_WIN
    ,q1_diff
    ,q2_diff
    ,q3_diff
    ,q4_diff
    ,ot_1_diff
    ,ot_2_diff
from {{ref('games')}} as g
    left join qt_scores_lead as qt on g.id = qt.id