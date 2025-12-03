# harveytakehome
Repo for Harvey Takehome Assignment

Author: Babacar Diouf
Date: 2025-12-02

## Assumptions from a general Business Context:

Because the take home assignment does not provide the full product context, I made the applicable assumptions below based on material in which I have done self research on public material, the data provided, and general understanding of the product patterns.

Product Assumptions:

As provided on the take home assignment, Harvey is a tool used daily by legal professionals for various tasks to draft, summarize, research, and perform genera legal tasks.

### Data Assumptions:

  Events Table: Represents user initiated actions within Harvey across multiple lines of products.
    Event_Type -> I will assume this is the product being used. Assistant being the general AI   assisant in exeucitng summary or queries. Workflow being a automated workflow sandbox with various paths that can be created and user dependencies. Finally Vault being a storage for documents which can be used by mulitple products for reference.
  
  Num Docs: My assumption is that this shows the documents utilized or referenced during the repsective products usage (assistant, vault, or workflow)

  Feedback Score: Will assume this is a user initiated review of the particular rating of the feedback of Harvey's response for the repsective query effort.

  Created: When the query got initiated.

  I will also assume each row in the events table it a query associated with a particular user.

  Firms Table and Users Table -> Are straight forward in terms of when a certain user or firm is created along with the Title on the users table which could be associated with a drop down selection for finite roles(likely used as access controls potentially or reviewers for a particular task).
    - ARR -> Annual Reoccuring Revenue -> This is likely how much Harvey is getting from each firm utilizing its product from a tracking perspective.


## Overall Takehome Approach:
I have ran this project on dbtLabs which links to my github via: https://github.com/theonlybdiouf/harveytakehome/

In short -> The whole project was ran on dbtLabs(cloud) utilizing Supabase(postGRE) as a warehouse source and target) -> the data split each data (users,firms,events) into csvs into dbt seed.
For each respective tasks I have created the applicable models. All models were materialized as tables suitable for downstream analytics:

I will assume the raw events comes a daily basis and configure jobs on dbtlabs to run this on daily basis. Please find model details below.

### User Engagement
  (/models/user_engagement.sql)

This model captures each users monthly engagement using columns:
- user_id
- month
- year,
- Query Counts (count of events that have occured)
- Last Active Date
- Query Types (an array_agg of distinct event types: Assistant, Workflow, Vault)
- Num Docs total
- Avg feedback score
- engagement level (defined by a threshold/case statement rule):
      - High -> Queries >= 40 or Num_Docs >= 100
      - Avg -> Queries BETWEEN 10 and 39 or Num_docs BETWEEN 10 and 15
      - Low - > anything lower than above thresholds.
(of course these can be tweaked as this would be defined by the business)

This model allows identifying of high value users.


### Firms Usage
(/models/firms_usage.sql)

This model captures each firms daily engagement utilizing columns below formulated with both firm metadata and events data:
- Firm ID (firm metadata)
- Firm Size (firm metadata)
- Firm ARR in thousands (firm metadata)
- date 
- User counts (distinct)
- total_queries (count of queries)
- total_num_docs sum of total_docs

This model allows monitoringfirm-level health and segmentation at a daily level.


### Daily Events Summary
(/models/daily_events_summary)

This model captures event data summary at a daily level including columns:
- date
- event_type (Assistant, Workflow, Vault)
- total_events_counts
- unique users (distinct)
- daily active users - overall distinct user for the day

This model allows analysis on daily active user trends tieing with specific product usage.
I chose this model as this could help start analysis on usage gaps which can lead to UX and product experience improvements to grow the number of unique users per product per day.

## Model Outputs:
I've included the model outputs within the model_outputs folder as csv's for the sake of demonstration.

## Model Scalabilty and Performance Considerations

For the raw data we can partition by event_date for firm,users, and events.
Will allow for reprocessing and scalability, easier to target an area for backfill as well.

From a table perspective we can partition/index on common SELECTS and WHERE conditions that end users will utilze.

Finally we could leverage spark processing to scale even further the creation of tables and procesing of raw inputs as Harvey scales to million + users.

## Analytics Questions 
Can be found on the Analytics Questions.ipynb notebook attached.

