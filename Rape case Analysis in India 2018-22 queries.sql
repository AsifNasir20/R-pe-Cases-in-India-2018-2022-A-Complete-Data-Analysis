-- 📊 Rape Case Analysis in India (2018–2022)

use r_casein_inida ; 

/*📅 Introduction

Sexual violence remains one of the gravest human rights issues in India. Despite reforms in law and rising public awareness, the frequency of reported rape cases continues to alarm policymakers, law enforcement, and citizens alike. This project aims to perform a comprehensive SQL-based analysis of rape cases across all Indian states and union territories (UTs) from 2018 to 2022.*/

-- Analysis 
-- 📉 7. SQL Queries & Visual Graph Types

--  Daily Average Rape Cases in 2022
SELECT 
  ROUND(
    SUM(COALESCE(Rape_2022_TotalCasesRegistered, 0)) / 365.0,
    2
  ) AS Avg_Rape_Cases_Per_Day_2022
FROM r_case_stateut;
-- 86.35


-- Q1:  Total Registered Rape Cases (2018–2022)'
SELECT 
  FORMAT(SUM(
    COALESCE(Rape_2018_TotalCasesRegistered, 0) +
    COALESCE(Rape_2019_TotalCasesRegistered, 0) +
    COALESCE(Rape_2020_TotalCasesRegistered, 0) +
    COALESCE(Rape_2021_TotalCasesRegistered, 0) +
    COALESCE(Rape_2022_TotalCasesRegistered, 0)
  ), 0) AS Total_Reported_Rape_Cases
FROM r_case_stateut;
-- 156,627


-- Q1:National Average Rape Cases (2018–2022)
SELECT 
  format(ROUND((
    SUM(COALESCE(Rape_2018_TotalCasesRegistered, 0)) +
    SUM(COALESCE(Rape_2019_TotalCasesRegistered, 0)) +
    SUM(COALESCE(Rape_2020_TotalCasesRegistered, 0)) +
    SUM(COALESCE(Rape_2021_TotalCasesRegistered, 0)) +
    SUM(COALESCE(Rape_2022_TotalCasesRegistered, 0))
  ) / 5),0) AS Avg_Annual_Rape_Cases_India
FROM r_case_stateut;
-- 31,325
/*Insights: ⚠️ The figure of 31,625 annual rape cases represents only reported incidents.
Due to factors like social stigma, fear of retaliation, and lack of trust in the justice system, a significant number of rape cases go unreported.
As a result, the actual number of rape incidents in India may be considerably higher, highlighting the urgent need for systemic reforms, awareness campaigns, and victim support systems to encourage safe and stigma-free reporting.*/

-- Q2:  Total Reported Rape Cases of Girls Below 18 Years (2018–2022)
SELECT 
  FORMAT(
    SUM(
      COALESCE(Rape_2018_Girls_Below_18, 0) +
      COALESCE(Rape_2019_Girls_Below_18, 0) +
      COALESCE(Rape_2020_Girls_Below_18, 0) +
      COALESCE(Rape_2021_Girls_Below_18, 0) +
      COALESCE(Rape_2022_Girls_Below_18, 0)
    ), 0
  ) AS Total_Rape_Cases_Below_18_Years_2018_2022
FROM r_case_stateut;
-- 20,925
/*Insights: Between 2018 and 2022, India reported a total of 20,925 rape cases involving girls below the age of 18. This means, on average, over 4,180 minors were victims of rape every year during this five-year period. */ 

-- Q3 Total Reported Rape Cases of Women Above 18 Years (2018–2022)
SELECT 
  FORMAT(
    SUM(
      COALESCE(Rape_2018_Women_Above_18, 0) +
      COALESCE(Rape_2019_Women_Above_18, 0) +
      COALESCE(Rape_2020_Women_Above_18, 0) +
      COALESCE(Rape_2021_Women_Above_18, 0) +
      COALESCE(Rape_2022_Women_Above_18, 0)
    ), 0
  ) AS Total_Rape_Cases_Above_18_Years_2018_2022
FROM r_case_stateut;
-- 135,702
/*Insights: From 2018 to 2022, India reported a total of 135,702 rape cases involving women above the age of 18. This translates to an average of over 27,100 adult women falling victim to rape every year — that’s nearly 74 cases every day.*/

