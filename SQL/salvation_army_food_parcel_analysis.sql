-- SQLite

/*
Salvation Army Food Parcel Program – Data Analytics SQL Queries
Prepared by: Juliana Binondo | Date: August 2025

This SQL script supports analysis of 890 household records to optimize food parcel distribution 
and referral services for The Salvation Army New Zealand. The queries explore key demographic 
segments, referral patterns, visit frequency, parcel sizing, and seasonal demand trends. 

Insights derived here aim to improve resource allocation, tailor culturally appropriate services,
and enhance operational efficiency—directly supporting strategic recommendations to reduce 
waste, boost referral outreach, and forecast parcel needs throughout the year.
/*
CREATE TABLE HOUSEHOLDS (
    HOUSEHOLD_ID INTEGER,
    AGE_GROUP TEXT,
    ETHNICITY TEXT,
    INCOME_SOURCE TEXT,
    FAMILY_TYPE TEXT,
    VISIT_FREQUENCY TEXT,
    HOUSEHOLD_SIZE INTEGER,
    PARCEL_SIZE INTEGER,
    REFERRED_TO_SERVICE TEXT,
    DATE_ASSIGNED TEXT, -- using TEXT for now to avoid import issues
    SERVICE_TYPE TEXT
);

.tables
*/

-- 1. Verify total households (should be 890)
SELECT
    COUNT(*) AS TOTAL_HOUSEHOLDS
FROM
    HOUSEHOLDS;

-- 2. Sample data with corrected ISO dates for validation
SELECT
    HOUSEHOLD_ID,
    AGE_GROUP,
    ETHNICITY,
    INCOME_SOURCE,
    FAMILY_TYPE,
    VISIT_FREQUENCY,
    HOUSEHOLD_SIZE,
    PARCEL_SIZE,
    REFERRED_TO_SERVICE,
    SERVICE_TYPE,
    DATE_ASSIGNED,
    CASE
        WHEN DATE_ASSIGNED LIKE '__/__/____' THEN
            SUBSTR(DATE_ASSIGNED, 7, 4)
            || '-'
            ||
            SUBSTR(DATE_ASSIGNED, 4, 2)
            || '-'
            ||
            SUBSTR(DATE_ASSIGNED, 1, 2)
        WHEN DATE_ASSIGNED LIKE '_/__/____' THEN
            SUBSTR(DATE_ASSIGNED, 6, 4)
            || '-'
            ||
            SUBSTR(DATE_ASSIGNED, 3, 2)
            || '-'
            ||
            '0'
            || SUBSTR(DATE_ASSIGNED, 1, 1)
        WHEN DATE_ASSIGNED LIKE '__/_/____' THEN
            SUBSTR(DATE_ASSIGNED, 6, 4)
            || '-'
            ||
            '0'
            || SUBSTR(DATE_ASSIGNED, 4, 1)
               || '-'
               ||
            SUBSTR(DATE_ASSIGNED, 1, 2)
        WHEN DATE_ASSIGNED LIKE '_/_/____' THEN
            SUBSTR(DATE_ASSIGNED, 5, 4)
            || '-'
            ||
            '0'
            || SUBSTR(DATE_ASSIGNED, 3, 1)
               || '-'
               ||
            '0'
            || SUBSTR(DATE_ASSIGNED, 1, 1)
        ELSE
            NULL
    END                 AS DATE_ASSIGNED_ISO
FROM
    HOUSEHOLDS LIMIT 5;

-- 3. Referral rates by family type
SELECT
    FAMILY_TYPE,
    COUNT(HOUSEHOLD_ID)                        AS TOTAL_HOUSEHOLDS,
    COUNT(
        CASE
            WHEN SERVICE_TYPE != 'No Referral' THEN
                1
        END)                                   AS REFERRED_HOUSEHOLDS,
    ROUND(COUNT(
        CASE
            WHEN SERVICE_TYPE != 'No Referral' THEN
                1
        END) * 100.0 / COUNT(HOUSEHOLD_ID), 2) AS REFERRAL_RATE_PCT
