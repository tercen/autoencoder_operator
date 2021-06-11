library(tercen)
library(dplyr)
library(ANN2)

minmax <- function(x) { return((x- min(x)) /(max(x)-min(x))) }

ctx <- tercenCtx()
df <- ctx$as.matrix() %>% t
colnames(df) <- ctx$rselect()[[1]]
df <- df %>% as_tibble
df <- as_tibble(lapply(df, minmax))

hidden_layers <- ifelse(
  !is.null(ctx$op.value('hidden_layers')),
  as.character(ctx$op.value('hidden_layers')),
  "32, 2, 32"
)
hidden_layers <- as.numeric(trimws(strsplit(hidden_layers, ",")[[1]]))

activ_functions <- ifelse(
  !is.null(ctx$op.value('activ_functions')),
  as.character(ctx$op.value('activ_functions')),
  "relu, linear, relu"
)

optim_type <- ifelse(
  !is.null(ctx$op.value('optim_type')),
  as.character(ctx$op.value('optim_type')),
  "adam"
)

loss_type <- ifelse(
  !is.null(ctx$op.value('loss_type')),
  as.character(ctx$op.value('loss_type')),
  "squared"
)

n_epochs <- ifelse(
  !is.null(ctx$op.value('n_epochs')),
  as.numeric(ctx$op.value('n_epochs')),
  30
)

ac <- autoencoder(
  df,
  hidden.layers = hidden_layers,
  standardize = TRUE,
  activ.functions = activ_functions,
  optim.type = optim_type,
  loss.type = loss_type,
  n.epochs = n_epochs
)

encoded <- encode(ac, df)
clusters <- max.col(encoded, ties.method = "first")

df_out <- list(
  encoded,
  clusters = clusters,
  .ci = 0:(length(clusters) - 1)
) %>% 
  as.data.frame() %>%
  ctx$addNamespace() %>%
  ctx$save()
