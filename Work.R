library(tidyverse)
library(dplyr)
library(ggplot2)
library(plotly)
library(countrycode)
library(ggiraph)

#Import Data
data <- read_csv("~/Marketing Data Project/Media-Engagement-Analysis/Media-Engagement-Analysis/Social Media Engagement Data.csv")

# Which platform has the highest average engagement rate? By Likes, Shares, comments and impressions per post.
data2 <- data %>%
  mutate(
    total_engagement = likes_count + shares_count + comments_count,
    engagement_rate = total_engagement / impressions
  )

platform <- data2 %>%
  group_by(platform) %>%
  summarise(avg_engagement_rate = mean(engagement_rate, na.rm = TRUE)) %>%
  arrange(desc(avg_engagement_rate))

ggplot(platform, aes(x = reorder(platform, -avg_engagement_rate), y = avg_engagement_rate)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "Average Engagement Rate by Platform",
       x = "Platform",
       y = "Average Engagement Rate") +
  theme_minimal()

# total engagement based on Likes, Shares, comments and impressions per post.

tot_engage <- data %>%
  mutate(total_engagement = likes_count + shares_count + comments_count + impressions)

print(tot_engage)

# Show the platform with the highest average engagement
ave_engage <- tot_engage%>%
  group_by(platform) %>%
  summarise(engagement_rate = mean(total_engagement, na.rm = TRUE)) 

print(ave_engage)

ggplot(ave_engage, aes(x = reorder(platform, engagement_rate), y=engagement_rate)) +
  geom_col(fill = "skyblue") + 
  coord_flip() + 
  labs(title = "Platforms with the Highest Average Engagement",
           x = "Platform",
           y = "Average Total Engagement") +
  theme_minimal()

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

# clean the locations by continent
data_unique <- data %>% distinct(location)
print(data_unique)

# Which locations have the highest average engagement rate? based product, sentiment value and location
loc_data <- data %>%
  mutate(total_engagement = likes_count + shares_count + comments_count) %>%
  group_by(location, topic_category, product_name, brand_name) %>%
  summarise(
    engagement_rate = mean(engagement_rate, na.rm = TRUE),
    mean_sentiment_positive = mean(sentiment_label, na.rm = TRUE),
    mean_sentiment_negative = mean(sentiment_label, na.rm = TRUE),
    total_engagement = sum(total_engagement, na.rm = TRUE),
    .groups = "drop"
  )

top_location <- loc_data %>%
  group_by(location) %>%
  slice_max(order_by = engagement_rate, n = 1) %>%
  ungroup()

print(top_location)
  
plot_ly(
  data = top_location,
  x = ~topic_category,
  y = ~location,
  z = ~engagement_rate,
  type = "heatmap",
  colorscale = "Viridis",
  text = ~paste(
    "Brand: ", brand_name,
    "<br>Product: ", product_name,
    "<br>Engagement Rate: ", round(engagement_rate, 3),
    "<br>Positive Sentiment: ", round(mean_sentiment_positive, 2),
    "<br>Negative Sentiment: ", round(mean_sentiment_negative, 2)
  ),
  hoverinfo = "text"
) %>%
  layout(
    title = "Top Engagement Rate by Location and Topic",
    xaxis = list(title = "Topic Category"),
    yaxis = list(title = "Location")
  )