FROM
    HOUSEHOLDS
GROUP BY
    FAMILY_TYPE
ORDER BY
    TOTAL_HOUSEHOLDS DESC;

-- 4. Seasonal trends in parcel assignments
SELECT
    CASE
        WHEN DATE_ASSIGNED LIKE '__/__/____' THEN
            SUBSTR(DATE_ASSIGNED, 7, 4)
        WHEN DATE_ASSIGNED LIKE '_/__/____' THEN
            SUBSTR(DATE_ASSIGNED, 6, 4)
        WHEN DATE_ASSIGNED LIKE '__/_/____' THEN
            SUBSTR(DATE_ASSIGNED, 6, 4)
        WHEN DATE_ASSIGNED LIKE '_/_/____' THEN
            SUBSTR(DATE_ASSIGNED, 5, 4)
        ELSE
            NULL
    END                 AS YEAR,
    CASE
        WHEN DATE_ASSIGNED LIKE '__/__/____' THEN
            SUBSTR(DATE_ASSIGNED, 4, 2)
        WHEN DATE_ASSIGNED LIKE '_/__/____' THEN
            SUBSTR(DATE_ASSIGNED, 3, 2)
        WHEN DATE_ASSIGNED LIKE '__/_/____' THEN
            '0'
            || SUBSTR(DATE_ASSIGNED, 4, 1)
        WHEN DATE_ASSIGNED LIKE '_/_/____' THEN
            '0'
            || SUBSTR(DATE_ASSIGNED, 3, 1)
        ELSE
            NULL
    END                 AS MONTH,
    COUNT(HOUSEHOLD_ID) AS PARCELS_ASSIGNED
FROM
    HOUSEHOLDS
WHERE
    DATE_ASSIGNED IS NOT NULL
GROUP BY
    YEAR,
    MONTH
ORDER BY
    YEAR,
    MONTH;

-- 5. Household size vs. parcel size correlation
SELECT
    HOUSEHOLD_SIZE,
    COUNT(*)                   AS NUMBER_OF_HOUSEHOLDS,
    ROUND(AVG(PARCEL_SIZE), 2) AS AVG_PARCEL_SIZE,
    MIN(PARCEL_SIZE)           AS MIN_PARCEL_SIZE,
    MAX(PARCEL_SIZE)           AS MAX_PARCEL_SIZE
FROM
    HOUSEHOLDS
GROUP BY
    HOUSEHOLD_SIZE
ORDER BY
    HOUSEHOLD_SIZE;

-- 6. Service type distribution by income source
SELECT
    INCOME_SOURCE,
    SERVICE_TYPE,
    COUNT(*)      AS COUNT
FROM
    HOUSEHOLDS
GROUP BY
    INCOME_SOURCE,
    SERVICE_TYPE
ORDER BY
    INCOME_SOURCE,
    COUNT DESC;

-- 7. Visit frequency analysis with referral rates
SELECT
    VISIT_FREQUENCY,
    COUNT(*)                        AS TOTAL_HOUSEHOLDS,
    COUNT(
        CASE
            WHEN SERVICE_TYPE != 'No Referral' THEN
                1
        END)                        AS REFERRED_HOUSEHOLDS,
    ROUND(COUNT(
        CASE
            WHEN SERVICE_TYPE != 'No Referral' THEN
                1
        END) * 100.0 / COUNT(*), 2) AS REFERRAL_RATE_PCT
FROM
    HOUSEHOLDS
GROUP BY
    VISIT_FREQUENCY
ORDER BY
    CASE VISIT_FREQUENCY
        WHEN '1-2' THEN
            1
        WHEN '3-6' THEN
            2
        WHEN '7-12' THEN
            3
        WHEN '13-24' THEN
            4
        WHEN '25+' THEN
            5
        ELSE
            6
    END;

