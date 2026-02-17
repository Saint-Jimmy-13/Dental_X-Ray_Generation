# Synthetic Dental X-Ray Generation and Segmentation Analysis

## 📄 Abstract
Medical image analysis faces critical challenges regarding data scarcity, privacy restrictions, and ethical concerns. In dental radiology, obtaining diverse Orthopantomogram (OPT) datasets is particularly difficult due to strict patient data sensitivity.

This project addresses this bottleneck by implementing a **Generative Adversarial Network (GAN)** pipeline to synthesize realistic, privacy-compliant dental X-rays. We further validate the clinical utility of this synthetic data by training a **YOLOv8 segmentation model**. Our final experiments demonstrate that using GAN-generated images as data augmentation **improves segmentation performance on real patients**, effectively bridging the gap between data scarcity and model robustness.

---

## 💾 Dataset & Preprocessing
**Source:** [Teeth Segmentation on Dental X-ray Images (Kaggle)](https://www.kaggle.com/datasets/humansintheloop/teeth-segmentation-on-dental-x-ray-images/data)

The dataset consists of 598 paired images and segmentation masks.
* **Engineering Contribution:** The original annotations were provided as raw JSON vectors. We implemented a **custom parser** to convert these vectors into **YOLO Format** (Bounding boxes and polygons for the segmentation model).

---

## ⚙️ Methodology & Architecture

### 1. Generative Model (Pix2Pix)
We utilized a conditional GAN framework to translate segmentation masks into realistic X-rays.
* **Generator:** **U-Net** architecture. Our ablation studies proved that **Skip Connections** are mandatory for medical imaging to preserve high-frequency anatomical edges.
* **Discriminator:** **PatchGAN** to force local textural realism.
* **Loss Function:** Adversarial Loss + $L_1$ Reconstruction Loss.

### 2. Post-Processing Analysis
Raw GAN outputs often contain high-frequency "checkerboard" artifacts. We conducted a comparative study to enhance realism:
* ❌ **Sharpening (Unsharp Masking):** Failed. It amplified artifacts, causing segmentation performance to drop significantly.
* ✅ **Denoising (Median Filter):** Succeeded. It smoothed out synthetic grain while preserving tooth structures, restoring segmentation accuracy.

### 3. Segmentation Model (YOLOv8)
* **Model:** YOLOv8-Nano.
* **Strategy:** We tested **Real-Only**, **Synthetic-Only**, and **Mixed-Training** strategies to measure the Domain Gap and the efficacy of Data Augmentation.

---

## 🚀 Usage

### Prerequisites
* Python 3.10+
* NVIDIA GPU (Recommended: RTX 2060 or higher)

```bash
# Clone the repository
git clone https://github.com/Saint-Jimmy-13/Dental_X-Ray_Generation.git

pip install -r requirements.txt

