Langsmith
==========


* How to understand the usage of langsmith threads from postgresql server; find actuve users, threads and interactions per day and convert to given time zone-
```
SELECT
	date_eastern,
	COUNT(DISTINCT thread_id) AS distinctthreadids,
	COUNT(thread_id) AS interactions,
	COUNT(DISTINCT user_id) AS distinctusers
FROM (
	SELECT
		thread_id,
		((checkpoint->>'ts')::timestamptz AT TIME ZONE 'America/New_York')::date AS date_eastern,
		metadata->>'user_id' AS user_id
	FROM public.checkpoints
	WHERE metadata->>'source' = 'input'
) AS subquery
GROUP BY
	date_eastern
ORDER BY
	date_eastern DESC
LIMIT 1000;
```
