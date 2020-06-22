-- databade: "publications"
-- Lab: Lab - Advanced MySQL
-- Link to lab: https://github.com/ironhack-datalabs/data-ber-06-20/tree/master/Labs/module-1_labs/03_mysql/06_lab-advanced-mysql

-- Challenge 1 - Most Profiting Authors
-- Approach: Creating MySQL temporary tables in the initial steps, and query the temporary tables in the subsequent steps.

-- Step 1: Calculate the royalties of each sales for each author

CREATE TEMPORARY TABLE royalty_per_author AS (
SELECT 
	a.au_id																	AS author_id,
	ta.title_id 																AS title_id,
	t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100		AS royalty
FROM authors a
	LEFT JOIN titleauthor ta
	ON a.au_id = ta.au_id
		LEFT JOIN titles t
		ON ta.title_id = t.title_id
			LEFT JOIN sales s
			ON t.title_id = s.title_id
			);

-- Step 2: Aggregate the total royalties for each title for each author

CREATE TEMPORARY TABLE royalty_per_title AS (
SELECT 
	ra.title_id,
	ra.author_id,
	SUM(ra.royalty)																AS total_royalties
FROM royalty_per_author ra
GROUP BY 
	title_id,
	author_id
	);

-- Step 3: Calculate the total profits of each author

-- Now that each title has exactly one row for each author where the advance and royalties are available, we are ready to obtain the eventual output. Using the output from Step 2, write a query to obtain the following output:

-- Author ID
-- Profits of each author by aggregating the advance and total royalties of each title
-- Sort the output based on a total profits from high to low, and limit the number of rows to 3.

SELECT
	author_id,
	SUM(total_royalties) 														AS profits_per_author
FROM royalty_per_title rt
GROUP BY author_id
ORDER BY profits_per_author DESC;

-- Challenge 2 - Alternative Solution
-- Approach: Derived tables





