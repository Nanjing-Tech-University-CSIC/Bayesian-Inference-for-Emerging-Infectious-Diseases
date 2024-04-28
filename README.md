# Bayesian-Inference-for-Emerging-Infectious-Diseases

## Requirements

- Install [MATLAB](https://ww2.mathworks.cn/products/matlab.html), and version no less than 2021b

## Code

The file Main.m is the entry point for the entire method, and if you want to surface the experiment, you need to make the following changes：

```matlab
[num]=readmatrix('./model/data/ir_data.xlsx');
case_list=num(11:25,2);
.......
populations=11000000;
```

1. When performing code reproduction, the data source where the method is loaded needs to be modified first (simulation experiments, Nanjing, Wuhan and Shanghai)
2. Modify the data range according to the different data sources, as the data sources contain a wide range of time series that need to be loaded on demand. In the simulation experiments, we used 7, 8, 9, and 15 days for several trials; in the real epidemic experiment in Nanjing, we chose the data from July 20, 2021 to July 27, 2021; in the Wuhan epidemic experiment, the data were dated from December 8, 2019 to January 6, 2020; and in the Shanghai epidemic experiment, this date was from March 1, 2022 to March 10, 2022
3. Modifying the population of the projected area, the simulation and Wuhan experiments should be set to 11,000,000 for Wuhan, 9,650,000 for Nanjing, and 24,900,000 for Shanghai.
4. Modify the relevant a priori distributions in the getThetaDensity.m file

## Result

Detailed result data for the experiments described in the text can be viewed in the [results](https://github.com/Nanjing-Tech-University-CSIC/Bayesian-Inference-for-Emerging-Infectious-Diseases/tree/main/result) folder

- [simulation experiment](https://github.com/Nanjing-Tech-University-CSIC/Bayesian-Inference-for-Emerging-Infectious-Diseases/tree/main/result/simulation%20experiment%20)
- [nanjing](https://github.com/Nanjing-Tech-University-CSIC/Bayesian-Inference-for-Emerging-Infectious-Diseases/tree/main/result/nanjing)
- [wuhan](https://github.com/Nanjing-Tech-University-CSIC/Bayesian-Inference-for-Emerging-Infectious-Diseases/tree/main/result/wuhan)
- [shanghai](https://github.com/Nanjing-Tech-University-CSIC/Bayesian-Inference-for-Emerging-Infectious-Diseases/tree/main/result/shanghai)
- [robustness](https://github.com/Nanjing-Tech-University-CSIC/Bayesian-Inference-for-Emerging-Infectious-Diseases/tree/main/result/robustness)
- [length of the observational time series](https://github.com/Nanjing-Tech-University-CSIC/Bayesian-Inference-for-Emerging-Infectious-Diseases/tree/main/result/length%20of%20the%20observational%20time%20series)