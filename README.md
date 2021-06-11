# Autoencoder operator

##### Description

The `Autoencoder operator` trains an autoencoder model on the input data.

##### Usage

Input projection|.
---|---
`y-axis`        | numeric, input value 
`row`           | factor, variables 
`column`        | factor, observations 

Input parameters|.
---|---
`hidden_layers`        | comma-separated list describing the hidden layers architecture (e.g. `12, 2, 12` corresponds to 3 layers containing respectively 12, 2 and 12 nodes)
`activ_functions`        |  comma-separated list of activation functions, as many as there are hidden layers (e.g. `relu, linear, relu`)
`optim_type`        | optimizer type
`loss_type`        | loss function type
`n_epochs`        | number of epochs for training

Output relations|.
---|---
`encoded`        | observations scores on each of the embedded layer dimensions
`clusters`        | ID of the highest scoring dimension for each obervation

##### Details

This operator is a wrapper of the `autoencoder` function of the `ANN2` R package.

##### See Also

[nmf_operator](https://github.com/tercen/template_shiny_operator)