-- Q4: Percentage of Charge-Sheeted Cases (2018–2022)
SELECT 
  FORMAT(
    SUM(COALESCE(CCS_2018, 0) + COALESCE(CCS_2019, 0) + COALESCE(CCS_2020, 0) + COALESCE(CCS_2021, 0) + COALESCE(CCS_2022, 0)) 
    / 
    SUM(COALESCE(Rape_2018_TotalCasesRegistered, 0) + COALESCE(Rape_2019_TotalCasesRegistered, 0) + COALESCE(Rape_2020_TotalCasesRegistered, 0) + COALESCE(Rape_2021_TotalCasesRegistered, 0) + COALESCE(Rape_2022_TotalCasesRegistered, 0)) 
    * 100, 
    2
  ) AS ChargeSheeting_Rate_Percentage
FROM r_case_stateut;
-- 82.85%
/*Insights: 💡 Insight:
Between 2018 and 2022, 82.85% of the total registered rape cases in India progressed to the charge-sheet stage. This means that out of every 100 reported cases, approximately 83 cases led to formal legal action by the police through the filing of charge sheets.

It also highlights that around 17% of reported rape cases did not result in a charge sheet. This gap raises concerns about:

Insufficient evidence or investigation delays,

Social or political influence,

Withdrawal of complaints due to pressure, or

Lack of victim support mechanisms.*/

-- Q5: Trial Completion % Out of Charge-Sheeted Cases
SELECT 
  FORMAT(
    SUM(COALESCE(CTC_2018, 0) + COALESCE(CTC_2019, 0) + COALESCE(CTC_2020, 0) + COALESCE(CTC_2021, 0) + COALESCE(CTC_2022, 0)) 
    / 
    SUM(COALESCE(CCS_2018, 0) + COALESCE(CCS_2019, 0) + COALESCE(CCS_2020, 0) + COALESCE(CCS_2021, 0) + COALESCE(CCS_2022, 0)) 
    * 100, 
    2
  ) AS Trial_Completion_Percentage
FROM r_case_stateut;
-- 57.21%
/*Insights: 💡 Insight:
Between 2018 and 2022, 57.21% of charge-sheeted rape cases in India were taken to trial completion.
This indicates that out of every 100 rape cases where a charge sheet was filed, only 57 cases reached a judicial verdict (either conviction, acquittal, or dismissal).
While more than half of the charge-sheeted cases progressed to the trial completion stage, the remaining ~43% stalled in the judicial system.
This incomplete follow-through can stem from:

Pending court backlogs,

Inadequate legal support for victims,

Withdrawal of cases, or

Systemic inefficiencies and delays.
*/
/*Insighst from the above 3: Only 43% of Reported Rape Cases in India Reach a Final Verdict */
/*Insighst from the above 3: Only 43% of Reported Rape Cases in India Reach a Final Verdict : "Rape Justice in India: 100 Reported, 83 Actioned, Only 43 Concluded */

-- Trial Completion % Out of Total registered Cases
SELECT 
  FORMAT(
    SUM(COALESCE(CTC_2018, 0) + COALESCE(CTC_2019, 0) + COALESCE(CTC_2020, 0) + COALESCE(CTC_2021, 0) + COALESCE(CTC_2022, 0)) 
    / 
    SUM(COALESCE(Rape_2018_TotalCasesRegistered, 0) + COALESCE(Rape_2019_TotalCasesRegistered, 0) + COALESCE(Rape_2020_TotalCasesRegistered, 0) + COALESCE(Rape_2021_TotalCasesRegistered, 0) + COALESCE(Rape_2022_TotalCasesRegistered, 0)) 
    * 100, 
    2
  ) AS Trial_Completion_Out_of_Total_Registered
FROM r_case_stateut;
-- 47.40




-- Q6: Top 5 Regions with Most Rape Cases (2018–2022) 
Select RegionName,
  FORMAT(
    SUM(
      COALESCE(Rape_2018_TotalCasesRegistered, 0) +
      COALESCE(Rape_2019_TotalCasesRegistered, 0) +
      COALESCE(Rape_2020_TotalCasesRegistered, 0) +
      COALESCE(Rape_2021_TotalCasesRegistered, 0) +
      COALESCE(Rape_2022_TotalCasesRegistered, 0)
    ), 0
  ) AS Total_Rape_Cases
