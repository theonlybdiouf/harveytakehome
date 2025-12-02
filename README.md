# harveytakehome
Repo for Harvey Takehome Assignment

Author: Babacar Diouf
Date: 2025-12-02

**Assumptions from a general Business Context:
**
Because the take home assignment does not provide the full product context, I made the applicable assumptions below based on material in which I have done self research on public material, the data provided, and general understanding of the product patterns.

Product Assumptions:

As provided on the take home assignment, Harvey is a tool used daily by legal professionals for various tasks to draft, summarize, research, and perform genera legal tasks.

Data Assumptions:

  Events Table: Represents user initiated actions within Harvey across multiple lines of products.
    Event_Type -> I will assume this is the product being used. Assistant being the general AI   assisant in exeucitng summary or queries. Workflow being a automated workflow sandbox with various paths that can be created and user dependencies. Finally Vault being a storage for documents which can be used by mulitple products for reference.
  
  Num Docs: My assumption is that this shows the documents utilized or referenced during the repsective products usage (assistant, vault, or workflow)

  Feedback Score: Will assume this is a user initiated review of the particular rating of the feedback of Harvey's response for the repsective query effort.

  Created: When the query got initiated.

  I will also assume each row in the events table it a query associated with a particular user.

  Firms Table and Users Table -> Are straight forward in terms of when a certain user or firm is created along with the Title on the users table which could be associated with a drop down selection for finite roles(likely used as access controls potentially or reviewers for a particular task).
    - ARR -> Annual Reoccuring Revenue -> This is likely how much Harvey is getting from each firm utilizing its product from a tracking perspective.


Overall Takehome Approach:
I have ran this project on dbtLabs which links to my github via: https://github.com/theonlybdiouf/harveytakehome/

In short -> Took the data split each data (users,firms,events) into csvs into dbt seed.
For each respective tasks I have created the applicable models:

It is important to note that we understand data can come at a daily level.

**User Engagement
**  (/models/user_engagement.sql)
If we want to understand User Engagement based on the requirement


We can assume the event_type is a query. And the number of documents for the event type we can assume are the number of queries being done. In this case we understand that a user query counts are: for the month -> query_counts (count(*)), last_active (latest_timestamp), query_types(event_types), engagement_level (This could be based on a defined case statement, where if a certain condition of query_types and counts are reached they are low, medium, high.

For simplicity terms I could define a high engagement user a user with more then 40 queries or more than 100 document uploads for the month.

I would also assume here that query counts between a certain threshold would be an average user (AVG) between 10 - 39 queries or between 10-15 document uploads

Finally a low user we cans consider a user who  has urilized less than 10 queries or less than 10 document uploads


**Firms Usage
** (/models/firms_usage.sql)

Daily updated,
Can have firm metadataFirm_name,Firm_id,created_date,
last_active, 
active_users(count of users for the month if engaged more than 3 times) total_queries (COUNT OF all queries or rows per firm of respective user in events table), 
general ARR metadata


**Daily Events Summary
**  (/models/daily_events_summary)
For the third task I have 
Will utilize daily event summary. Event in which we assume are a query that is tied to a query type or doc_upload
This would be helpful to understand what query_types people are using (product category) and understand how many total events occurred, and unique users, and even having a metric to track how many daily active users we are seeing  as a compactor to the unique users for that event_type for understanding improvements or gaps


Analytics Questions can be found on the notebook attached (tbd)

