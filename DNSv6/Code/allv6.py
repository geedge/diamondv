'''
    用于将多个NS端pcap导出结果进行合并（另一种方法是将pcap文件合并后再导出）
'''
import pandas as pd

# 结果保存位置
res_path="./result/v6/allv6dns.csv"
# 创建结果文件
allip=pd.DataFrame(columns=["IPv6","Count"])
allip.to_csv("./result/v6/allv6dns.csv",encoding='gbk', header=True, index=False)

for i in range(5):
    # 资源路径
    path="./result/v6/v6-"+str(i+1)+".csv"
    ip_datas=pd.read_csv(path,skiprows=2,names=["level","parent","IPv6","count","ave","min","max","rate","per","BR","BS"])
    data = ip_datas.iloc[1:, [2,3]]
    data.to_csv(res_path,mode="a", encoding='gbk', header=False, index=False)