FROM r_case_stateut
GROUP BY RegionName
ORDER BY SUM(
  COALESCE(Rape_2018_TotalCasesRegistered, 0) +
  COALESCE(Rape_2019_TotalCasesRegistered, 0) +
  COALESCE(Rape_2020_TotalCasesRegistered, 0) +
  COALESCE(Rape_2021_TotalCasesRegistered, 0) +
  COALESCE(Rape_2022_TotalCasesRegistered, 0)
) DESC
LIMIT 5;
/*Insights:  Rajasthan alone accounts for over 17% of all reported rape cases during this period (based on the national total of ~158,000 from earlier calculations), making it the most affected state in India.

*/

-- Q7: Top 3 UT with Most Rape Cases (2018–2022) 
SELECT 
 RegionName,
  FORMAT(
    SUM(
      COALESCE(Rape_2018_TotalCasesRegistered, 0) +
      COALESCE(Rape_2019_TotalCasesRegistered, 0) +
      COALESCE(Rape_2020_TotalCasesRegistered, 0) +
      COALESCE(Rape_2021_TotalCasesRegistered, 0) +
      COALESCE(Rape_2022_TotalCasesRegistered, 0)
    ), 0
  ) AS Total_Rape_Cases
FROM r_case_in_ut
GROUP BY RegionName
ORDER BY 
  SUM(
    COALESCE(Rape_2018_TotalCasesRegistered, 0) +
    COALESCE(Rape_2019_TotalCasesRegistered, 0) +
    COALESCE(Rape_2020_TotalCasesRegistered, 0) +
    COALESCE(Rape_2021_TotalCasesRegistered, 0) +
    COALESCE(Rape_2022_TotalCasesRegistered, 0)
  ) DESC
LIMIT 3;

-- or 
SELECT 
  RegionName,
  FORMAT(
    SUM(
      COALESCE(Rape_2018_TotalCasesRegistered, 0) +
      COALESCE(Rape_2019_TotalCasesRegistered, 0) +
      COALESCE(Rape_2020_TotalCasesRegistered, 0) +
      COALESCE(Rape_2021_TotalCasesRegistered, 0) +
      COALESCE(Rape_2022_TotalCasesRegistered, 0)
    ), 0
  ) AS Total_Rape_Cases
FROM r_case_stateut
WHERE RegionType = 'UT'
GROUP BY RegionName
ORDER BY 
  SUM(
    COALESCE(Rape_2018_TotalCasesRegistered, 0) +
    COALESCE(Rape_2019_TotalCasesRegistered, 0) +
    COALESCE(Rape_2020_TotalCasesRegistered, 0) +
    COALESCE(Rape_2021_TotalCasesRegistered, 0) +
    COALESCE(Rape_2022_TotalCasesRegistered, 0)
  ) DESC
LIMIT 3;

/*Insghts:Delhi alone accounts for over 75% of the total rape cases among all UTs, making it by far the most affected Union Territory in India when it comes to sexual violence.*/

-- Q8: Region with Most Rape Cases Involving Girls Below 18 Years (2018–2022)
SELECT 
  RegionName,
  FORMAT(
    SUM(
      COALESCE(Rape_2018_Girls_Below_18, 0) +
      COALESCE(Rape_2019_Girls_Below_18, 0) +
      COALESCE(Rape_2020_Girls_Below_18, 0) +
      COALESCE(Rape_2021_Girls_Below_18, 0) +
      COALESCE(Rape_2022_Girls_Below_18, 0)
    ), 0
  ) AS Total_Below18_Rape_Cases
FROM r_case_stateut
GROUP BY RegionName
ORDER BY 
  SUM(
    COALESCE(Rape_2018_Girls_Below_18, 0) +
    COALESCE(Rape_2019_Girls_Below_18, 0) +
    COALESCE(Rape_2020_Girls_Below_18, 0) +
    COALESCE(Rape_2021_Girls_Below_18, 0) +
    COALESCE(Rape_2022_Girls_Below_18, 0)
  ) DESC
