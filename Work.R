library(tidyverse)
library(dplyr)
library(ggplot2)
library(plotly)

#Import Data
data <- read_csv("Social Media EngagementDataset.csv")

# Which platform has the highest average engagement rate? By Likes, Shares, comments and impressions per post.
tot_engage <- data %>%
  mutate(total_engagement = likes_count + shares_count + comments_count + impressions)

print(tot_engage)

# Show the platform with the highest average engagement
ave_engage <- tot_engage%>%
  group_by(platform) %>%
  summarise(engagement_rate = mean(total_engagement, na.rm = TRUE)) 

print(ave_engage)

# What day of the week sees the highest average engagement rate across platforms?

post_time_engage <- data %>%
  group_by(day_of_week) %>%
  summarise(ave_engage = mean(engagement_rate, na.rm = TRUE))

print(post_time_engage)

# Is there a best time to post on each platform? 
best_time <- data %>%
  mutate(hour = hour(timestamp)) %>%
  group_by(timestamp, location, platform) %>%
  summarise(avg_impressions = mean(impressions, na.rm = TRUE), .groups = "drop") %>%
  arrange(avg_impressions, desc(platform))

print(best_time)

# graph - location, and post time and engagment_rate
p <- ggplot(best_time, aes(x=platform, y=timestamp, fill = location)) +
  geom_boxplot() +
  theme_minimal() +
  labs(title = "Box Plot of the Best time to post based 
       on Average Engagement rate and Location", x="Platform", y="Timestamp")
ggplotly(p)

# Which locations have the highest average engagement rate? based on topic_category, product_name and brand_name?
loc_av <- data %>%
  group_by(location, topic_category, product_name, brand_name) %>%
  summarise(engagement_rate = mean(engagement_rate, na.rm = TRUE)) %>%
  arrange(desc(engagement_rate)) %>%
  slice(1)

print(loc_av)

# How does user_past_sentiment_avg impact current post sentiment or engagement rate ?

senti_level <- data %>% 
  group_by(sentiment_label, emotion_type, user_engagement_growth, user_past_sentiment_avg, engagement_rate) %>%
  summarise(user_past_sentiment_avg = mean(user_past_sentiment_avg, na.rm = TRUE)) %>%
  arrange(desc(user_past_sentiment_avg)) %>%
  slice(1)

print(senti_level)

# Which campaign or brand shows the most positive buzz change rate over time?
campa_brand <- data %>%
  group_by(brand_name, product_name, campaign_name, campaign_phase) %>%
  summarise(sentiment_score = mean(campaign_name, na.rm = TRUE)) %>% 
  arrange(desc(sentiment_score)) %>%
  slice(1)

print(campa_brand)
  