
Python FAQ
----------
* How to address certificate issues with module installations
    -   Use trusted hosts to address the issue - `--trusted-host pypi.org --trusted-host files.pythonhosted.org`
    -   example: `pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org  --pre azure-cosmos`
    -   Example2: Install pyarrow package- `pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org --pre pyarrow`

* What is most easy way to start with Python with no installaion or anything 
    -    Colaboratory, or "Colab" for short, allows you to write and execute Python in your browser, with - https://colab.research.google.com/

* Example of dataset joins 
    -   `https://www.datasciencemadesimple.com/join-merge-data-frames-pandas-python/ `

* Example of using join on Data Frames 
* ```
%python
import pandas as pd
import numpy as np
 
# data frame 1
d1 = {'Customer_id':pd.Series([1,2,3,4,5,6]),
  'Product':pd.Series(['Oven','Oven','Oven','Television','Television','Television'])}
df1 = pd.DataFrame(d1)
 
 

d2 = {'Customer_id':pd.Series([2,4,6,7,8]),
    'State':pd.Series(['California','California','Texas','New York','Indiana'])}
df2 = pd.DataFrame(d2)


inner_join_df= pd.merge(df1, df2, on='Customer_id', how='outer')

inner_join_df.sample()
```
