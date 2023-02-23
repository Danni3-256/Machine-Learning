/****** Script for SelectTopNRows command from SSMS  ******/
SELECT *
  FROM [socialBuzz_dbase].[dbo].[social_buzz ] 

SELECT COUNT(Content_ID) AS Rows
  FROM [socialBuzz_dbase].[dbo].[social_buzz ] ---- We have 24573 rows

SELECT DISTINCT Content_Type
  FROM [socialBuzz_dbase].[dbo].[social_buzz ] ---- 4 Unique content type values

SELECT DISTINCT Category
  FROM [socialBuzz_dbase].[dbo].[social_buzz ] ---- 16 unique content categories

SELECT DISTINCT Type
  FROM [socialBuzz_dbase].[dbo].[social_buzz ] ---- We also have 16 unique Reaction Types

SELECT DISTINCT Sentiment
  FROM [socialBuzz_dbase].[dbo].[social_buzz ] ---- Obviously here we have 3

SELECT DISTINCT Year(Datetime) AS Years
  FROM [socialBuzz_dbase].[dbo].[social_buzz ] ---- Our data runs from 2020 to 2021

  --------------------------------SENTIMENT ANALYSIS----------------------------------------------

  -- #Sentiment Distribution
SELECT Sentiment, COUNT(sentiment) As Count
  FROM [socialBuzz_dbase].[dbo].[social_buzz ]
  GROUP BY Sentiment
  ORDER BY 2 DESC

-- #Sentiment Distribution based on Score
SELECT Sentiment, SUM(Score) AS Score
  FROM [socialBuzz_dbase].[dbo].[social_buzz ]
  GROUP BY Sentiment
  ORDER BY 2 DESC

-- #What is the most common sentiment for each category?
SELECT Sentiment, Category, COUNT(sentiment) As Count
  FROM [socialBuzz_dbase].[dbo].[social_buzz ]
  GROUP BY Sentiment, Category
  ORDER BY 3 DESC 
-- animals seems to have the most common sentiment with a count of 1050 in positive sentiments and public speaking came last with 142 neutral sentiment

-- ================================ EDA ON Sentiment Scores=======================================================

SELECT Type AS [Reaction Type], Sentiment, Score
   FROM [socialBuzz_dbase].[dbo].[social_buzz ]
   WHERE Sentiment = 'positive'
   GROUP BY Type,Sentiment,Score
   ORDER BY 3 DESC -- Minimum score for positive sentiment is 30 and 75 is maximum score

SELECT Type AS [Reaction Type], Sentiment, Score
   FROM [socialBuzz_dbase].[dbo].[social_buzz ]
   WHERE Sentiment = 'neutral'
   GROUP BY Type,Sentiment,Score
   ORDER BY 3 DESC -- Minimum Score for neutral sentiment is 20 and 35 for the maximum score

SELECT Type AS [Reaction Type], Sentiment, Score
   FROM [socialBuzz_dbase].[dbo].[social_buzz ]
   WHERE Sentiment = 'negative'
   GROUP BY Type,Sentiment,Score
   ORDER BY 3 DESC -- Minimum score for negative sentiment is 0 and 15 for the maximum score

-- #What is the average sentiment score for each content category?
SELECT Category, Sentiment, AVG(Score) AS [Average Score]
   FROM [socialBuzz_dbase].[dbo].[social_buzz ]
   WHERE Sentiment = 'positive'
   GROUP BY Category, Sentiment
   ORDER BY 3 DESC  -- Veganism, healthy eating, animals and technology all come in 1st place with a Positive Sentiment average score of 60

SELECT Category, Sentiment, AVG(Score) AS [Average Score]
   FROM [socialBuzz_dbase].[dbo].[social_buzz ]
   WHERE Sentiment = 'negative'
   GROUP BY Category, Sentiment
   ORDER BY 3 DESC  

