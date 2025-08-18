# Synthetic Dental X-Ray Generation and Segmentation Analysis

#### **Abstract**: Medical image analysis faces challenges like data scarcity, privacy restrictions, and ethical concerns. In dental radiology, obtaining diverse ortopanoramic X-ray (OPT) datasets is particularly difficult due to patient data sensitivity. This project trains a Generative Adversarial Network (GAN) to synthesize realistic OPT images and evaluates their effectiveness by training a CNN-based segmentation model on a public dental dataset. The final phase tests the segmentation model on both real and synthetic images to assess performance gaps, biases, and the usability of GAN-generated data in medical imaging.

###### **Dataset**: Public dental X-ray segmentation dataset (Teeth Segmentation)

###### **Task**: This project has two primary objectives: (1) developing a GAN model to generate synthetic ortopanoramic dental X-ray images, and (2) training and evaluating a YOLO-based segmentation model on real and synthetic datasets. The main focus is to assess how well a segmentation model trained on real data generalizes to synthetic images and to identify its potential limitations. The students will experiment with different GAN architectures and training strategies to improve the realism of the generated images. They will also analyze segmentation performance differences when applying CNN models to real vs. synthetic X-rays.

