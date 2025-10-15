# Compliant Magnetic FMG Array Dataset

This repository provides the open-source **Force Myogram (FMG) dataset** referenced in our paper, "**Compliant Magnetic Sensor Arrays Enable Real-Time Force Myogram Pattern Recognition for Dexterous Hand Control by Amputees**".

It is intended to help readers reproduce our results and/or apply the data to their own research.

---

## 1. Citation

If you use the provided data or scripts, please cite the main paper as follows:
Cheng, W., & Engeberg, E. D.
"Compliant Magnetic Sensor Arrays Enable Real-Time Force Myogram Pattern Recognition for Dexterous Hand Control by Amputees."

Zenodo, 2025. DOI: 

<img width="191" height="20" alt="image" src="https://github.com/user-attachments/assets/07c5169e-0d8d-4d6b-be66-7bb50350732c" />


---

## 1. Data Repository Access

* **Repository Location:** https://github.com/MartyWYCheng/Compliant-Magnetic-FMG-Array-for-Amputees
* **Version:** 1.0 (October 1, 2025)
* **License:** This dataset and associated scripts are licensed under a **Creative Commons Attribution 4.0 International (CC BY 4.0) license**.
* **Authors:** Wen-Yu Cheng, Erik D. Engeberg
    * Wen-Yu Cheng: Department of Electrical Engineering and Computer Science, Florida Atlantic University, Boca Raton, FL, USA. (Email: wcheng2014@fau.edu)
    * Erik D. Engeberg: Department of Ocean and Mechanical Engineering, Department of Biomedical Engineering, and Center for Complex Systems, Florida Atlantic University, Boca Raton, FL, USA. (Email: eengeberg@fau.edu)

---

## 2. Download Instructions

### Clone Repository (Recommended)

1.  Ensure you have **Git** installed.
2.  Open your terminal or Git Bash.
3.  Navigate to the desired directory to store the dataset.
4.  Execute the following command, replacing `[COPIED LINK]` with the HTTPS link from the "**Code**" button on the repository page:
    ```bash
    git clone https://github.com/MartyWYCheng/Compliant-Magnetic-FMG-Array-for-Amputees.git
    ```

### Download as ZIP

1.  Click the green "**Code**" button on the repository page.
2.  Select "**Download ZIP**" from the drop-down menu.
3.  Extract the downloaded ZIP file to access all files.

---

## 3. Repository Contents and Structure

The repository contains two primary data formats: pre-processed, ready-to-train data in CSV format, and raw/filtered session data in MATLAB format.

* `/data_CSV`: **Ready-to-train data files** in `.csv` format.
    * Includes training (`x_train.csv`, `y_train.csv`) and testing (`x_test.csv`, `y_test.csv`) data for each subject.
    * **Data Processing:** FMG data (`x_train`, `x_test`) has been **filtered** (gain = 10, time constant of $\tau=110$ s), **bias-corrected**, and has **rest periods removed**.
* `/data_MAT`: **Raw and processed session data** in MATLAB file formats (`.mat`).
    * * Includes data from each trial of each session of each subject.
    * * `/replacements`: Contains replacement data for certain gestures for a few subjects.
    * **Note:** Rest periods were **not** removed from these files.
    * Each dataset includes: `signals_raw` (Raw unfiltered FMG data), `signals_filtered_normalized` (Filtered and bias corrected FMG data), and `classes` (Class labels).
* `/README.md`: Basic repository usage instructions.


---

## 4. Usage Instructions

### Accessing CSV Files (Ready-to-Train)

1.  Navigate to the desired session of a chosen subject: `/data_CSV/SX0X/sessionX`.
2.  Files are dimensioned as (**time step, sensors**) for FMG data and (**time step, classes**) for class labels:
    * `x_train.csv`: FMG data from the training phase.
    * `y_train.csv`: Class labels from the training phase.
    * `x_test.csv`: FMG data from the testing phase.
    * `y_test.csv`: Class labels from the testing phase.

### Accessing MATLAB Files (Raw and Processed)

1.  Navigate to the subject's session directory: `/data_MAT/SX0X/sessionX`.
2.  Load the full session data by double-clicking `train_full.mat` or `test_full.mat` in the file explorer, or use the Command Window:
    ```matlab
    load(“train_full.mat”)
    % OR
    load(“test_full.mat”)
    ```
3.  View the data variables (raw signals, filtered signals, and class labels) in the `FMG_train` or `FMG_test` variable in the Workspace.
4.  Data dimensions are accessed via `FMG_train{X}.Values.Data` or `FMG_test{X}.Values.Data` in (**time step, sensor/class**) format.

