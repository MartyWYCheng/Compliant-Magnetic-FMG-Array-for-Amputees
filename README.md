# FMG Dataset and Analysis Scripts

This document provides instructions for accessing our open-source FMG dataset and running the analysis scripts referenced in our paper. It is intended to help readers reproduce our results and/or apply the data to their own research.

---
### 1. Data Repository Access

The repository contains the following directories:
* `/data_CSV`: Processed data files in .csv format, ready for training in any language.
* `/data_MAT`: Raw and unprocessed data files in MATLAB file formats.
* `/scripts`: Analysis and data processing scripts.
* `/README.md`: Basic repository usage instructions.

---
### 2. Script Usage Instructions

#### Quick Start (Using CSV files)

Navigate to the desired session of a chosen subject in `/data_CSV/SX0X/sessionX`. You will find these files:
* `x_train.csv`: FMG data from the training phase (time step, sensors).
* `y_train.csv`: Class labels from the training phase (time step, classes).
* `x_test.csv`: FMG data from the testing phase (time step, sensors).
* `y_test.csv`: Class labels from the testing phase (time step, classes).

#### MATLAB Data Extraction and Processing

**Prerequisites:** You must have **MATLAB 2024b** or later installed. The following MATLAB toolboxes are also required:
* Statistics and Machine Learning Toolbox
* Signal Processing Toolbox
* Deep Learning Toolbox
* Parallel Computing Toolbox

**Raw Training/Testing Data:**
1. Navigate to the subject's session directory at `/data_MAT/SX0X/sessionX`.
2. Load the data by double-clicking `train_full.mat` or `test_full.mat`, or by typing the load command in the Command Window.
3. Open the `FMG_train` or `FMG_test` variable in the Workspace to view the raw signals (`signals_raw`), filtered and normalized signals (`signals_filtered_normalized`), and class labels (`classes`).
4. For `FMG_test`, real-time neural network output is also shown in vector and array formats.
5. Navigate to `FMG_train{X}.Values.Data` or `FMG_test{X}.Values.Data` to view the data in (time step, sensor/class) dimensions.

**Processed Training Data:**
1. Open `/scripts/processData_01.m` in MATLAB.
2. Set `plot_remove_rest` to `true` to show a plot of the processed FMG signal with rest periods removed.
3. Set `plot_PCA = true` to show PCA-related plots.
4. Click **run** in the editor toolbar.
5. Click **“Add to Path”** in the popup window.
6. Double-click “`signals_reduced`” to access the processed training FMG signals.
7. Double-click “`classes_reduced`” to access the corresponding training class labels.

**Processed Testing Data:**
1. Open and run `/scripts/processData_01.m`.
2. Open and run `/scripts/trainNN_analysis_02.m`.
3. Double-click “`signals_reduced`” to access the processed testing FMG signals.
4. Double-click “`classes_reduced`” to access the corresponding testing class labels.
5. **Troubleshooting**: If variables are missing or undefined when running “`trainNN_analysis_02.m`”, ensure you run “`processData_01.m`” first to generate the required variables.

**Training New Networks:**
1. Follow steps 1-5 in the "Processed Testing Data" section.
2. Set “`trainBool`” and “`gen_nets`” to `true`.
3. Customize training parameters such as “`iterations`” and “`reduction_rate`”.
4. Wait for the network to be trained.
5. The generated network function can be found under “`networks_{X}iterations.mat`”.

---
