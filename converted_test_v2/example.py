import pandas as pd

df = pd.read_csv("converted_test_v2/Schwarzenbach - Kaltenbrunn_87550PG_8755QQ0010A_19761231001000_19770113182000.csv")
df.columns = ["timestamp", "value", "status"]
df.head()
