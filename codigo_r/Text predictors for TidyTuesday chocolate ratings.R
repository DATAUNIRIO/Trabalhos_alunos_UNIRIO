# Text predictors for #TidyTuesday chocolate ratings
# https://juliasilge.com/blog/chocolate-ratings/
# https://juliasilge.com/blog/austin-housing/
# https://juliasilge.com/blog/netflix-titles/


library(tidyverse)
url <- "https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-01-18/chocolate.csv"
chocolate <- read_csv(url)

chocolate %>%
  ggplot(aes(rating)) +
  geom_histogram(bins = 15)

library(tidytext)

tidy_chocolate <-
  chocolate %>%
  unnest_tokens(word, most_memorable_characteristics)

tidy_chocolate %>%
  count(word, sort = TRUE)

tidy_chocolate %>%
  group_by(word) %>%
  summarise(
    n = n(),
    rating = mean(rating)
  ) %>%
  ggplot(aes(n, rating)) +
  geom_hline(
    yintercept = mean(chocolate$rating), lty = 2,
    color = "gray50", size = 1.5
  ) +
  geom_jitter(color = "midnightblue", alpha = 0.7) +
  geom_text(aes(label = word),
            check_overlap = TRUE, family = "IBMPlexSans",
            vjust = "top", hjust = "left"
  ) +
  scale_x_log10() +
  xlab("quantidade de vezes que é citado")+
  ylab("avaliação em uma escala de 1 a 5")
# balanced chocolate is good, but burnt, pastey chocolate is bad.

#-----------------------------------------------------------------------

library(tidymodels)

set.seed(123)
choco_split <- initial_split(chocolate, strata = rating)
choco_train <- training(choco_split)
choco_test <- testing(choco_split)

set.seed(234)
choco_folds <- vfold_cv(choco_train, strata = rating)
choco_folds


#  We will need to transform our text data into features useful for our model by tokenizing and computing (in this case) tf-idf.
library(textrecipes)

choco_rec <-
  recipe(rating ~ most_memorable_characteristics, data = choco_train) %>%
  step_tokenize(most_memorable_characteristics) %>%
  step_tokenfilter(most_memorable_characteristics, max_tokens = 100) %>%
  step_tfidf(most_memorable_characteristics)

## just to check this works
prep(choco_rec) %>% bake(new_data = NULL)

#---------------------------------------------------------------------------

#Now let’s create two model specifications to compare. 
# Random forests are not known for performing well with natural language predictors, but this dataset involves very short text descriptions so let’s give it a try. Support vector machines do tend to work well with text data so let’s include that one too.

rf_spec <-
  rand_forest(trees = 500) %>%
  set_mode("regression")

rf_spec

svm_spec <-
  svm_linear() %>%
  set_mode("regression")

svm_spec

#Now it’s time to put the preprocessing and model together in a workflow().
#The SVM requires the predictors to all be on the same scale, but all our predictors are now tf-idf values so we should be pretty much fine.

svm_wf <- workflow(choco_rec, svm_spec)
rf_wf <- workflow(choco_rec, rf_spec)

#Evaluate models
#These workflows have no tuning parameters so we can evaluate them as they are. (Random forest models can be tuned but they tend to work fine with the defaults as long as you have enough trees.)

contrl_preds <- control_resamples(save_pred = TRUE)

svm_rs <- fit_resamples(
  svm_wf,
  resamples = choco_folds,
  control = contrl_preds
)

ranger_rs <- fit_resamples(
  rf_wf,
  resamples = choco_folds,
  control = contrl_preds
)

#How did these two models compare?
collect_metrics(svm_rs)
collect_metrics(ranger_rs)
#We can visualize these results by comparing the predicted rating with the true rating:

bind_rows(
  collect_predictions(svm_rs) %>%
    mutate(mod = "SVM"),
  collect_predictions(ranger_rs) %>%
    mutate(mod = "ranger")
) %>%
  ggplot(aes(rating, .pred, color = id)) +
  geom_abline(lty = 2, color = "gray50", size = 1.2) +
  geom_jitter(width = 0.5, alpha = 0.5) +
  facet_wrap(vars(mod)) +
  coord_fixed()

# These models are not great but they perform pretty similarly, so perhaps we would choose the faster-to-train, linear SVM model. The function last_fit() fits one final time on the training data and evaluates on the testing data. This is the first time we have used the testing data.

final_fitted <- last_fit(svm_wf, choco_split)
collect_metrics(final_fitted) ## metrics evaluated on the *testing* data

#This object contains a fitted workflow that we can use for prediction.

final_wf <- extract_workflow(final_fitted)
predict(final_wf, choco_test[55, ])

predict(final_wf, choco_test[5, ])

#You can save this fitted final_wf object to use later with new data, for example with readr::write_rds().
#One nice aspect of using a linear model is that we can directly inspect the coefficients for each term. Which words are more associated with high ratings vs. low ratings?
  
extract_workflow(final_fitted) %>%
  tidy() %>%
  filter(term != "Bias") %>%
  group_by(estimate > 0) %>%
  slice_max(abs(estimate), n = 10) %>%
  ungroup() %>%
  mutate(term = str_remove(term, "tfidf_most_memorable_characteristics_")) %>%
  ggplot(aes(estimate, fct_reorder(term, estimate), fill = estimate > 0)) +
  geom_col(alpha = 0.8) +
  scale_fill_discrete(labels = c("low ratings", "high ratings")) +
  labs(y = NULL, fill = "More from...")