LIMIT 5;
/*Insights: These numbers highlight that Rajasthan alone accounts for nearly double the cases reported in Madhya Pradesh, and almost 20–25% of all underage rape cases in the country (based on total ~20,925 from earlier analysis).

*/

-- Q9: Percentage of Below 18 Cases in Total Rape Cases (Per Region)
SELECT 
  RegionName,
  ROUND(
    SUM(
      COALESCE(Rape_2018_Girls_Below_18, 0) +
      COALESCE(Rape_2019_Girls_Below_18, 0) +
      COALESCE(Rape_2020_Girls_Below_18, 0) +
      COALESCE(Rape_2021_Girls_Below_18, 0) +
      COALESCE(Rape_2022_Girls_Below_18, 0)
    ) * 100.0 /
    SUM(
      COALESCE(Rape_2018_TotalCasesRegistered, 0) +
      COALESCE(Rape_2019_TotalCasesRegistered, 0) +
      COALESCE(Rape_2020_TotalCasesRegistered, 0) +
      COALESCE(Rape_2021_TotalCasesRegistered, 0) +
      COALESCE(Rape_2022_TotalCasesRegistered, 0)
    ), 2
  ) AS Percentage_Below_18
FROM r_case_stateut
GROUP BY RegionName
ORDER BY Percentage_Below_18 DESC
LIMIT 5;
/*Insights: In regions like Goa, Chandigarh, and Himachal Pradesh, more than half of reported rape victims are under the age of 18.
This insight demands urgent attention from policymakers, law enforcement, and child welfare organizations to strengthen preventive, legal, and support frameworks to protect minors from sexual violence.*/

-- Q10 :Year-over-Year Rape Cases by Region (2018–2022)
SELECT 
  RegionName,
  SUM(COALESCE(Rape_2018_TotalCasesRegistered, 0)) AS Rape_2018,
  SUM(COALESCE(Rape_2019_TotalCasesRegistered, 0)) AS Rape_2019,
  SUM(COALESCE(Rape_2020_TotalCasesRegistered, 0)) AS Rape_2020,
  SUM(COALESCE(Rape_2021_TotalCasesRegistered, 0)) AS Rape_2021,
  SUM(COALESCE(Rape_2022_TotalCasesRegistered, 0)) AS Rape_2022
FROM r_case_stateut
GROUP BY RegionName
ORDER BY Rape_2022 DESC
limit 5;
/*Insights: Rajasthan:
Reported the highest rape cases each year, peaking at 6,337 in 2021, indicating a consistently severe situation.

🔹 Uttar Pradesh:
Cases fluctuated, with a drop in 2020 (2,769) and a rebound to 3,690 in 2022, suggesting inconsistent trends.

🔹 Madhya Pradesh:
Saw a sharp decline from 5,433 in 2018 to around 3,000 annually, reflecting a notable reduction over time.

🔹 Maharashtra:
Showed a steady upward trend from 2,142 in 2018 to 2,904 in 2022, indicating rising incidents.

🔹 Haryana:
Though reporting the lowest among the five, cases increased from 1,296 to 1,787, pointing to a growing concern. */

/* Q11:State/UT with Least Reported Rape Cases (2018–2022)*/
SELECT RegionName,
       (COALESCE(Rape_2018_TotalCasesRegistered, 0) +
        COALESCE(Rape_2019_TotalCasesRegistered, 0) +
        COALESCE(Rape_2020_TotalCasesRegistered, 0) +
        COALESCE(Rape_2021_TotalCasesRegistered, 0) +
        COALESCE(Rape_2022_TotalCasesRegistered, 0)) AS Total_Cases_2018_2022
FROM r_case_in_state
ORDER BY Total_Cases_2018_2022 ASC
LIMIT 5;
/*Insights: 🔹 Nagaland:
Reported only 33 cases, possibly due to close-knit tribal communities, strong social monitoring, or underreporting influenced by cultural norms.

🔹 Sikkim:
With just 60 cases, Sikkim’s high literacy rate, gender-sensitive policies, and smaller population may contribute to its low figures.

🔹 Mizoram:
Recorded 165 cases, potentially reflecting strong community cohesion and traditional value systems that discourage such crimes.

🔹 Manipur:
Reported 188 cases, possibly influenced by both cultural conservatism and conflict-related law enforcement presence in sensitive zones.

🔹 Goa:
Despite being a tourist hub, Goa's relatively low 338 cases may reflect effective urban policing and higher public awareness, though population size also plays a role.*/


