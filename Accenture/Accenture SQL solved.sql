Create table public.reaction
(
	content_id 	UUID
   ,reaction_type character(15)
   ,date_time timestamp
);

Create table public.content
(
	content_id 	UUID
   ,content_type character(15)
   ,category character(20)
);

Create table public.reaction_types
(
	Reaction_Type	character(15)
   ,Sentiment	character(15)
   ,Score  integer
);
------------------------------------------
/* select *								 
from content 							 
*/										 
------------------------------------------
With accenture as
(
select 
	 c.content_id
	,c.content_type
	,lower(c.category) as category
	,r.reaction_type
	,r.date_time
	,rt.sentiment
	,rt.score
from content c
left join reaction r
on c.content_id = r.content_id
inner join reaction_types rt
on r.reaction_type = rt.reaction_type
)
	select
		 category
		,sum(score) as reaction_score
		,count(score) as category_amount
	from accenture
	group by 1
	order by 2 desc
	limit 5 ;


|Column  Name	Type
|tweet_id	integer
|user_id	integer
|msg	string
|tweet_date	timestamp






