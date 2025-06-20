# Social Media Engagement Analysis

#### Intro

------------------------------------------------------------------------

To analyze social media engagement across Reddit, Twitter (X), YouTube, Facebook, and Instagram, identifying how user interactions vary by platform, content type, and demographic factors. The goal is to uncover actionable insights that explain what drives higher engagement and inform effective content strategies.

#### Goals

------------------------------------------------------------------------

The primary goal of this project is to deepen my understanding of what drives social media engagement by analyzing user interactions across major platforms such as Reddit, Twitter (X), YouTube, Facebook, and Instagram. Specifically, I aim to understand if the time when posts are published plays a significant role in the engagement rate and the sentimental value of the content, while also taking into account users’ behaviors such as how often they comment, share, or react. By examining patterns in engagement and sentiment, I hope to identify which factors including timing, user activity, and even geographic location most influence how audiences interact with content, ultimately helping to inform more effective social media strategies.

#### Key Questions Analyzed

------------------------------------------------------------------------

**Which platform has the highest average engagement rate?**

```         
tot_engage <- data %>%
  mutate(total_engagement = likes_count + shares_count + comments_count + impressions)

ave_engage <- tot_engage%>%
  group_by(platform) %>%
  summarise(engagement_rate = mean(total_engagement, na.rm = TRUE)) 

print(ave_engage)
```

**What day of the week sees the highest average engagement rate across platforms?**

```         
post_time_engage <- data %>%
  group_by(day_of_week) %>%
  summarise(ave_engage = mean(engagement_rate, na.rm = TRUE))

print(post_time_engage)
```

**Is there a best time to post on each platform? Highest impressions, by time and platform?**

```         
best_time <- data %>%
  mutate(hour = hour(timestamp)) %>%
  group_by(timestamp) %>%
  summarise(impressions = mean(impressions, na.rm = TRUE)) %>%
  arrange(platform, desc(avg_impressions))

print(best_time)
```

------------------------------------------------------------------------

### **Audience & Demographic Insight**

**Which locations (cities or countries) have the highest average engagement rate?**

```         
loc_av <- data %>%
  group_by(location, topic_category, product_name, brand_name) %>%
  summarise(engagement_rate = mean(engagement_rate, na.rm = TRUE)) %>%
  arrange(desc(engagement_rate)) %>%
  slice(1)

print(loc_av)
```

------------------------------------------------------------------------

### **User Behavior & Growth**

How does user_past_sentiment_avg impact current post sentiment or engagement?

```         
senti_level <- data %>% 
  group_by(sentiment_label, emotion_type, user_engagement_growth, user_past_sentiment_avg, engagement_rate) %>%
  summarise(user_past_sentiment_avg = mean(user_past_sentiment_avg, na.rm = TRUE)) %>%
  arrange(desc(user_past_sentiment_avg)) %>%
  slice(1)

print(senti_level)
```

------------------------------------------------------------------------

### **Trend & Campaign Insights**

Which campaign or brand shows the most positive buzz change rate over time?

```         
campa_brand <- data %>%
  group_by(brand_name, product_name, campaign_name, campaign_phase) %>%
  summarise(sentiment_score = mean(campaign_name, na.rm = TRUE)) %>% 
  arrange(desc(sentiment_score)) %>%
  slice(1)

print(campa_brand)
```

------------------------------------------------------------------------

#### **Key Findings**

The analysis across Reddit, Twitter (X), YouTube, Facebook, and Instagram revealed that **Instagram and YouTube consistently show the highest average engagement rates**, especially due to their visual and interactive content formats. Engagement tends to peak **midweek**, particularly on **Wednesdays and Thursdays**, with **peak engagement hours between 12 PM and 3 PM**, although Reddit and YouTube also perform well in the **evening hours**. Locations such as **New York, London, and Toronto** typically digitally savvy and highly connected show the highest engagement rates, especially for content in the **Food and Tech** categories. Posts associated with **positive sentiment and emotions** like *joy* and *trust* receive more engagement on average. Furthermore, users with a history of positive sentiment are more likely to engage with new posts. Brands running multipurpose **campaigns** especially in the Tech sector achieved higher engagement and sentiment scores over time.

------------------------------------------------------------------------

#### **Conclusion**

This analysis shows that **platform choice, post timing, sentiment, and geography** significantly influence engagement. Visual and emotionally driven content performs better, and campaigns that evolve over time sustain attention more effectively. Ultimately, a data-informed content strategy can increase user engagement and improve brand presence across platforms.

This analysis is subject to several limitations. First, the dataset does not account for the effects of platform algorithms, paid promotions, or changes in visibility mechanics, which can significantly impact engagement metrics. Sentiment analysis relies on predefined labels, potentially overlooking sarcasm, mixed emotions, or context-specific language. Additionally, engagement metrics were not normalized by follower count or audience size, which could skew comparisons between platforms with different user bases. There may also be inconsistencies in time zone reporting within the time stamp data, affecting the accuracy of time-based engagement insights. Finally, as the dataset represents a historical snapshot, it may not fully reflect evolving user behaviors or platform trends.