-- 8. Age group and ethnicity cross analysis (detailed demographic insight)
SELECT
    AGE_GROUP,
    ETHNICITY,
    COUNT(*)                        AS TOTAL_HOUSEHOLDS,
    COUNT(
        CASE
            WHEN SERVICE_TYPE != 'No Referral' THEN
                1
        END)                        AS REFERRED_HOUSEHOLDS,
    ROUND(COUNT(
        CASE
            WHEN SERVICE_TYPE != 'No Referral' THEN
                1
        END) * 100.0 / COUNT(*), 2) AS REFERRAL_RATE_PCT
FROM
    HOUSEHOLDS
GROUP BY
    AGE_GROUP,
    ETHNICITY
ORDER BY
    TOTAL_HOUSEHOLDS DESC;

-- 9. Monthly referral trends (date handling)
SELECT
    CASE
        WHEN DATE_ASSIGNED LIKE '__/__/____' THEN
            SUBSTR(DATE_ASSIGNED, 7, 4)
        WHEN DATE_ASSIGNED LIKE '_/__/____' THEN
            SUBSTR(DATE_ASSIGNED, 6, 4)
        WHEN DATE_ASSIGNED LIKE '__/_/____' THEN
            SUBSTR(DATE_ASSIGNED, 6, 4)
        WHEN DATE_ASSIGNED LIKE '_/_/____' THEN
            SUBSTR(DATE_ASSIGNED, 5, 4)
        ELSE
            NULL
    END                             AS YEAR,
    CASE
        WHEN DATE_ASSIGNED LIKE '__/__/____' THEN
            SUBSTR(DATE_ASSIGNED, 4, 2)
        WHEN DATE_ASSIGNED LIKE '_/__/____' THEN
            SUBSTR(DATE_ASSIGNED, 3, 2)
        WHEN DATE_ASSIGNED LIKE '__/_/____' THEN
            '0'
            || SUBSTR(DATE_ASSIGNED, 4, 1)
        WHEN DATE_ASSIGNED LIKE '_/_/____' THEN
            '0'
            || SUBSTR(DATE_ASSIGNED, 3, 1)
        ELSE
            NULL
    END                             AS MONTH,
    COUNT(*)                        AS TOTAL_ASSIGNMENTS,
    COUNT(
        CASE
            WHEN SERVICE_TYPE != 'No Referral' THEN
                1
        END)                        AS REFERRALS,
    ROUND(COUNT(
        CASE
            WHEN SERVICE_TYPE != 'No Referral' THEN
                1
        END) * 100.0 / COUNT(*), 2) AS REFERRAL_RATE_PCT
FROM
    HOUSEHOLDS
WHERE
    DATE_ASSIGNED IS NOT NULL
GROUP BY
    YEAR,
    MONTH
ORDER BY
    YEAR,
    MONTH;

-- 10. Parcel size distribution for cost planning (categorized)
SELECT
    CASE
        WHEN PARCEL_SIZE <= 4 THEN
            'Small'
        WHEN PARCEL_SIZE <= 14 THEN
            'Medium'
        ELSE
            'Large'
    END      AS PARCEL_CATEGORY,
    COUNT(*) AS NUMBER_OF_PARCELS,
    ROUND(COUNT(*) * 100.0 / (
        SELECT
            COUNT(*)
        FROM
            HOUSEHOLDS
    ), 2) AS PERCENTAGE
FROM
    HOUSEHOLDS
GROUP BY
    PARCEL_CATEGORY
ORDER BY
    NUMBER_OF_PARCELS DESC;

