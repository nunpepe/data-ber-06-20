-- database: "bank"
-- Lab: SQL - Aggregation
-- Link to lab: https://github.com/ironhack-datalabs/data-ber-06-20/blob/master/Labs/module-1_labs/03_mysql/04_lab-sql-aggregations/lab-2-sql-aggregations.md

-- 1. From the client table, of all districts with a district_id lower than 10, how many clients are from each district_id? Show the results sorted by district_id in ascending order.

SELECT 
	district_id,
	COUNT(client_id) AS clients
FROM bank.client
WHERE district_id < 10
GROUP BY district_id
ORDER BY district_id;

-- 2. From the card table, how many cards exist for each type? Rank the result starting with the most frequent type.

SELECT 
	type,
	COUNT(card_id) AS number_cards
FROM bank.card
GROUP BY type
ORDER BY number_cards DESC;

-- 3. Using the loan table, print the top 10 account_ids based on the sum of all of their loan amounts.

SELECT 
	account_id,
	SUM(amount) AS total_amount
FROM loan
GROUP BY account_id
ORDER BY total_amount DESC
LIMIT 10;

-- 4. From the loan table, retrieve the number of loans issued for each day, before (excl) 930907, ordered by date in descending order

SELECT 
	l.date,
	COUNT(loan_id) AS total_loans
FROM loan l
WHERE l.date < 930907
GROUP BY l.date
ORDER BY l.date DESC;

-- 5. From the loan table, for each day in December 1997, count the number of loans issued for each unique loan duration, ordered by date and duration, both in ascending order. You can ignore days without any loans in your output.

SELECT 
	l.date 				AS reg_date,
	l.duration			AS reg_duration,
	COUNT(loan_id)		AS total_loans,
	YEAR(date) 			AS year_date,
	MONTH(date) 			AS month_date
FROM bank.loan l
WHERE YEAR(date) = 1997 AND MONTH(date) = 12
GROUP BY 
	reg_date,
	reg_duration
ORDER BY 
	reg_date,
	reg_duration;


-- 6. From the trans table, for account_id 396, sum the amount of transactions for each type (VYDAJ = Outgoing, PRIJEM = Incoming). Your output should have the account_id, the type and the sum of amount, named as total_amount. Sort alphabetically by type.

SELECT 
	t.account_id			AS t_account,
	t.type 				AS t_type,
	SUM(t.amount)		 	AS total_amount
FROM trans t
WHERE account_id = 396
GROUP BY 
	t_type
ORDER BY t_type;

-- 7. From the previous output, translate the values for type to English, rename the column to transaction_type, round total_amount down to an integer

SELECT 
	t.account_id						AS t_account,
	CASE
		WHEN t.type = 'PRIJEM' THEN 'INCOMING'
		WHEN t.type = 'VYDAJ' THEN 'OUTGOING'
	END 								AS plain_english,
	ROUND(SUM(t.amount))		 	AS total_amount
FROM trans t
WHERE account_id = 396
GROUP BY 
	plain_english
ORDER BY plain_english;

-- 8. From the previous result, modify you query so that it returns only one row, with a column for incoming amount, outgoing amount and the difference

SELECT 
	account_id,
	SUM(IF(type = 'PRIJEM', amount, 0))												AS incoming,
	SUM(IF(type = 'VYDAJ', amount, 0))												AS outcoming,
	SUM(IF(type = 'PRIJEM', amount, 0)) - SUM(IF(type = 'VYDAJ', amount, 0))		AS diference
FROM trans
WHERE account_id = 396
GROUP BY 1; 

-- 9. Continuing with the previous example, rank the top 10 account_ids based on their difference

SELECT 
	account_id,
	SUM(IF(type = 'PRIJEM', amount, 0)) - SUM(IF(type = 'VYDAJ', amount, 0))		AS diference
FROM trans
GROUP BY account_id
ORDER BY diference DESC; 