-- #Which content received the highest sentiment score?
SELECT Content_Type, SUM(Score) AS [Score]
  FROM [socialBuzz_dbase].[dbo].[social_buzz ]
  GROUP BY Content_Type
  ORDER BY 2 DESC               ----- Photo did with a total score of -------"262,838"------

-- #Which content received the highest Positive sentiment score?
SELECT Content_Type, SUM(Score) AS [Score]
  FROM [socialBuzz_dbase].[dbo].[social_buzz ]
  WHERE Sentiment = 'positive'
  GROUP BY Content_Type
  ORDER BY 2 DESC              ----- Again Photo did with a total score of -------"222,559"------

-- #Which content received the highest Positive sentiment score?
SELECT Content_Type, SUM(Score) AS [Score]
  FROM [socialBuzz_dbase].[dbo].[social_buzz ]
  WHERE Sentiment = 'negative'
  GROUP BY Content_Type
  ORDER BY 2 DESC             ----- Again Photo did with a total score of -------"17,219"------

   ----------------------------------------------Random Questions--------------------------------------------------------------


-- #Which content type received the most reactions?
SELECT Content_Type, COUNT(Type) AS Count
  FROM [socialBuzz_dbase].[dbo].[social_buzz ]
  GROUP BY Content_Type
  ORDER BY 2 DESC  -- Photos are dominating

-- #What is the total count of each reaction type in the dataset?
SELECT Type, COUNT(Type) As [Total count]
  FROM [socialBuzz_dbase].[dbo].[social_buzz ]
  GROUP BY Type
  ORDER BY 2 DESC -- The heart reaction type comes 1st with a total count of 1622, Intrigued came last with 1475

-- #What is the most popular content
SELECT Content_Type, COUNT(Content_Type) AS [Content Count]
  FROM [socialBuzz_dbase].[dbo].[social_buzz ]
  GROUP BY Content_Type
  ORDER BY 2 DESC             -- == Photo 

-- #What is the most popular Category
SELECT Category, COUNT(Category) AS [Category Count]
  FROM [socialBuzz_dbase].[dbo].[social_buzz ]
  GROUP BY Category
  ORDER BY 2 DESC        					-- == Animals-1897, science-1796,  healthy eating-1717, food-1699, technology-1698


--------------------------------YEAR & Monthly Analysis--------------------------------------------------

SELECT MIN(Datetime) AS [1st Date], MAX(Datetime) AS [Last date]
  FROM [socialBuzz_dbase].[dbo].[social_buzz ]
-- Data runs from 18th June 2020 to 18th June 2021

-- #Which Month had the highest sentiment scores
SELECT MONTH(Datetime) AS Month, SUM(Score) AS [Total Score]
  FROM [socialBuzz_dbase].[dbo].[social_buzz ]
  GROUP BY MONTH(Datetime)
  ORDER BY 2 DESC -- May - 86293 - February on the other hand has the lowest with 75509

-- #Yearly Distribution by Score
SELECT  Year(Datetime) AS Year, SUM(Score) AS [Total Score]
  FROM [socialBuzz_dbase].[dbo].[social_buzz ]
  GROUP BY Year(Datetime)
  ORDER BY 2 DESC

-- #Which year had the highest Positive Scores
SELECT  Year(Datetime) AS Year, SUM(Score) AS [Total Score]
  FROM [socialBuzz_dbase].[dbo].[social_buzz ]
  WHERE Sentiment = 'positive'
  GROUP BY Year(Datetime)
  ORDER BY 2 DESC  -- 2020 with 445545 as compared to 2021 with 378511

-- #Which month had the most posts
SELECT MONTH(Datetime) AS Month, COUNT(Content_ID) AS [Count of Posts]
  FROM [socialBuzz_dbase].[dbo].[social_buzz ]
  GROUP BY MONTH(Datetime)
  ORDER BY 2 DESC -- May - 2138 and Jan - 2126. February had the least posts with 1914

SELECT *
  FROM [socialBuzz_dbase].[dbo].[social_buzz ]



