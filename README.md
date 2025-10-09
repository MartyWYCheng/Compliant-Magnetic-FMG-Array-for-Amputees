# Compliant Magnetic FMG Array Dataset

This repository provides the open-source **Force Myogram (FMG) dataset** referenced in our paper, "**Compliant Magnetic Sensor Arrays Enable Real-Time Force Myogram Pattern Recognition for Dexterous Hand Control by Amputees**".

It is intended to help readers reproduce our results and/or apply the data to their own research.

---

## 1. Citation

If you use the provided data or scripts, please cite the main paper as follows:

[Citation pending]

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
3.  Execute the following command, replacing `[COPIED LINK]` with the HTTPS link from the "**Code**" button on the repository page:
    ```bash
    git clone https://github.com/MartyWYCheng/Compliant-Magnetic-FMG-Array-for-Amputees.git
    ```

### Download as ZIP

1.  Click the green "**Code**" button on the repository page.
2.  Select "**Download ZIP**" from the drop-down menu.
3.  Extract the downloaded ZIP file to access all files.

---

## 3. Repository Contents and Usage

### /data\_CSV: Ready-to-train Data

* **Format:** `.csv` files.
* Includes training and testing data for each subject.
* **Data Processing:** FMG data (`x_train`, `x_test`) has been **filtered** (gain = 10, time constant of $\tau=110$ s) and **bias-corrected**.
* Rest periods have been removed.
* FMG data for certain gestures has been replaced (if replacement data exists for the particular subject’s session).

#### Script Usage Instructions for CSV Files:

Navigate to the desired session of a chosen subject in `/data_CSV/SX0X/sessionX`.

* `x_train.csv`: FMG data from the training phase (time step, sensors).
* `y_train.csv`: Class labels from the training phase (time step, classes).
* `x_test.csv`: FMG data from the testing phase (time step, sensors).
* `y_test.csv`: Class labels from the testing phase (time step, classes).

### /data\_MAT: Raw and Filtered Data

* **Format:** **MATLAB** file formats (`.mat`).
* Includes the session FMG data from each trial of each session of each subject.
* **Note:** Rest periods were **not** removed from these files.
* Each dataset includes:
    * `signals_raw`: Raw **unfiltered** FMG data.
    * `signals_filtered_normalized`: **Filtered and bias corrected** FMG data.
    * `classes`: Class labels.

#### Script Usage Instructions for MATLAB Files:

1.  Preserve the folder structure when downloading/extracting the repository.
2.  Navigate to the subject's session directory: `/data_MAT/SX0X/sessionX`.
3.  Load the data by double-clicking `train_full.mat` or `test_full.mat` in the file explorer, or by entering the following in the MATLAB Command Window:
    ```matlab
    load(“train_full.mat”)
    % OR
    load(“test_full.mat”)
    ```
4.  Open the **FMG\_train** or **FMG\_test** variable in the Workspace to view the raw signals (`signals_raw`), filtered/bias-corrected signals (`signals_filtered_normalized`), and class labels (`classes`) of the full session.
5.  Navigate to `FMG_train{X}.Values.Data` or `FMG_test{X}.Values.Data` to view the data in (**time step, sensor/class**) dimensions.
6.  Selecting all values and plotting them will show a visual representation of the signals over the whole session.
7.  Replacement data for certain gestures for a few subjects is also included in the **replacements** folder.


