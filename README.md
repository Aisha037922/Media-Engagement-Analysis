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
