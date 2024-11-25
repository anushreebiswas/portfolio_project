I have completed three very interesting projects in SQL.Have a look at them!I promise they are fun to go through! 

A.	When Was the Golden Age of Video Games?

Video games are big business: the global gaming market is projected to be worth more than $300 billion by 2027 according to Mordor Intelligence. With so much money at stake, the major game publishers are hugely incentivized to create the next big hit. But are games getting better, or has the golden age of video games already passed?
In this project, we'll explore the top 400 best-selling video games created between 1977 and 2020. We'll compare a dataset on game sales with critic and user reviews to determine whether or not video games have improved as the gaming market has grown.
The database contains two tables. Its limited each table to 400 rows for this project, but you can find the complete dataset with over 13,000 games on Kaggle.

TABLE: game_sales
column	type	meaning
game	varchar	Name of the video game
platform	varchar	Gaming platform
publisher	varchar	Game publisher
developer	varchar	Game developer
games_sold	float	Number of copies sold (millions)
year	int	Release year

TABLE: reviews
column	type	meaning
game	varchar	Name of the video game
critic_score	float	Critic score according to Metacritic
user_score	float	User score according to Metacritic




B. 	Analyzing American Baby Name Trends
                                                            
How have American baby name tastes changed since 1920? Which names have remained popular for over 100 years, and how do those names compare to more recent top baby names? These are considerations for many new parents, but the skills we'll practice while answering these queries are broadly applicable. After all, understanding trends and popularity is important for many businesses, too!
This data was originally provided by the United States Social Security Administration but the preprocessed data has been taken from Izzy Weber at Data Camp. It lists first names along with the number and sex of babies they were given to in each year. For processing speed purposes, we've limited the dataset to first names which were given to over 5,000 American babies in a given year. Our data spans 101 years, from 1920 through 2020.

TABLE: baby_names
column	type	meaning
year	int	year
first_name	varchar	first name
sex	varchar	sex of babies given first_name
num	int	number of babies of sex given first_name in that year


c. The World Bank's international debt data

It's not that we humans only take debts to manage our necessities. A country may also take debt to manage its economy. For example, infrastructure spending is one costly ingredient required for a country's citizens to lead comfortable lives. The World Bank is the organization that provides debt to countries.
I analyzed the  international debt data collected by The World Bank. The dataset(taken from Sayak Paul at Data Camp) contains information about the amount of debt (in USD) owed by developing countries across several categories. We are going to find the answers to questions like:
•	What is the total amount of debt that is owed by the countries listed in the dataset?
•	Which country owns the maximum amount of debt and what does that amount look like?
•	What is the average amount of debt owed by countries across different debt indicators?

country_name	country_code	indicator_name	indicator_code	debt
Afghanistan	AFG	Disbursements on external debt, long-term (DIS, current US$)	DT.DIS.DLXF.CD	72894453.700000003
Afghanistan	AFG	Interest payments on external debt, long-term (INT, current US$)	DT.INT.DLXF.CD	53239440.10000000






