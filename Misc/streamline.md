# Streamlit Quick Reference

## 📌 What is Streamlit?
[Streamlit](https://streamlit.io/) is an open-source Python library that makes it easy to build **data-driven web applications** with very little code.  
It is especially useful for quickly creating dashboards and interactive apps from data.  

✅ Simple and useful for **data-driven apps**.

---

## 🚀 Key Features
- Build apps with pure Python (no HTML, CSS, JS required).  
- Widgets for interactivity (sliders, buttons, inputs, etc.).  
- Native support for visualization libraries: Pandas, Matplotlib, Plotly, Altair.  
- Auto-refresh when code changes.  
- Easy cloud deployment options.  

---

## 🌐 Deployment
Yes, Streamlit apps can be deployed to the cloud:  

1. **Streamlit Community Cloud** (free hosting from GitHub).  
   - Docs: [Deploy an app](https://docs.streamlit.io/streamlit-community-cloud/get-started/deploy-an-app)  
2. **Other platforms** – Databricks, Azure.  

---

## 🔗 Documentation Links
- Main Docs: [https://docs.streamlit.io/](https://docs.streamlit.io/)  
- Getting Started: [https://docs.streamlit.io/get-started](https://docs.streamlit.io/get-started)  
- Deployment: [https://docs.streamlit.io/streamlit-community-cloud](https://docs.streamlit.io/streamlit-community-cloud)  

---

## How to run - 
`streamlit run app.py`

## 📝 Example (Minimal App)
```python
import streamlit as st
import pandas as pd

st.title("My First Streamlit App")
st.write("Hello, Streamlit!")

data = pd.DataFrame({
    "Numbers": [1, 2, 3, 4, 5],
    "Squares": [1, 4, 9, 16, 25]
})
st.line_chart(data)