-- 11. Cumulative assignments over time (time-series analysis)
WITH DATES AS (
    SELECT
        HOUSEHOLD_ID,
        CASE
            WHEN DATE_ASSIGNED LIKE '__/__/____' THEN
                SUBSTR(DATE_ASSIGNED, 7, 4)
                || '-'
                ||
                SUBSTR(DATE_ASSIGNED, 4, 2)
                || '-'
                ||
                SUBSTR(DATE_ASSIGNED, 1, 2)
            WHEN DATE_ASSIGNED LIKE '_/__/____' THEN
                SUBSTR(DATE_ASSIGNED, 6, 4)
                || '-'
                ||
                SUBSTR(DATE_ASSIGNED, 3, 2)
                || '-'
                ||
                '0'
                || SUBSTR(DATE_ASSIGNED, 1, 1)
            WHEN DATE_ASSIGNED LIKE '__/_/____' THEN
                SUBSTR(DATE_ASSIGNED, 6, 4)
                || '-'
                ||
                '0'
                || SUBSTR(DATE_ASSIGNED, 4, 1)
                   || '-'
                   ||
                SUBSTR(DATE_ASSIGNED, 1, 2)
            WHEN DATE_ASSIGNED LIKE '_/_/____' THEN
                SUBSTR(DATE_ASSIGNED, 5, 4)
                || '-'
                ||
                '0'
                || SUBSTR(DATE_ASSIGNED, 3, 1)
                   || '-'
                   ||
                '0'
                || SUBSTR(DATE_ASSIGNED, 1, 1)
            ELSE
                NULL
        END          AS ASSIGNED_DATE
    FROM
        HOUSEHOLDS
    WHERE
        DATE_ASSIGNED IS NOT NULL
), ORDERED_DATES AS (
    SELECT
        ASSIGNED_DATE,
        COUNT(*)      AS ASSIGNMENTS
    FROM
        DATES
    WHERE
        ASSIGNED_DATE IS NOT NULL
    GROUP BY
        ASSIGNED_DATE
    ORDER BY
        ASSIGNED_DATE
)
SELECT
    ASSIGNED_DATE,
    ASSIGNMENTS,
    SUM(ASSIGNMENTS) OVER (ORDER BY ASSIGNED_DATE) AS CUMULATIVE_ASSIGNMENTS
FROM
    ORDERED_DATES;

-- 12. Referral rate by month and income source
SELECT
    CASE
        WHEN DATE_ASSIGNED LIKE '__/__/____' THEN
            SUBSTR(DATE_ASSIGNED, 7, 4)
        WHEN DATE_ASSIGNED LIKE '_/__/____' THEN
            SUBSTR(DATE_ASSIGNED, 6, 4)
        WHEN DATE_ASSIGNED LIKE '__/_/____' THEN
            SUBSTR(DATE_ASSIGNED, 6, 4)
        WHEN DATE_ASSIGNED LIKE '_/_/____' THEN
            SUBSTR(DATE_ASSIGNED, 5, 4)
        ELSE
            NULL
    END                             AS YEAR,
    CASE
        WHEN DATE_ASSIGNED LIKE '__/__/____' THEN
            SUBSTR(DATE_ASSIGNED, 4, 2)
        WHEN DATE_ASSIGNED LIKE '_/__/____' THEN
            SUBSTR(DATE_ASSIGNED, 3, 2)
        WHEN DATE_ASSIGNED LIKE '__/_/____' THEN
            '0'
            || SUBSTR(DATE_ASSIGNED, 4, 1)
        WHEN DATE_ASSIGNED LIKE '_/_/____' THEN
            '0'
            || SUBSTR(DATE_ASSIGNED, 3, 1)
        ELSE
            NULL
    END                             AS MONTH,
    INCOME_SOURCE,
    COUNT(*)                        AS TOTAL_HOUSEHOLDS,
    COUNT(
        CASE
            WHEN SERVICE_TYPE != 'No Referral' THEN
                1
        END)                        AS REFERRED_HOUSEHOLDS,
    ROUND(COUNT(
        CASE
            WHEN SERVICE_TYPE != 'No Referral' THEN
                1
        END) * 100.0 / COUNT(*), 2) AS REFERRAL_RATE_PCT
FROM
    HOUSEHOLDS
WHERE
    DATE_ASSIGNED IS NOT NULL
GROUP BY
    YEAR,
    MONTH,
    INCOME_SOURCE
ORDER BY
    YEAR,
    MONTH,
    TOTAL_HOUSEHOLDS DESC;