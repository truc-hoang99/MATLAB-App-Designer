# MATLAB-App-Designer
# 🌿 Plant Protein Stability Evaluation via Image Analysis

This MATLAB-based tool was developed to evaluate the stability of plant protein formulations using grayscale image intensity tracking — a cost-effective alternative to commercial tools like Turbiscan.

## 📌 Problem
Plant-based protein formulations require stability testing over time. Traditional methods are manual or expensive. This tool allows for automated evaluation using time-lapse images, comparing visual degradation between sample tubes.

## ⚙️ Tools & Techniques
- **Language**: MATLAB  
- **Key Libraries**: Image Processing Toolbox  
- **Functions Used**: `imread`, `imrotate`, `im2gray`, `drawrectangle`, `createMask`, `bsxfun`, `mean`, `diff`, `plot`

## 🧠 Methodology
- Manual ROI selection for 4 tubes using `drawrectangle`  
- Grayscale conversion and region masking for pixel intensity extraction  
- Intensity trends computed per frame, then analyzed over time intervals  
- First derivatives (Δ intensity / Δ time) calculated to quantify degradation  
- Results plotted for both intensity profiles and temporal derivatives

## 🧪 Sample Workflow
1. Load `.tiff` image sequence of plant protein samples
2. Define ROIs (Tube 1–4) and extract pixel-wise grayscale values
3. Track intensity changes at fixed intervals (every 3 hours)
4. Compute first-order derivatives to visualize degradation trends
5. Output plots of intensity vs. distance and derivatives vs. distance

## 📈 Outcome
- Enabled consistent and quantitative tracking of sample stability
- Replaced $25K lab equipment with a replicable academic workflow
- Enhanced visual and analytical evaluation for research in food science

## 📂 File Structure
- `Intensity.m`: Manual selection and ROI grayscale extraction
- `Sweetener_Processed.m`: Automated loop across image frames, derivative calculations