-- Year-on-Year Total Rape Cases in India (2018–2022)
SELECT 
  '2018' AS Year,
  FORMAT(SUM(COALESCE(Rape_2018_TotalCasesRegistered, 0)), 0) AS Total_Cases
FROM r_case_stateut

UNION ALL

SELECT 
  '2019' AS Year,
  FORMAT(SUM(COALESCE(Rape_2019_TotalCasesRegistered, 0)), 0) AS Total_Cases
FROM r_case_stateut

UNION ALL

SELECT 
  '2020' AS Year,
  FORMAT(SUM(COALESCE(Rape_2020_TotalCasesRegistered, 0)), 0) AS Total_Cases
FROM r_case_stateut

UNION ALL

SELECT 
  '2021' AS Year,
  FORMAT(SUM(COALESCE(Rape_2021_TotalCasesRegistered, 0)), 0) AS Total_Cases
FROM r_case_stateut

UNION ALL

SELECT 
  '2022' AS Year,
  FORMAT(SUM(COALESCE(Rape_2022_TotalCasesRegistered, 0)), 0) AS Total_Cases
FROM r_case_stateut;

-- Compare Under 18 vs Above 18 Victims (2018–2022 Combined)
SELECT 
  ROUND(100.0 * SUM(Minor) / SUM(Total), 2) AS Minor_cases,
  ROUND(100.0 * SUM(Adult) / SUM(Total), 2) AS Adult_cases
FROM (
  SELECT 
    (COALESCE(Rape_2018_Girls_Below_18, 0) +
     COALESCE(Rape_2019_Girls_Below_18, 0) +
     COALESCE(Rape_2018_Girls_Below_18, 0) +
     COALESCE(Rape_2021_Girls_Below_18, 0) +
     COALESCE(Rape_2022_Girls_Below_18, 0)) AS Minor,

    (COALESCE(Rape_2018_TotalCasesRegistered, 0) +
     COALESCE(Rape_2019_TotalCasesRegistered, 0) +
     COALESCE(Rape_2020_TotalCasesRegistered, 0) +
     COALESCE(Rape_2021_TotalCasesRegistered, 0) +
     COALESCE(Rape_2022_TotalCasesRegistered, 0)) AS Total,

    ((COALESCE(Rape_2018_TotalCasesRegistered, 0) +
      COALESCE(Rape_2019_TotalCasesRegistered, 0) +
      COALESCE(Rape_2020_TotalCasesRegistered, 0) +
      COALESCE(Rape_2021_TotalCasesRegistered, 0) +
      COALESCE(Rape_2022_TotalCasesRegistered, 0)) -

     (COALESCE(Rape_2018_Girls_Below_18, 0) +
     COALESCE(Rape_2019_Girls_Below_18, 0) +
     COALESCE(Rape_2020_Girls_Below_18, 0) +
     COALESCE(Rape_2021_Girls_Below_18, 0) +
     COALESCE(Rape_2022_Girls_Below_18, 0))) AS Adult
  FROM r_case_stateut
) AS Comparison;

-- Total Registered Rape Cases in UTs (2018–2022)
SELECT 
  SUM(COALESCE(Rape_2018_TotalCasesRegistered, 0) +
      COALESCE(Rape_2019_TotalCasesRegistered, 0) +
      COALESCE(Rape_2020_TotalCasesRegistered, 0) +
      COALESCE(Rape_2021_TotalCasesRegistered, 0) +
      COALESCE(Rape_2022_TotalCasesRegistered, 0)) AS Total_UT_Registered_Cases
FROM r_case_in_ut;
-- 7874

