df = read.csv("converted_test_v2/Schwarzenbach - Kaltenbrunn_87550PG_8755QQ0010A_19761231001000_19770113182000.csv")
names(df) <- c("timestamp", "value", "status")
head(df)