-- Total Rape Cases Registered in States vs UTs (2018–2022)
WITH state_data AS (
  SELECT 
    SUM(COALESCE(Rape_2018_TotalCasesRegistered, 0) +
        COALESCE(Rape_2019_TotalCasesRegistered, 0) +
        COALESCE(Rape_2020_TotalCasesRegistered, 0) +
        COALESCE(Rape_2021_TotalCasesRegistered, 0) +
        COALESCE(Rape_2022_TotalCasesRegistered, 0)) AS state_total
  FROM r_case_in_state
),
ut_data AS (
  SELECT 
    SUM(COALESCE(Rape_2018_TotalCasesRegistered, 0) +
        COALESCE(Rape_2019_TotalCasesRegistered, 0) +
        COALESCE(Rape_2020_TotalCasesRegistered, 0) +
        COALESCE(Rape_2021_TotalCasesRegistered, 0) +
        COALESCE(Rape_2022_TotalCasesRegistered, 0)) AS ut_total
  FROM r_case_in_ut
),
combined AS (
  SELECT 
    s.state_total,
    u.ut_total,
    (s.state_total + u.ut_total) AS total_cases
  FROM state_data s, ut_data u
)
SELECT 
  'State' AS Category,
  state_total AS Total_Cases,
  ROUND(100.0 * state_total / total_cases, 2) AS Percentage_Share
FROM combined

UNION ALL

SELECT 
  'UT' AS Category,
  ut_total AS Total_Cases,
  ROUND(100.0 * ut_total / total_cases, 2) AS Percentage_Share
FROM combined;

-- Delhi’s % of Total UT Rape Cases (2018–2022)
WITH ut_total AS (
  SELECT 
    SUM(COALESCE(Rape_2018_TotalCasesRegistered, 0) +
        COALESCE(Rape_2019_TotalCasesRegistered, 0) +
        COALESCE(Rape_2020_TotalCasesRegistered, 0) +
        COALESCE(Rape_2021_TotalCasesRegistered, 0) +
        COALESCE(Rape_2022_TotalCasesRegistered, 0)) AS total_ut_cases
  FROM r_case_in_ut
),
delhi_total AS (
  SELECT 
    SUM(COALESCE(Rape_2018_TotalCasesRegistered, 0) +
        COALESCE(Rape_2019_TotalCasesRegistered, 0) +
        COALESCE(Rape_2020_TotalCasesRegistered, 0) +
        COALESCE(Rape_2021_TotalCasesRegistered, 0) +
        COALESCE(Rape_2022_TotalCasesRegistered, 0)) AS delhi_cases
  FROM r_case_in_ut
  WHERE RegionName = 'Delhi'
)
SELECT 
  d.delhi_cases AS Delhi_Total_Cases,
  u.total_ut_cases AS Total_UT_Cases,
  ROUND(100.0 * d.delhi_cases / u.total_ut_cases, 2) AS Delhi_Percentage_Share
FROM delhi_total d, ut_total u;

/*17% of victims are minors

83% are adults

Now let’s verify and explain how "1 in every 6" is derived from 17%.

✅ Step-by-Step Calculation:
We have 17% minors
→ That means 17 out of 100 victims are minors.

Convert to "1 in X" format
Divide 100 by 17:

100
17
≈
5.88
17
100
​
 ≈5.88
Round to the nearest whole number:
→ 5.88 ≈ 6*/

-- Rank All States & UTs by Least Rape Cases (2018–2022)
SELECT 
  RegionName,
  'State' AS RegionType,
  SUM(COALESCE(Rape_2018_TotalCasesRegistered, 0) +
      COALESCE(Rape_2019_TotalCasesRegistered, 0) +
      COALESCE(Rape_2020_TotalCasesRegistered, 0) +
      COALESCE(Rape_2021_TotalCasesRegistered, 0) +
      COALESCE(Rape_2022_TotalCasesRegistered, 0)) AS Total_Cases
FROM r_case_in_state
GROUP BY RegionName 
ORDER BY Total_Cases ASC ; 




-- Underage Rape Victims in Rajasthan: % of National Total
SELECT 
  ROUND(
   SUM(COALESCE(Rape_2018_Girls_Below_18, 0) +
        COALESCE(Rape_2019_Girls_Below_18, 0) +
        COALESCE(Rape_2020_Girls_Below_18, 0) +
        COALESCE(Rape_2021_Girls_Below_18, 0) +
        COALESCE(Rape_2022_Girls_Below_18, 0)),
    2
  ) AS Rajasthan_Under18_Percentage
FROM r_case_stateut
where regionname = "rajasthan" ;


